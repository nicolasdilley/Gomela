// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/handlers/validation/builtin/v13/validation_logic_test.go#L287
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStateBasedValidationFailure2870 = [1] of {int};
	run TestStateBasedValidationFailure287(child_TestStateBasedValidationFailure2870);
	run receiver(child_TestStateBasedValidationFailure2870)
stop_process:skip
}

proctype TestStateBasedValidationFailure287(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef vs_invocationsMutex;
	Mutexdef vs_getStateRangeScanIteratorMutex;
	Mutexdef vs_getStateMultipleKeysMutex;
	Mutexdef vs_getStateMetadataMutex;
	Mutexdef vs_getPrivateDataMetadataByHashMutex;
	Mutexdef vs_doneMutex;
	run mutexMonitor(vs_doneMutex);
	run mutexMonitor(vs_getPrivateDataMetadataByHashMutex);
	run mutexMonitor(vs_getStateMetadataMutex);
	run mutexMonitor(vs_getStateMultipleKeysMutex);
	run mutexMonitor(vs_getStateRangeScanIteratorMutex);
	run mutexMonitor(vs_invocationsMutex);
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

