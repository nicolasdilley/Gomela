#define lb_for185_0  -1
#define ub_for185_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example081234078/store/tikv/gcworker/gc_worker.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef wg;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!1;
	run go_wstart(wg);
	wg.Wait?0
stop_process:}

proctype go_wstart(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
	do
	:: true -> 
for10:		do
		:: true;
		:: true -> 
			goto stop_process
		od
	od;
for10_exit:stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od;
stop_process:
}
