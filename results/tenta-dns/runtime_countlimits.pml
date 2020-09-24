#define lb_for109_0  -1
#define ub_for109_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example506785681/runtime/limiter.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef cl;
	bool state = false;
	run wgMonitor(cl);
		for(i : lb_for109_0.. ub_for109_1) {
for10:		do
		:: true -> 
			cl.Wait?0;
			goto stop_process
		:: true -> 
			run go_runtimeupdatecounts(cl)
		od
	};
for10_exit:
stop_process:}

proctype go_runtimeupdatecounts(Wgdef cl) {
	bool closed; 
	int i;
	cl.Add!1;
	do
	:: true -> 
for11:		
		if
		:: true -> 
			do
			:: true -> 
for12:
			:: true -> 
				break
			od
		:: true;
		fi
	:: true -> 
		break
	od;
	do
	:: true -> 
for13:
	:: true -> 
		break
	od;
	cl.Add!-1;
stop_process:
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
