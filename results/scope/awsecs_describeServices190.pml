#define describeServices_batches  ??
#define lb_for198_1  -1
#define ub_for198_2  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example693998811/probe/awsecs/client.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef group;
	int i;
	int batches = describeServices_batches;
	bool state = false;
	run wgMonitor(group);
for10_exit:		for(i : 0.. batches-1) {
for20:		group.Add!1;
		run Anonymous0(group)
	};
	group.Wait?0
stop_process:}

proctype Anonymous0(Wgdef group) {
	bool closed; 
	int i;
	bool state;
stop_process:	group.Add!-1
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
