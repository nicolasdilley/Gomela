// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//common/flogging/core_test.go#L160
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCoreWriteEncodeFail1600 = [1] of {int};
	run TestCoreWriteEncodeFail160(child_TestCoreWriteEncodeFail1600);
	run receiver(child_TestCoreWriteEncodeFail1600)
stop_process:skip
}

proctype TestCoreWriteEncodeFail160(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Write920 = [1] of {int};
	Mutexdef core_Levels_mutex;
	run mutexMonitor(core_Levels_mutex);
	run Write92(core_Levels_mutex,child_Write920);
	child_Write920?0;
	stop_process: skip;
	child!0
}
proctype Write92(Mutexdef c_Levels_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Sync1170 = [1] of {int};
	

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
	

	if
	:: true -> 
		run Sync117(c_Levels_mutex,child_Sync1170);
		child_Sync1170?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Sync117(Mutexdef c_Levels_mutex;chan child) {
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

