package cockroach25456

func process(quiescer chan struct{}) {
	<-quiescer
}

func testCockroach25456() {
	quiescer := make(chan struct{})
	for i := 0; i < 2; i++ {
		process(quiescer)
	}
}
