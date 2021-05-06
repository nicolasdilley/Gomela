
// https://github.com/hashicorp/packer/blob/master/builder/oracle/oci/config_test.go#L52
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig520 = [1] of {int};
	run TestConfig52(child_TestConfig520)
stop_process:skip
}

proctype TestConfig52(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_writeTestConfig3650 = [1] of {int};
	Mutexdef cfg_lock;
	run mutexMonitor(cfg_lock);
	run writeTestConfig365(cfg_lock,child_writeTestConfig3650);
	child_writeTestConfig3650?0;
	stop_process: skip;
	child!0
}
proctype writeTestConfig365(Mutexdef cfg_lock;chan child) {
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

