
// https://github.com/traefik/traefik/blob/master/pkg/middlewares/requestdecorator/hostresolver.go#L76
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_cnameResolve760 = [1] of {int};
	run cnameResolve76(child_cnameResolve760)
stop_process:skip
}

proctype cnameResolve76(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getRecord1050 = [1] of {int};
	chan child_getRecord1051 = [1] of {int};
	Mutexdef client_Dialer_Resolver_lookupGroup_mu;
	Mutexdef client_TLSConfig_mutex;
	int config_Servers = -2;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(client_TLSConfig_mutex);
	run mutexMonitor(client_Dialer_Resolver_lookupGroup_mu);
	

	if
	:: config_Servers-1 != -3 -> 
				for(i : 0.. config_Servers-1) {
			for10: skip;
			run getRecord105(client_TLSConfig_mutex,client_Dialer_Resolver_lookupGroup_mu,child_getRecord1050);
			child_getRecord1050?0;
			

			if
			:: true -> 
				goto for10_end
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run getRecord105(client_TLSConfig_mutex,client_Dialer_Resolver_lookupGroup_mu,child_getRecord1051);
			child_getRecord1051?0;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
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
proctype getRecord105(Mutexdef client_TLSConfig_mutex;Mutexdef client_Dialer_Resolver_lookupGroup_mu;chan child) {
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

