// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/vitessio/vitess/blob//go/vt/topotools/split.go#L33
#define def_var_sourceShards  -2 // opt sourceShards line 33
#define def_var_targetShards  -2 // opt targetShards line 33
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ValidateForReshard330 = [1] of {int};
	run ValidateForReshard33(def_var_sourceShards,def_var_targetShards,child_ValidateForReshard330);
	run receiver(child_ValidateForReshard330)
stop_process:skip
}

proctype ValidateForReshard33(int var_sourceShards;int var_targetShards;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_KeyRangeString1742 = [1] of {int};
	chan child_KeyRangeString1741 = [1] of {int};
	chan child_KeyRangeEqual1900 = [1] of {int};
	Mutexdef targetkr_state_atomicMessageInfo_initMu;
	Mutexdef sourcekr_state_atomicMessageInfo_initMu;
	run mutexMonitor(sourcekr_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(targetkr_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run KeyRangeEqual190(sourcekr_state_atomicMessageInfo_initMu,sourcekr_state_atomicMessageInfo_initMu,child_KeyRangeEqual1900);
	child_KeyRangeEqual1900?0;
	

	if
	:: true -> 
		run KeyRangeString174(sourcekr_state_atomicMessageInfo_initMu,child_KeyRangeString1741);
		child_KeyRangeString1741?0;
		run KeyRangeString174(targetkr_state_atomicMessageInfo_initMu,child_KeyRangeString1742);
		child_KeyRangeString1742?0;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype KeyRangeEqual190(Mutexdef left_state_atomicMessageInfo_initMu;Mutexdef right_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype KeyRangeString174(Mutexdef k_state_atomicMessageInfo_initMu;chan child) {
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

