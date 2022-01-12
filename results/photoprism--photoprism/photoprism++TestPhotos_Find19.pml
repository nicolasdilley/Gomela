// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/photoprism/photos_test.go#L19
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPhotos_Find190 = [1] of {int};
	run TestPhotos_Find19(child_TestPhotos_Find190);
	run receiver(child_TestPhotos_Find190)
stop_process:skip
}

proctype TestPhotos_Find19(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Find611 = [1] of {int};
	chan child_Init300 = [1] of {int};
	Mutexdef photos_mutex;
	run mutexMonitor(photos_mutex);
	run Init30(photos_mutex,child_Init300);
	child_Init300?0;
	run Find61(photos_mutex,child_Find611);
	child_Find611?0;
	stop_process: skip;
	child!0
}
proctype Init30(Mutexdef m_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	m_mutex.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true -> 
		goto defer1
	fi;
		defer1: skip;
	m_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Find61(Mutexdef m_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	m_mutex.RLock!false;
	goto defer1;
		defer1: skip;
	m_mutex.RUnlock!false;
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

