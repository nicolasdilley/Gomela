// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//common/flogging/logging_test.go#L120
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCheck1200 = [1] of {int};
	run TestCheck120(child_TestCheck1200);
	run receiver(child_TestCheck1200)
stop_process:skip
}

proctype TestCheck120(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Check2254 = [1] of {int};
	chan child_SetObserver1613 = [1] of {int};
	chan child_WriteEntry2352 = [1] of {int};
	chan child_Check2251 = [1] of {int};
	chan child_SetObserver1610 = [1] of {int};
	Mutexdef observer_invocationsMutex;
	Mutexdef observer_writeEntryMutex;
	Mutexdef observer_checkMutex;
	Mutexdef l_multiFormatter_mutex;
	Mutexdef l_mutex;
	run mutexMonitor(l_mutex);
	run mutexMonitor(l_multiFormatter_mutex);
	run mutexMonitor(observer_checkMutex);
	run mutexMonitor(observer_writeEntryMutex);
	run mutexMonitor(observer_invocationsMutex);
	run SetObserver161(l_multiFormatter_mutex,l_mutex,observer_checkMutex,observer_invocationsMutex,observer_writeEntryMutex,child_SetObserver1610);
	child_SetObserver1610?0;
	run Check225(l_multiFormatter_mutex,l_mutex,child_Check2251);
	child_Check2251?0;
	run WriteEntry235(l_multiFormatter_mutex,l_mutex,child_WriteEntry2352);
	child_WriteEntry2352?0;
	run SetObserver161(l_multiFormatter_mutex,l_mutex,child_SetObserver1613);
	child_SetObserver1613?0;
	run Check225(l_multiFormatter_mutex,l_mutex,child_Check2254);
	child_Check2254?0;
	stop_process: skip;
	child!0
}
proctype SetObserver161(Mutexdef l_multiFormatter_mutex;Mutexdef l_mutex;Mutexdef observer_checkMutex;Mutexdef observer_invocationsMutex;Mutexdef observer_writeEntryMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	l_mutex.Lock!false;
	l_mutex.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Check225(Mutexdef l_multiFormatter_mutex;Mutexdef l_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	l_mutex.RLock!false;
	l_mutex.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype WriteEntry235(Mutexdef l_multiFormatter_mutex;Mutexdef l_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	l_mutex.RLock!false;
	l_mutex.RUnlock!false;
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

