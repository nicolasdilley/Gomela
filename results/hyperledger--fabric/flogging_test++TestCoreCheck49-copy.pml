// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//common/flogging/core_test.go#L49
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCoreCheck490 = [1] of {int};
	run TestCoreCheck49(child_TestCoreCheck490);
	run receiver(child_TestCoreCheck490)
stop_process:skip
}

proctype TestCoreCheck49(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Check813 = [1] of {int};
	chan child_Check812 = [1] of {int};
	chan child_Check811 = [1] of {int};
	Mutexdef core_Levels_mutex;
	chan child_ActivateSpec420 = [1] of {int};
	Mutexdef levels_mutex;
	run mutexMonitor(levels_mutex);
	run ActivateSpec42(levels_mutex,child_ActivateSpec420);
	child_ActivateSpec420?0;
	run mutexMonitor(core_Levels_mutex);
	run Check81(core_Levels_mutex,child_Check811);
	child_Check811?0;
	run Check81(core_Levels_mutex,child_Check812);
	child_Check812?0;
	run Check81(core_Levels_mutex,child_Check813);
	child_Check813?0;
	stop_process: skip;
	child!0
}
proctype ActivateSpec42(Mutexdef l_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_specs = -2; // opt var_specs
	int var_loggers = -2; // opt var_loggers
	int var_strings_Split = -2; // opt var_strings_Split
	l_mutex.Lock!false;
	goto defer1;
		defer1: skip;
	l_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Check81(Mutexdef c_Levels_mutex;chan child) {
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

