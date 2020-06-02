def main.main():
    let t0 = newchan main.main0.t0_chan0, 0;
    let t1 = newchan main.main0.t1_chan0, 0;
    spawn main.Producer(t0);
    spawn main.Producer(t1);
    call main.Consumer(t0, t0);
def main.Producer(ch):
    call main.Producer#3(ch);
def main.Producer#1(ch):
    send ch;
    call main.Producer#3(ch);
def main.Producer#2(ch):
    close ch;
def main.Producer#3(ch):
    ifFor (int t2 = 0; (t2<5); t2 = t2 + 1) then call main.Producer#1(ch); else call main.Producer#2(ch); endif;
def main.Consumer(ch1, ch2):
    call main.Consumer#1(ch1, ch2);
def main.Consumer#1(ch1, ch2):
    select
      case recv ch1; call main.Consumer#2(ch1, ch2);
      case recv ch1; call main.Consumer#4(ch1, ch2);
    endselect;
def main.Consumer#2(ch1, ch2):
    call main.Consumer#1(ch1, ch2);
def main.Consumer#4(ch1, ch2):
    call main.Consumer#1(ch1, ch2);
