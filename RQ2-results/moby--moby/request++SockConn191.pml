
// https://github.com/moby/moby/blob/master/testutil/request/request.go#L191
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_SockConn1910 = [1] of {int};
	run SockConn191(child_SockConn1910)
stop_process:skip
}

proctype SockConn191(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef dialer_Resolver_lookupGroup_mu;
	Mutexdef tlsConfig_mutex;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			run mutexMonitor(tlsConfig_mutex);
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			run mutexMonitor(dialer_Resolver_lookupGroup_mu);
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
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

