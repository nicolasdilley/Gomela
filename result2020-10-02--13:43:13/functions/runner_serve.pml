#define lb_for276_0  -1
#define ub_for276_1  -1
#define lb_for332_2  -1
#define ub_for332_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example610685382/api/runner/worker.go
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
	run Anonymous0(wg);
	wg.Add!1;
	run Anonymous1(wg);
	wg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
			goto stop_process
		:: true;
		od
	od;
for10_exit:	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: lb_for332_2 != -1 && ub_for332_3 != -1 -> 
				for(i : lb_for332_2.. ub_for332_3) {
for20:
		}
	:: else -> 
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
	fi;
for20_exit:	wg.Add!-1;
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
