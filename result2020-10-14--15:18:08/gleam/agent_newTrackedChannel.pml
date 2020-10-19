#define newTrackedChannel_t_outgoingChannels  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example249045290/distributed/agent/local_dataset_shards_manager_in_memory.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int t_outgoingChannels = newTrackedChannel_t_outgoingChannels;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: true -> 
				for(i : 1.. t_outgoingChannels) {
for10:
		};
		run Anonymous0(wg)
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
		for(i : 1.. t_outgoingChannels) {
for20:
	};
		for(i : 1.. t_outgoingChannels) {
for30:
	};
stop_process:
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
	od;
stop_process:
}
