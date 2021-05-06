
// https://github.com/caddyserver/caddy/blob/master/caddyconfig/httpcaddyfile/builtins.go#L87
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_parseTLS870 = [1] of {int};
	run parseTLS87(child_parseTLS870)
stop_process:skip
}

proctype parseTLS87(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef internalIssuer_ca_mu;
	Mutexdef acmeIssuer_magic_certCache_mu;
	Mutexdef acmeIssuer_template_config_certCache_mu;
	Mutexdef cp_stdTLSConfig_mutex;
	run mutexMonitor(cp_stdTLSConfig_mutex);
	run mutexMonitor(acmeIssuer_template_config_certCache_mu);
	run mutexMonitor(acmeIssuer_magic_certCache_mu);
	run mutexMonitor(internalIssuer_ca_mu);
	

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
	:: true;
	:: true;
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

