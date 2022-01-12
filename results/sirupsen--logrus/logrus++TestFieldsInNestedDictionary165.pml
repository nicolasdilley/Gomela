// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/sirupsen/logrus/blob//json_formatter_test.go#L165
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFieldsInNestedDictionary1650 = [1] of {int};
	run TestFieldsInNestedDictionary165(child_TestFieldsInNestedDictionary1650);
	run receiver(child_TestFieldsInNestedDictionary1650)
stop_process:skip
}

proctype TestFieldsInNestedDictionary165(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Format630 = [1] of {int};
	Mutexdef logEntry_Logger_mu_lock;
	run mutexMonitor(logEntry_Logger_mu_lock);
	run Format63(logEntry_Logger_mu_lock,child_Format630);
	child_Format630?0;
	stop_process: skip;
	child!0
}
proctype Format63(Mutexdef entry_Logger_mu_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_HasCaller2151 = [1] of {int};
	chan child_HasCaller2150 = [1] of {int};
	int var_entry_Data = -2; // opt var_entry_Data
	run HasCaller215(entry_Logger_mu_lock,child_HasCaller2150);
	child_HasCaller2150?0;
	run HasCaller215(entry_Logger_mu_lock,child_HasCaller2151);
	child_HasCaller2151?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype HasCaller215(Mutexdef entry_Logger_mu_lock;chan child) {
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

