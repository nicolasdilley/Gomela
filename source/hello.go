package main

import (
	"fmt"
	"sync"
)
func (s *Server) sendMetrics(ctx context.Context, mlist *forwardrpc.MetricList) error {
	span, _ := trace.StartSpanFromContext(ctx, "veneur.opentracing.proxysrv.send_metrics")
	defer span.ClientFinish(s.opts.traceClient)

	if s.opts.forwardTimeout > 0 {
		var cancel func()
		ctx, cancel = context.WithTimeout(ctx, s.opts.forwardTimeout)
		defer cancel()
	}
	metrics := mlist.Metrics
	span.Add(ssf.Count("proxy.metrics_total", float32(len(metrics)), globalProtocolTags))

	var errs forwardErrors

	dests := make(map[string][]*metricpb.Metric)
	for _, metric := range metrics {
		dest, err := s.destForMetric(metric)
		if err != nil {
			errs = append(errs, forwardError{err: err, cause: "no-destination",
				msg: "failed to get a destination for a metric", numMetrics: 1})
		} else {
			// Lazily initialize keys in the map as necessary
			if _, ok := dests[dest]; !ok {
				dests[dest] = make([]*metricpb.Metric, 0, 1)
			}
			dests[dest] = append(dests[dest], metric)
		}
	}

	// Wait for all of the forward to finish
	wg := sync.WaitGroup{}
	wg.Add(len(dests))
	errCh := make(chan forwardError)

	for dest, batch := range dests {
		go func(dest string, batch []*metricpb.Metric) {
			defer wg.Done()
			if err := s.forward(ctx, dest, batch); err != nil {
				msg := fmt.Sprintf("failed to forward to the host '%s'", dest)
				errCh <- forwardError{err: err, cause: "forward", msg: msg,
					numMetrics: len(batch)}
			}
		}(dest, batch)
	}

	go func() {
		wg.Wait() // Wait for all the above goroutines to complete
		close(errCh)
	}()

	// read errors and block until all the forward complete
	for err := range errCh {
		errs = append(errs, err)
	}

	span.Add(ssf.RandomlySample(0.1,
		ssf.Timing("proxy.duration_ns", time.Since(span.Start), time.Nanosecond,
			protocolTags),
		ssf.Count("proxy.proxied_metrics_total", float32(len(metrics)), protocolTags),
	)...)

	var res error
	log := s.opts.log.WithFields(logrus.Fields{
		"protocol": "grpc",
		"duration": time.Since(span.Start),
	})

	if len(errs) > 0 {
		// if there were errors, report stats and log them
		for _, err := range errs {
			err.reportMetrics(span)
		}
		res = errs
		log.WithError(res).Error("Proxying failed")
	} else {
		// otherwise just print a success message
		log.Debug("Completed forwarding to downstream Veneurs")
	}

	return res
}
