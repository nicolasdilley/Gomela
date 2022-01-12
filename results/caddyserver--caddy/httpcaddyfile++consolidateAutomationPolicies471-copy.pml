// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/caddyserver/caddy/blob//caddyconfig/httpcaddyfile/tlsapp.go#L471
#define def_var_aps  -2 // opt aps line 471
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_consolidateAutomationPolicies4710 = [1] of {int};
	run consolidateAutomationPolicies471(def_var_aps,child_consolidateAutomationPolicies4710);
	run receiver(child_consolidateAutomationPolicies4710)
stop_process:skip
}

proctype consolidateAutomationPolicies471(int var_aps;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef emptyAP_magic_certCache_mu;
	int var_apsLjL_Subjects = -2; // opt var_apsLjL_Subjects
	int var_i = -2; // opt var_i
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

proctype receiver(chan c) {
c?0
}

