#define lb_for198_0  -1
#define ub_for198_1  -1
#define batches  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example073138656/probe/awsecs/client.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef group;
	int i;
	int batches = 5;
	bool state = false;
	run wgMonitor(group);
	
	if
	:: lb_for198_0 != -1 && ub_for198_1 != -1 -> 
				for(i : lb_for198_0.. ub_for198_1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:		for(i : 1.. batches) {
for20:		group.Add!1;
		run Anonymous0()
	};
	group.Wait?0
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
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
