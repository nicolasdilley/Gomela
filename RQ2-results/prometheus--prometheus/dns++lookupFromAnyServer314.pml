
// https://github.com/prometheus/prometheus/blob/master/discovery/dns/dns.go#L314
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_lookupFromAnyServer3140 = [1] of {int};
	run lookupFromAnyServer314(child_lookupFromAnyServer3140)
stop_process:skip
}

proctype lookupFromAnyServer314(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_askServerForName3380 = [1] of {int};
	chan child_askServerForName3381 = [1] of {int};
	Mutexdef client_Dialer_Resolver_lookupGroup_mu;
	Mutexdef client_TLSConfig_mutex;
	int conf_Servers = -2;
	run mutexMonitor(client_TLSConfig_mutex);
	run mutexMonitor(client_Dialer_Resolver_lookupGroup_mu);
	

	if
	:: conf_Servers-1 != -3 -> 
				for(i : 0.. conf_Servers-1) {
			for10: skip;
			run askServerForName338(client_TLSConfig_mutex,client_Dialer_Resolver_lookupGroup_mu,child_askServerForName3380);
			child_askServerForName3380?0;
			

			if
			:: true -> 
				goto for10_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run askServerForName338(client_TLSConfig_mutex,client_Dialer_Resolver_lookupGroup_mu,child_askServerForName3381);
			child_askServerForName3381?0;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype askServerForName338(Mutexdef client_TLSConfig_mutex;Mutexdef client_Dialer_Resolver_lookupGroup_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_askServerForName3380 = [1] of {int};
	

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
		run askServerForName338(client_TLSConfig_mutex,client_Dialer_Resolver_lookupGroup_mu,child_askServerForName3380);
		child_askServerForName3380?0;
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

