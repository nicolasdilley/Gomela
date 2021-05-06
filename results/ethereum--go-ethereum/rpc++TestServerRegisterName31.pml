
// https://github.com/ethereum/go-ethereum/blob/master/rpc/server_test.go#L31
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestServerRegisterName310 = [1] of {int};
	run TestServerRegisterName31(child_TestServerRegisterName310)
stop_process:skip
}

proctype TestServerRegisterName31(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RegisterName650 = [1] of {int};
	Mutexdef server_services_mu;
	run mutexMonitor(server_services_mu);
	run RegisterName65(server_services_mu,child_RegisterName650);
	child_RegisterName650?0;
	stop_process: skip;
	child!0
}
proctype RegisterName65(Mutexdef s_services_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_registerName610 = [1] of {int};
	run registerName61(s_services_mu,child_registerName610);
	child_registerName610?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype registerName61(Mutexdef r_mu;chan child) {
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
	r_mu.Lock!false;
	goto stop_process;
	stop_process: skip;
		r_mu.Unlock!false;
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

