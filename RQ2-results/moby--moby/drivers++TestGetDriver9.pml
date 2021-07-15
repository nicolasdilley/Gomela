
// https://github.com/moby/moby/blob/master/volume/drivers/extpoint_test.go#L9
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetDriver90 = [1] of {int};
	run TestGetDriver9(child_TestGetDriver90)
stop_process:skip
}

proctype TestGetDriver9(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetDriver1472 = [1] of {int};
	chan child_Register1251 = [1] of {int};
	chan child_GetDriver1470 = [1] of {int};
	Mutexdef s_driverLock_mu;
	Mutexdef s_mu;
	run mutexMonitor(s_mu);
	run mutexMonitor(s_driverLock_mu);
	run GetDriver147(s_mu,s_driverLock_mu,child_GetDriver1470);
	child_GetDriver1470?0;
	run Register125(s_mu,s_driverLock_mu,child_Register1251);
	child_Register1251?0;
	run GetDriver147(s_mu,s_driverLock_mu,child_GetDriver1472);
	child_GetDriver1472?0;
	stop_process: skip;
	child!0
}
proctype GetDriver147(Mutexdef s_mu;Mutexdef s_driverLock_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_lookup720 = [1] of {int};
	run lookup72(s_mu,s_driverLock_mu,child_lookup720);
	child_lookup720?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype lookup72(Mutexdef s_mu;Mutexdef s_driverLock_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	s_mu.Lock!false;
	s_mu.Unlock!false;
	

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
			s_mu.Lock!false;
			s_mu.Unlock!false
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Register125(Mutexdef s_mu;Mutexdef s_driverLock_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	s_mu.Lock!false;
	

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
		s_mu.Unlock!false;
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

