// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/google/grumpy/blob//runtime/threading_test.go#L21
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRecursiveMutex210 = [1] of {int};
	run TestRecursiveMutex21(child_TestRecursiveMutex210);
	run receiver(child_TestRecursiveMutex210)
stop_process:skip
}

proctype TestRecursiveMutex21(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Unlock723 = [1] of {int};
	chan child_Unlock722 = [1] of {int};
	chan child_Lock571 = [1] of {int};
	chan child_Lock570 = [1] of {int};
	Mutexdef f_globals_mutex_mutex;
	Mutexdef m_mutex;
	run mutexMonitor(m_mutex);
	run mutexMonitor(f_globals_mutex_mutex);
	run Lock57(m_mutex,f_globals_mutex_mutex,child_Lock570);
	child_Lock570?0;
	run Lock57(m_mutex,f_globals_mutex_mutex,child_Lock571);
	child_Lock571?0;
	run Unlock72(m_mutex,f_globals_mutex_mutex,child_Unlock722);
	child_Unlock722?0;
	run Unlock72(m_mutex,f_globals_mutex_mutex,child_Unlock723);
	child_Unlock723?0;
	stop_process: skip;
	child!0
}
proctype Lock57(Mutexdef m_mutex;Mutexdef f_globals_mutex_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		m_mutex.Lock!false
	fi;
	stop_process: skip;
	child!0
}
proctype Unlock72(Mutexdef m_mutex;Mutexdef f_globals_mutex_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		m_mutex.Unlock!false
	:: true;
	fi;
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

