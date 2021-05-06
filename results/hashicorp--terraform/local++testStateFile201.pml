
// https://github.com/hashicorp/terraform/blob/master/backend/local/testing.go#L201
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testStateFile2010 = [1] of {int};
	run testStateFile201(child_testStateFile2010)
stop_process:skip
}

proctype testStateFile201(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WriteState3060 = [1] of {int};
	Mutexdef stateFile_mu;
	run mutexMonitor(stateFile_mu);
	run WriteState306(stateFile_mu,child_WriteState3060);
	child_WriteState3060?0;
	stop_process: skip;
	child!0
}
proctype WriteState306(Mutexdef s_mu;chan child) {
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

