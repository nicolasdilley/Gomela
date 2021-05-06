
// https://github.com/kubernetes/kubernetes/blob/master/pkg/volume/glusterfs/glusterfs_minmax_test.go#L201
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRelease2010 = [1] of {int};
	run TestRelease201(child_TestRelease2010)
stop_process:skip
}

proctype TestRelease201(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Has1773 = [1] of {int};
	chan child_Release1542 = [1] of {int};
	chan child_Has1771 = [1] of {int};
	chan child_Allocate1120 = [1] of {int};
	Mutexdef m_lock;
	run mutexMonitor(m_lock);
	run Allocate112(m_lock,child_Allocate1120);
	child_Allocate1120?0;
	run Has177(m_lock,child_Has1771);
	child_Has1771?0;
	run Release154(m_lock,child_Release1542);
	child_Release1542?0;
	run Has177(m_lock,child_Has1773);
	child_Has1773?0;
	stop_process: skip;
	child!0
}
proctype Allocate112(Mutexdef a_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_has1711 = [1] of {int};
	chan child_inRange1910 = [1] of {int};
	a_lock.Lock!false;
	run inRange191(a_lock,child_inRange1910);
	child_inRange1910?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run has171(a_lock,child_has1711);
	child_has1711?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		a_lock.Unlock!false;
	child!0
}
proctype inRange191(Mutexdef a_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype has171(Mutexdef a_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Has177(Mutexdef a_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_has1711 = [1] of {int};
	a_lock.Lock!false;
	run has171(a_lock,child_has1711);
	child_has1711?0;
	goto stop_process;
	stop_process: skip;
		a_lock.Unlock!false;
	child!0
}
proctype Release154(Mutexdef a_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_inRange1913 = [1] of {int};
	chan child_has1712 = [1] of {int};
	a_lock.Lock!false;
	run has171(a_lock,child_has1712);
	child_has1712?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run inRange191(a_lock,child_inRange1913);
	child_inRange1913?0;
	goto stop_process;
	stop_process: skip;
		a_lock.Unlock!false;
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

