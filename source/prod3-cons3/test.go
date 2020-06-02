def main.main():
    let t0 = newchan main.main0.t0_chan1, 1;
    let t1 = newchan main.main0.t1_chan1, 1;
    let t2 = newchan main.main0.t2_chan1, 1;
    let t3 = newchan main.main0.t3_chan1, 1;
    spawn main.Producer(t0, t1);
    spawn main.Producer(t1, t2);
    spawn main.Producer(t2, t3);
    spawn main.Consumer(t0, t1);
    spawn main.Consumer(t1, t2);
    spawn main.Consumer(t2, t3);
def main.Producer(ch1, ch2):
    call main.Producer#1(ch1, ch2);
def main.Producer#1(ch1, ch2):
    if call main.Producer#2(ch1, ch2); else call main.Producer#3(ch1, ch2); endif;
def main.Producer#2(ch1, ch2):
    send ch1;
    call main.Producer#1(ch1, ch2);
def main.Producer#3(ch1, ch2):
    send ch2;
    call main.Producer#1(ch1, ch2);
def main.Consumer(ch1, ch2):
    call main.Consumer#1(ch1, ch2);
def main.Consumer#1(ch1, ch2):
    select
      case recv ch1; call main.Consumer#2(ch1, ch2);
      case recv ch2; call main.Consumer#4(ch1, ch2);
      case tau; call main.Consumer#1(ch1, ch2);
    endselect;
def main.Consumer#2(ch1, ch2):
    call main.Consumer#1(ch1, ch2);
def main.Consumer#4(ch1, ch2):
    call main.Consumer#1(ch1, ch2);
