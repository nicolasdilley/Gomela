
// https://github.com/kubernetes/kubernetes/blob/master/pkg/volume/glusterfs/glusterfs_minmax_test.go#L43
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSetRange430 = [1] of {int};
	run TestSetRange43(child_TestSetRange430)
stop_process:skip
}

proctype TestSetRange43(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Free1858 = [1] of {int};
	chan child_SetRange837 = [1] of {int};
	chan child_Free1856 = [1] of {int};
	chan child_SetRange835 = [1] of {int};
	chan child_Free1854 = [1] of {int};
	chan child_Allocate1123 = [1] of {int};
	chan child_Free1852 = [1] of {int};
	chan child_SetRange831 = [1] of {int};
	chan child_SetRange830 = [1] of {int};
	Mutexdef m_lock;
	run mutexMonitor(m_lock);
	run SetRange83(m_lock,child_SetRange830);
	child_SetRange830?0;
	run SetRange83(m_lock,child_SetRange831);
	child_SetRange831?0;
	run Free185(m_lock,child_Free1852);
	child_Free1852?0;
	run Allocate112(m_lock,child_Allocate1123);
	child_Allocate1123?0;
	run Free185(m_lock,child_Free1854);
	child_Free1854?0;
	run SetRange83(m_lock,child_SetRange835);
	child_SetRange835?0;
	run Free185(m_lock,child_Free1856);
	child_Free1856?0;
	run SetRange83(m_lock,child_SetRange837);
	child_SetRange837?0;
	run Free185(m_lock,child_Free1858);
	child_Free1858?0;
	stop_process: skip;
	child!0
}
proctype SetRange83(Mutexdef a_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_inRange1910 = [1] of {int};
	chan child_inRange1911 = [1] of {int};
	int a_used = -2;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	a_lock.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: a_used-1 != -3 -> 
				for(i : 0.. a_used-1) {
			for10: skip;
			run inRange191(a_lock,child_inRange1910);
			child_inRange1910?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run inRange191(a_lock,child_inRange1911);
			child_inRange1911?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
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
proctype Free185(Mutexdef a_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	a_lock.Lock!false;
	goto stop_process;
	stop_process: skip;
		a_lock.Unlock!false;
	child!0
}
proctype Allocate112(Mutexdef a_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_has1714 = [1] of {int};
	chan child_inRange1913 = [1] of {int};
	a_lock.Lock!false;
	run inRange191(a_lock,child_inRange1913);
	child_inRange1913?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run has171(a_lock,child_has1714);
	child_has1714?0;
	

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
proctype has171(Mutexdef a_lock;chan child) {
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

