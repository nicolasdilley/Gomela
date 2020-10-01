package main

import "sync"

func FindAll() []P {
	const concurrencyProcesses = 10 // limit the maximum number of concurrent reading process tasks
	pss, err := ps.Processes()
	if err != nil {
		return nil
	}

	var wg sync.WaitGroup
	wg.Add(len(pss))
	found := make(chan P)
	limitCh := make(chan struct{}, concurrencyProcesses)

	for _, pr := range pss {
		limitCh <- struct{}{}
		pr := pr
		go func() {
			defer func() { <-limitCh }()
			defer wg.Done()

			path, version, agent, ok, err := isGo(pr)
			if err != nil {
				// TODO(jbd): Return a list of errors.
			}
			if !ok {
				return
			}
			found <- P{
				PID:          pr.Pid(),
				PPID:         pr.PPid(),
				Exec:         pr.Executable(),
				Path:         path,
				BuildVersion: version,
				Agent:        agent,
			}
		}()
	}
	go func() {
		wg.Wait()
		close(found)
	}()
	var results []P
	for p := range found {
		results = append(results, p)
	}
	return results
}
