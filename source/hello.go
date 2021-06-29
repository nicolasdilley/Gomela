package main

type Test struct {
	a int
	b int
}

func Discover(ctx context.Context, renewal, timeout time.Duration) []nat.Device {
	var results []nat.Device

	interfaces, err := net.Interfaces()
	if err != nil {
		l.Infoln("Listing network interfaces:", err)
		return results
	}

	resultChan := make(chan nat.Device)

	wg := &sync.WaitGroup{}

	for _, intf := range interfaces {
		// Interface flags seem to always be 0 on Windows
		if runtime.GOOS != "windows" && (intf.Flags&net.FlagUp == 0 || intf.Flags&net.FlagMulticast == 0) {
			continue
		}

		for _, deviceType := range []string{"urn:schemas-upnp-org:device:InternetGatewayDevice:1", "urn:schemas-upnp-org:device:InternetGatewayDevice:2"} {
			wg.Add(1)
			go func(intf net.Interface, deviceType string) {
				//discover(ctx, &intf, deviceType, timeout, resultChan)
				wg.Done()
			}(intf, deviceType)
		}
	}

	go func() {
		wg.Wait()
		close(resultChan)
	}()

	seenResults := make(map[string]bool)

	for {
		select {
		case result, ok := <-resultChan:
			if !ok {
				return results
			}
			if seenResults[result.ID()] {
				l.Debugf("Skipping duplicate result %s", result.ID())
				continue
			}

			results = append(results, result)
			seenResults[result.ID()] = true

			l.Debugf("UPnP discovery result %s", result.ID())
		case <-ctx.Done():
			return nil
		}
	}
}
