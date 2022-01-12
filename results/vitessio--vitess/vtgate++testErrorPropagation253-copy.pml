// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtgate/vtgate_test.go#L253
#define def_var_sbcs  -2 // opt sbcs line 253
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testErrorPropagation2530 = [1] of {int};
	run testErrorPropagation253(def_var_sbcs,child_testErrorPropagation2530);
	run receiver(child_testErrorPropagation2530)
stop_process:skip
}

proctype testErrorPropagation253(int var_sbcs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef __ReadAfterWrite_state_atomicMessageInfo_initMu;
	Mutexdef __LockSession_state_atomicMessageInfo_initMu;
	Mutexdef __Options_state_atomicMessageInfo_initMu;
	Mutexdef __state_atomicMessageInfo_initMu;
	run mutexMonitor(__state_atomicMessageInfo_initMu);
	run mutexMonitor(__Options_state_atomicMessageInfo_initMu);
	run mutexMonitor(__LockSession_state_atomicMessageInfo_initMu);
	run mutexMonitor(__ReadAfterWrite_state_atomicMessageInfo_initMu);
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

