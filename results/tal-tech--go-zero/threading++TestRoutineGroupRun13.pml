// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/threading/routinegroup_test.go#L13
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestRoutineGroupRun130 = [1] of {int};
	run TestRoutineGroupRun13(child_TestRoutineGroupRun130);
	run receiver(child_TestRoutineGroupRun130)
stop_process:skip
}

proctype TestRoutineGroupRun13(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Wait402 = [1] of {int};
	chan child_Run181 = [1] of {int};
	chan child_Run180 = [1] of {int};
	Wgdef group_waitGroup;
	run wgMonitor(group_waitGroup);
	

	if
	:: 0 != -2 && 3-1 != -3 -> 
				for(i : 0.. 3-1) {
			for11: skip;
			run Run18(group_waitGroup,child_Run181);
			child_Run181?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Run18(group_waitGroup,child_Run180);
			child_Run180?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run Wait40(group_waitGroup,child_Wait402);
	child_Wait402?0;
	stop_process: skip;
	child!0
}
proctype Run18(Wgdef g_waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousRun2100 = [1] of {int};
	g_waitGroup.update!1;
	run AnonymousRun210(g_waitGroup,child_AnonymousRun2100);
	run receiver(child_AnonymousRun2100);
	stop_process: skip;
	child!0
}
proctype AnonymousRun210(Wgdef g_waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	g_waitGroup.update!-1;
	stop_process: skip;
	child!0
}
proctype Wait40(Wgdef g_waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	g_waitGroup.wait?0;
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

