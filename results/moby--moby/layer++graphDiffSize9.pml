// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/moby/moby/blob//layer/layer_unix_test.go#L9
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_graphDiffSize90 = [1] of {int};
	run graphDiffSize9(child_graphDiffSize90);
	run receiver(child_graphDiffSize90)
stop_process:skip
}

proctype graphDiffSize9(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cl_layerStore_locker_mu;
	Mutexdef cl_layerStore_mountL;
	Mutexdef cl_layerStore_layerL;
	run mutexMonitor(cl_layerStore_layerL);
	run mutexMonitor(cl_layerStore_mountL);
	run mutexMonitor(cl_layerStore_locker_mu);
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

