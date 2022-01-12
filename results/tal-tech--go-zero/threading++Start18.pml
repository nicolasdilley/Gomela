// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/threading/workergroup.go#L18
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_Start180 = [1] of {int};
	run Start18(child_Start180);
	run receiver(child_Start180)
stop_process:skip
}

proctype Start18(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Wait402 = [1] of {int};
	chan child_RunSafe301 = [1] of {int};
	chan child_RunSafe300 = [1] of {int};
	Wgdef group_waitGroup;
	int var_wg_workers = -2; // opt var_wg_workers
	run wgMonitor(group_waitGroup);
	

	if
	:: 0 != -2 && var_wg_workers-1 != -3 -> 
				for(i : 0.. var_wg_workers-1) {
			for11: skip;
			run RunSafe30(group_waitGroup,child_RunSafe301);
			child_RunSafe301?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run RunSafe30(group_waitGroup,child_RunSafe300);
			child_RunSafe300?0;
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
proctype RunSafe30(Wgdef g_waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	g_waitGroup.update!1;
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

