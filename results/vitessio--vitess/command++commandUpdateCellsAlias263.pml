// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/cmd/vtctldclient/command/cells.go#L263
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_commandUpdateCellsAlias2630 = [1] of {int};
	run commandUpdateCellsAlias263(child_commandUpdateCellsAlias2630);
	run receiver(child_commandUpdateCellsAlias2630)
stop_process:skip
}

proctype commandUpdateCellsAlias263(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MarshalJSON370 = [1] of {int};
	Mutexdef resp_CellsAlias_state_atomicMessageInfo_initMu;
	Mutexdef resp_state_atomicMessageInfo_initMu;
	run mutexMonitor(resp_state_atomicMessageInfo_initMu);
	run mutexMonitor(resp_CellsAlias_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run MarshalJSON37(resp_CellsAlias_state_atomicMessageInfo_initMu,child_MarshalJSON370);
	child_MarshalJSON370?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype MarshalJSON37(Mutexdef obj_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	fi;
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

