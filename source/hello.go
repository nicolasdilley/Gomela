package main

func (d *hierarchicDiffer) Run(root string, from *Graph, to *Graph) (*Diff, error) {
	diff := &Diff{fromGraph: from, toGraph: to}

	fromSnap := from.store.Snapshot()
	toSnap := to.store.Snapshot()

	maxCount := max(uint32(fromSnap.Count()), uint32(toSnap.Count()))
	processing := make(chan string, maxCount)

	if maxCount < 1 {
		return diff, nil
	}

	processing <- root

	for len(processing) > 0 {
		select {
		case current := <-processing:
			extras, missings, commons, err := compareChildTriplesOf(d.predicate, current, fromSnap, toSnap)
			if err != nil {
				return diff, err
			}

			for _, extra := range extras {
				res, ok := extra.Object().Resource()
				if ok {
					diff.hasDiffs = true
					diff.toGraph.store.Add(tstore.SubjPred(res, MetaPredicate).StringLiteral(extraLit))
					processing <- res
				}
			}

			for _, missing := range missings {
				res, ok := missing.Object().Resource()
				if ok {
					diff.hasDiffs = true
					diff.fromGraph.store.Add(tstore.SubjPred(res, MetaPredicate).StringLiteral(extraLit))
					processing <- res
					break
				}
			}
			break
			for _, nextNodeToProcess := range commons {
				res, ok := nextNodeToProcess.Object().Resource()
				if ok {
					processing <- res
				}
			}
		}
	}

	return diff, nil
}
