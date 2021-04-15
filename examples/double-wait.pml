
typedef Wgdef {
  chan Add = [0] of {int}
  chan Wait = [0] of {int}
  int Counter = 0
}


init {
  Wgdef wg;
  run wgmonitor(wg)
  printf("ici\n")
  int i;
  for(i: 0..20-1) {
    run Work(wg)
  wg.Add!1;
  }
    run anonymous(wg)

    printf("Waiting\n")
    wg.Wait!0
    printf("Im done\n")
}



proctype wgmonitor(Wgdef s) {
  int num
  do
  :: s.Add?num ->
    s.Counter = s.Counter + num
    assert(s.Counter >= 0)
  :: s.Counter == 0 ->
    if
    :: s.Add?num ->
    s.Counter = s.Counter + num
    assert(s.Counter >= 0)
    :: s.Wait?0;
    fi
  od
}

proctype Work(Structdef wg) {
  printf("all and well.\n")
  wg.Add!-1 // Done() are translated to Add(-1)
}

proctype anonymous(Structdef wg) {
  wg.Wait!0
  printf("Im also done.\n")
}
