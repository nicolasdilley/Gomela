typedef Waitgroup {
  int counter = 0
}

init {
  int i;


  wg.counter = wg.counter + 20;
  assert(wg.counter >= 0)

  for(i:0..20) {
    run send(wg)
  }
  (wg.counter == 0)
}


proctype send(Waitgroup wg) {
  wg.counter = wg.counter - 1
  printf("%d", wg.counter)
  assert(wg.counter >= 0)
}
