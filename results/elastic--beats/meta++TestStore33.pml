// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//libbeat/autodiscover/meta/meta_test.go#L33
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStore330 = [1] of {int};
	run TestStore33(child_TestStore330);
	run receiver(child_TestStore330)
stop_process:skip
}

proctype TestStore33(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Remove622 = [1] of {int};
	chan child_Store401 = [1] of {int};
	chan child_Store400 = [1] of {int};
	Mutexdef m_mutex;
	run mutexMonitor(m_mutex);
	run Store40(m_mutex,child_Store400);
	child_Store400?0;
	run Store40(m_mutex,child_Store401);
	child_Store401?0;
	run Remove62(m_mutex,child_Remove622);
	child_Remove622?0;
	stop_process: skip;
	child!0
}
proctype Store40(Mutexdef m_mutex;chan child) {
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
	goto defer1;
		defer1: skip;
	m_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Remove62(Mutexdef m_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	m_mutex.Lock!false;
		defer1: skip;
	m_mutex.Unlock!false;
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

