#define newCgSession_topics 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example523385946/tester/consumergroup.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef cgs_wgMessages;
	int i;
	int topics = newCgSession_topics;
	bool state = false;
	run wgMonitor(cgs_wgMessages);
		for(i : 0.. topics-1) {
for10:
	};
	goto stop_process
stop_process:}

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

