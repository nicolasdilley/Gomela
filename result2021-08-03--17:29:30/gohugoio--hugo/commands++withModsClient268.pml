// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gohugoio/hugo/blob/64f88f3011de5a510d8e6d6bad8ac4a091b11c0c/commands/mod.go#L268
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_withModsClient2680 = [1] of {int};
	run withModsClient268(child_withModsClient2680);
	run receiver(child_withModsClient2680)
stop_process:skip
}

proctype withModsClient268(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef com_fullRebuildSem_mu;
	Mutexdef com_visitedURLs_mu;
	run mutexMonitor(com_visitedURLs_mu);
	run mutexMonitor(com_fullRebuildSem_mu);
	

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

proctype receiver(chan c) {
c?0
}

