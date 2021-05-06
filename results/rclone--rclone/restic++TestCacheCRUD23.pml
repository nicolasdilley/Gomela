
// https://github.com/rclone/rclone/blob/master/cmd/serve/restic/cache_test.go#L23
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCacheCRUD230 = [1] of {int};
	run TestCacheCRUD23(child_TestCacheCRUD230)
stop_process:skip
}

proctype TestCacheCRUD23(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_remove458 = [1] of {int};
	chan child_find247 = [1] of {int};
	chan child_String126 = [1] of {int};
	chan child_remove455 = [1] of {int};
	chan child_find244 = [1] of {int};
	chan child_String123 = [1] of {int};
	chan child_add352 = [1] of {int};
	chan child_find241 = [1] of {int};
	chan child_String120 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run String12(c_mu,child_String120);
	child_String120?0;
	run find24(c_mu,child_find241);
	child_find241?0;
	run add35(c_mu,child_add352);
	child_add352?0;
	run String12(c_mu,child_String123);
	child_String123?0;
	run find24(c_mu,child_find244);
	child_find244?0;
	run remove45(c_mu,child_remove455);
	child_remove455?0;
	run String12(c_mu,child_String126);
	child_String126?0;
	run find24(c_mu,child_find247);
	child_find247?0;
	run remove45(c_mu,child_remove458);
	child_remove458?0;
	stop_process: skip;
	child!0
}
proctype String12(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mu.Lock!false;
	c_mu.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype find24(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	c_mu.RLock!false;
	c_mu.RUnlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype add35(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	c_mu.Lock!false;
	c_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype remove45(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	c_mu.Lock!false;
	c_mu.Unlock!false;
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

