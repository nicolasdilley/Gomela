#define lb_for56_0  -1
#define ub_for56_1  -1
#define lb_for68_2  -1
#define ub_for68_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example636999748/pkg/skaffold/build/cluster/logs.go
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
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for56_0 != -1 && ub_for56_1 != -1 -> 
				for(i : lb_for56_0.. ub_for56_1) {
for10:			do
			:: true -> 
for11:				do
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					break
				od
			od;
for11_exit:
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
for11:				do
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					break
				od
			od;
for11_exit:
		:: true -> 
			break
		od
	fi;
for10_exit:stop_process:	wg.Add!-1
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
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
	od
}
