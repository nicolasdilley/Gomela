
// https://github.com/kubernetes/kops/blob/master/pkg/resources/digitalocean/dns/dns_test.go#L298
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNewZone2980 = [1] of {int};
	run TestNewZone298(child_TestNewZone2980)
stop_process:skip
}

proctype TestNewZone298(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewProvider850 = [1] of {int};
	Mutexdef client_ratemtx;
	run mutexMonitor(client_ratemtx);
	run NewProvider85(client_ratemtx,child_NewProvider850);
	child_NewProvider850?0;
	stop_process: skip;
	child!0
}
proctype NewProvider85(Mutexdef client_ratemtx;chan child) {
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

