
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example411313236/distributed/agent/local_dataset_shards_manager_in_memory.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	int t_outgoingChannels = -2;
	run wgMonitor(wg);
	

	if
	:: true -> 
		run go_Anonymous0(wg,t_outgoingChannels)
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg;int t_outgoingChannels) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip
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
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

