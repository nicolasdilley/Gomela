
// https://github.com/ethereum/go-ethereum/blob/master/ethclient/ethclient.go#L44
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_DialContext440 = [1] of {int};
	run DialContext44(child_DialContext440)
stop_process:skip
}

proctype DialContext44(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewClient530 = [1] of {int};
	Mutexdef c_services_mu;
	run mutexMonitor(c_services_mu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run NewClient53(c_services_mu,child_NewClient530);
	child_NewClient530?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewClient53(Mutexdef c_services_mu;chan child) {
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

