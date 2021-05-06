#define aps471  -2

// https://github.com/caddyserver/caddy/blob/master/caddyconfig/httpcaddyfile/tlsapp.go#L471
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_consolidateAutomationPolicies4710 = [1] of {int};
	run consolidateAutomationPolicies471(aps471,child_consolidateAutomationPolicies4710)
stop_process:skip
}

proctype consolidateAutomationPolicies471(int aps;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef emptyAP_magic_certCache_mu;
	run mutexMonitor(emptyAP_magic_certCache_mu);
	outer: skip;
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

