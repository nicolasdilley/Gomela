def main.main():
    let t1 = newchan main.main0.t1_chan0, 0;
    let t3 = newchan main.main0.t3_chan0, 0;
    spawn main.main$1(t1);
    spawn main.main$2(t3);
    call main.sel(t1, t3);
    call main.sel(t1, t3);
def main.main$1(x):
    send x;
def main.main$2(y):
    send y;
def main.sel$1(z, x):
    recv x;
    send z;
def main.sel$2(z, y):
    recv y;
    send z;
def main.sel(x, y):
    let t3 = newchan main.sel0.t3_chan0, 0;
    spawn main.sel$1(t3, x);
    spawn main.sel$2(t3, y);
    recv t3;
