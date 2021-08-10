// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/iawia002/annie/blob/abc3c9df18173c91a5ca7a77fecc0665dea01aa1/utils/ffmpeg.go#L42
#define def_var_paths  -2 // opt paths line 42
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_MergeToMP4420 = [1] of {int};
	run MergeToMP442(def_var_paths,child_MergeToMP4420);
	run receiver(child_MergeToMP4420)
stop_process:skip
}

proctype MergeToMP442(int var_paths;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runMergeCmd100 = [1] of {int};
	Mutexdef cmd_Process_sigMu;
	run mutexMonitor(cmd_Process_sigMu);
	run runMergeCmd10(cmd_Process_sigMu,var_paths,child_runMergeCmd100);
	child_runMergeCmd100?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype runMergeCmd10(Mutexdef cmd_Process_sigMu;int var_paths;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

