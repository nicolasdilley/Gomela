// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/volume/glusterfs/glusterfs_minmax_test.go#L23
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNewFree230 = [1] of {int};
	run TestNewFree23(child_TestNewFree230);
	run receiver(child_TestNewFree230)
stop_process:skip
}

proctype TestNewFree23(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Free1850 = [1] of {int};
	Mutexdef m_lock;
	run mutexMonitor(m_lock);
	run Free185(m_lock,child_Free1850);
	child_Free1850?0;
	stop_process: skip;
	child!0
}
proctype Free185(Mutexdef a_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	a_lock.Lock!false;
	goto defer1;
		defer1: skip;
	a_lock.Unlock!false;
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

