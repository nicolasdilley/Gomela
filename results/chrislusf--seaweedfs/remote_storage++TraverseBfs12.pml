// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/chrislusf/seaweedfs/blob//weed/remote_storage/traverse_bfs.go#L12
#define def_var_K21  ?? // mand K line 21
#define ub_for23_4  ??
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TraverseBfs120 = [1] of {int};
	run TraverseBfs12(child_TraverseBfs120);
	run receiver(child_TraverseBfs120)
stop_process:skip
}

proctype TraverseBfs12(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTraverseBfs22150 = [1] of {int};
	Wgdef dirQueueWg;
	int var_K = def_var_K21; // mand var_K
	run wgMonitor(dirQueueWg);
	dirQueueWg.update!1;
		for(i : 0.. var_K-1) {
		for10: skip;
		run AnonymousTraverseBfs2215(dirQueueWg,child_AnonymousTraverseBfs22150);
		run receiver(child_AnonymousTraverseBfs22150);
		for10_end: skip
	};
	for10_exit: skip;
	dirQueueWg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousTraverseBfs2215(Wgdef dirQueueWg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_processOneDirectory480 = [1] of {int};
		for(i : 0.. ub_for23_4) {
		for11: skip;
		

		if
		:: true -> 
			break
		:: true;
		fi;
		

		if
		:: true -> 
			goto for11_end
		:: true;
		fi;
		run processOneDirectory48(dirQueueWg,child_processOneDirectory480);
		child_processOneDirectory480?0;
		dirQueueWg.update!-1;
		for11_end: skip
	};
	for11_exit: skip;
	stop_process: skip;
	child!0
}
proctype processOneDirectory48(Wgdef dirQueueWg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
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

proctype receiver(chan c) {
c?0
}

