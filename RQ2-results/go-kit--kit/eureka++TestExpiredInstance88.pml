
// https://github.com/go-kit/kit/blob/master/sd/eureka/registrar_test.go#L88
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestExpiredInstance880 = [1] of {int};
	run TestExpiredInstance88(child_TestExpiredInstance880)
stop_process:skip
}

proctype TestExpiredInstance88(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewRegistrar500 = [1] of {int};
	Mutexdef connection_mu;
	run mutexMonitor(connection_mu);
	run NewRegistrar50(connection_mu,child_NewRegistrar500);
	child_NewRegistrar500?0;
	stop_process: skip;
	child!0
}
proctype NewRegistrar50(Mutexdef conn_mu;chan child) {
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

