// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/tsenart/vegeta/blob/d73edf2bc2663d83848da2a97a8401a7ed1440bc/lib/targets.go#L255
#define hdr255  -2 // opt hdr255
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewHTTPTargeter2550 = [1] of {int};
	run NewHTTPTargeter255(hdr255,child_NewHTTPTargeter2550);
	run receiver(child_NewHTTPTargeter2550)
stop_process:skip
}

proctype NewHTTPTargeter255(int hdr;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef mu;
	int tokens = -2; // opt tokens
	run mutexMonitor(mu);
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

