// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/beego/beego/blob//core/utils/safemap_test.go#L35
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestReSet350 = [1] of {int};
	run TestReSet35(child_TestReSet350);
	run receiver(child_TestReSet350)
stop_process:skip
}

proctype TestReSet35(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Set472 = [1] of {int};
	chan child_Set471 = [1] of {int};
	chan child_Set470 = [1] of {int};
	Mutexdef safeMap_lock;
	run mutexMonitor(safeMap_lock);
	run Set47(safeMap_lock,child_Set470);
	child_Set470?0;
	run Set47(safeMap_lock,child_Set471);
	child_Set471?0;
	run Set47(safeMap_lock,child_Set472);
	child_Set472?0;
	stop_process: skip;
	child!0
}
proctype Set47(Mutexdef m_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	m_lock.Lock!false;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		fi
	fi;
	goto defer1;
		defer1: skip;
	m_lock.Unlock!false;
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

