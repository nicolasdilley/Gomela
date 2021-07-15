#define CleanupClients_managedClients  3

// https://github.com/hashicorp/packer/blob/master/packer/plugin_client.go#L76
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_CleanupClients760 = [1] of {int};
	run CleanupClients76(child_CleanupClients760)
stop_process:skip
}

proctype CleanupClients76(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousCleanupClients86860 = [1] of {int};
	Wgdef wg;
	int managedClients = CleanupClients_managedClients;
	run wgMonitor(wg);
		for(i : 0.. managedClients-1) {
		for10: skip;
		wg.update!1;
		run AnonymousCleanupClients8686(wg,child_AnonymousCleanupClients86860);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousCleanupClients8686(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

