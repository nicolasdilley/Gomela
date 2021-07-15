
// https://github.com/rclone/rclone/blob/master/fs/config/configfile/configfile_test.go#L58
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfigFile580 = [1] of {int};
	run TestConfigFile58(child_TestConfigFile580)
stop_process:skip
}

proctype TestConfigFile58(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Load960 = [1] of {int};
	Mutexdef data_mu;
	Mutexdef data_gc_lock;
	run mutexMonitor(data_gc_lock);
	run mutexMonitor(data_mu);
	run Load96(data_gc_lock,data_mu,child_Load960);
	child_Load960?0;
	stop_process: skip;
	child!0
}
proctype Load96(Mutexdef s_gc_lock;Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child__load560 = [1] of {int};
	s_mu.Lock!false;
	run _load56(s_gc_lock,s_mu,child__load560);
	child__load560?0;
	goto stop_process;
	stop_process: skip;
		s_mu.Unlock!false;
	child!0
}
proctype _load56(Mutexdef s_gc_lock;Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef gc_lock;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(gc_lock);
	

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

