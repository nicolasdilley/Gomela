// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/goharbor/harbor/blob/f8171cdf6e914a08ace62508eabef81ceacfe5a2/src/controller/quota/driver/project/project.go#L121
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newDriver1210 = [1] of {int};
	run newDriver121(child_newDriver1210);
	run receiver(child_newDriver1210)
stop_process:skip
}

proctype newDriver121(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef loader_batchLock;
	Mutexdef loader_cacheLock;
	run mutexMonitor(loader_cacheLock);
	run mutexMonitor(loader_batchLock);
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

