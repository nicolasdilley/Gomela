package main

import (
	"fmt"
	"sync"
)

func NewLoadBalancer(c *config.ExtensionConfig, client *client.Client) (*LoadBalancer, error) {
	if c.TemplatePath != "" {
		if _, err := os.Stat(c.TemplatePath); os.IsNotExist(err) {
			log().Errorf("Missing %s configuration template: file=%s", c.Name, c.TemplatePath)
			log().Errorf("Use the TemplatePath option in your Interlock config.toml to set a custom location for the %s configuration template", c.Name)
			log().Errorf("Examples of an configuration template: url=https://github.com/ehazlett/interlock/tree/master/docs/examples/%s", c.Name)
			log().Fatal(err)
		} else {
			log().Debugf("using configuration template: file=%s", c.TemplatePath)
		}
	} else {
		log().Debugf("using internal configuration template")
	}

	// parse config base dir
	c.ConfigBasePath = filepath.Dir(c.ConfigPath)

	errChan = make(chan error)
	go func() {
		for err := range errChan {
			log().Error(err)
		}
	}()

	lbUpdateChan = make(chan bool)

	proxyNetworkCleanupChan = make(chan []proxyContainerNetworkConfig)

	cache, err := ttlcache.NewTTLCache(ReloadThreshold)
	if err != nil {
		return nil, err
	}

	cache.SetCallback(func(k string, v interface{}) {
		log().Debugf("triggering reload from cache")
		lbUpdateChan <- true
	})

	// load containerID for the following nodeID
	containerID, err := utils.GetContainerID()
	if err != nil {
		return nil, err
	}

	log().Infof("interlock node: container id=%s", containerID)

	extension := &LoadBalancer{
		cfg:    c,
		client: client,
		cache:  cache,
		lock:   &sync.Mutex{},
		nodeID: containerID,
	}

	// select backend
	switch c.Name {
	case "haproxy":
		p, err := haproxy.NewHAProxyLoadBalancer(c, client)
		if err != nil {
			return nil, fmt.Errorf("error setting backend: %s", err)
		}
		extension.backend = p
	case "nginx":
		p, err := nginx.NewNginxLoadBalancer(c, client)
		if err != nil {
			return nil, fmt.Errorf("error setting backend: %s", err)
		}
		extension.backend = p
	default:
		return nil, fmt.Errorf("unknown load balancer backend: %s", c.Name)
	}

	// proxy network cleanup chan
	// this waits for a reload event and removes the proxy containers
	// from unused proxy networks
	go func() {
		for {
			nc := <-proxyNetworkCleanupChan

			log().Debug("checking to remove proxy containers from networks")

			for _, c := range nc {
				cID := c.ContainerID
				cnt, err := client.ContainerInspect(context.Background(), cID)
				if err != nil {
					log().Errorf("error inspecting proxy container: id=%s err=%s", cID, err)
					continue
				}

				for net, _ := range cnt.NetworkSettings.Networks {
					// HACK?: special ignore case for bridge
					if net == "bridge" {
						continue
					}

					if _, ok := c.ProxyNetworks[net]; !ok {
						// attempt to disconnect
						log().Debugf("disconnecting proxy container from network: id=%s net=%s", cID, net)

						retries := 5
						for i := 0; i < retries; i++ {
							err := client.NetworkDisconnect(context.Background(), net, cID, false)
							if err == nil {
								break
							}

							log().Warnf("unable to disconnect proxy container %s from network %s (retrying): %s", cID, net, err)

							// wait for network to disconnect
							time.Sleep(2 * time.Second)
						}
					}

				}
			}
		}
	}()

	// lbUpdateChan handler
	go func() {
		for range lbUpdateChan {
			log().Debug("checking to reload")
			if v := extension.cache.Get("reload"); v != nil {
				log().Debug("skipping reload: too many requests")
				continue
			}

			start := time.Now()

			log().Debug("updating load balancers")

			optFilters := filters.NewArgs()
			optFilters.Add("status", "running")
			optFilters.Add("label", "interlock.hostname")
			opts := types.ContainerListOptions{
				All:     false,
				Size:    false,
				Filters: optFilters,
			}
			log().Debug("getting container list")
			containers, err := client.ContainerList(context.Background(), opts)
			if err != nil {
				errChan <- err
				continue
			}

			// generate proxy config
			log().Debug("generating proxy config")
			cfg, err := extension.backend.GenerateProxyConfig(containers)
			if err != nil {
				errChan <- err
				continue
			}

			// save proxy config
			configPath := extension.backend.ConfigPath()
			log().Debugf("proxy config path: %s", configPath)

			proxyNetworks := map[string]string{}

			proxyContainers, err := extension.ProxyContainers(extension.backend.Name())
			if err != nil {
				errChan <- err
				continue
			}

			// save config
			log().Debug("saving proxy config")
			if err := extension.SaveConfig(configPath, cfg, proxyContainers); err != nil {
				errChan <- err
				continue
			}

			// connect to networks
			switch extension.backend.Name() {
			case "nginx":
				proxyConfig := cfg.(*nginx.Config)
				proxyNetworks = proxyConfig.Networks
			case "haproxy":
				proxyConfig := cfg.(*haproxy.Config)
				proxyNetworks = proxyConfig.Networks
			default:
				errChan <- fmt.Errorf("unable to connect to networks; unknown backend: %s", extension.backend.Name())
				continue
			}

			proxyContainerNetworkConfigs := []proxyContainerNetworkConfig{}

			for _, cnt := range proxyContainers {
				proxyContainerNetworkConfigs = append(proxyContainerNetworkConfigs, proxyContainerNetworkConfig{
					ContainerID:   cnt.ID,
					ProxyNetworks: proxyNetworks,
				})
				for net, _ := range proxyNetworks {
					if _, ok := cnt.NetworkSettings.Networks[net]; !ok {
						log().Debugf("connecting proxy container %s to network %s", cnt.ID, net)

						// connect
						if err := client.NetworkConnect(context.Background(), net, cnt.ID, &ntypes.EndpointSettings{}); err != nil {
							log().Warnf("unable to connect container %s to network %s: %s", cnt.ID, net, err)
							continue
						}
					}
				}
			}

			// get interlock nodes
			nodeFilters := filters.NewArgs()
			nodeFilters.Add("status", "running")
			nodeFilters.Add("label", ext.InterlockAppLabel)
			nodeOpts := types.ContainerListOptions{
				All:     false,
				Size:    false,
				Filters: nodeFilters,
			}

			log().Debug("getting interlock container list")
			interlockNodes, err := client.ContainerList(context.Background(), nodeOpts)
			if err != nil {
				errChan <- err
				continue
			}

			proxyContainersToRestart := extension.proxyContainersToRestart(interlockNodes, proxyContainers)

			// trigger reload
			log().Debug("signaling reload")

			// pause to ensure file write sync
			time.Sleep(time.Millisecond * 1000)
			if err := extension.backend.Reload(proxyContainersToRestart); err != nil {
				log().Error(err)
				errChan <- err
				continue
			}

			d := time.Since(start)
			duration := float64(d.Seconds() * float64(1000))

			//log().Debug("triggering proxy network cleanup")
			//proxyNetworkCleanupChan <- proxyContainerNetworkConfigs

			log().Infof("reload duration: %0.2fms", duration)
		}
	}()

	return extension, nil
}
