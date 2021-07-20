// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/consul/blob/8d6cbe72813779f60ac24d119cc311c21003f4ce/command/snapshot/inspect/snapshot_inspect_test.go#L81
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSnapshotInspectCommand810 = [1] of {int};
	run TestSnapshotInspectCommand81(child_TestSnapshotInspectCommand810);
	run receiver(child_TestSnapshotInspectCommand810)
stop_process:skip
}

proctype TestSnapshotInspectCommand81(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_New240 = [1] of {int};
	Mutexdef ui_once_m;
	run mutexMonitor(ui_once_m);
	run New24(ui_once_m,child_New240);
	child_New240?0;
	stop_process: skip;
	child!0
}
proctype New24(Mutexdef ui_once_m;chan child) {
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
proctype mutexMonitor(Mutexdef m) {
bool locked = false;
do
:: true ->
	if
	:: m.Counter > 0 ->
		if 
		:: m.RUnlock?false -> 
			m.Counter = m.Counter - 1;
		:: m.RLock?false -> 
			m.Counter = m.Counter + 1;
		fi;
	:: locked ->
		m.Unlock?false;
		locked = false;
	:: else ->	 end:	if
		:: m.Unlock?false ->
			assert(0==32);		:: m.Lock?false ->
			locked =true;
		:: m.RUnlock?false ->
			assert(0==32);		:: m.RLock?false ->
			m.Counter = m.Counter + 1;
		fi;
	fi;
od
}

proctype receiver(chan c) {
c?0
}
