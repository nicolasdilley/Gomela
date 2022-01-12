// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/chrislusf/seaweedfs/blob//weed/pb/filer_pb/filer_client_bfs.go#L11
#define def_var_K21  ?? // mand K line 21
#define ub_for23_4  ??
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TraverseBfs110 = [1] of {int};
	run TraverseBfs11(child_TraverseBfs110);
	run receiver(child_TraverseBfs110)
stop_process:skip
}

proctype TraverseBfs11(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTraverseBfs22150 = [1] of {int};
	Wgdef jobQueueWg;
	int var_K = def_var_K21; // mand var_K
	run wgMonitor(jobQueueWg);
	jobQueueWg.update!1;
		for(i : 0.. var_K-1) {
		for10: skip;
		run AnonymousTraverseBfs2215(jobQueueWg,child_AnonymousTraverseBfs22150);
		run receiver(child_AnonymousTraverseBfs22150);
		for10_end: skip
	};
	for10_exit: skip;
	jobQueueWg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousTraverseBfs2215(Wgdef jobQueueWg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_processOneDirectory460 = [1] of {int};
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
		run processOneDirectory46(jobQueueWg,child_processOneDirectory460);
		child_processOneDirectory460?0;
		jobQueueWg.update!-1;
		for11_end: skip
	};
	for11_exit: skip;
	stop_process: skip;
	child!0
}
proctype processOneDirectory46(Wgdef jobQueueWg;chan child) {
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

