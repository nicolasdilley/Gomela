// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/model/log_test.go#L140
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLogBasic1400 = [1] of {int};
	run TestLogBasic140(child_TestLogBasic1400);
	run receiver(child_TestLogBasic1400)
stop_process:skip
}

proctype TestLogBasic140(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Set1442 = [1] of {int};
	Mutexdef data_mx;
	chan child_AddListener2971 = [1] of {int};
	chan child_Init950 = [1] of {int};
	Mutexdef m_mx;
	Mutexdef m_items_mx;
	run mutexMonitor(m_items_mx);
	run mutexMonitor(m_mx);
	run Init95(m_items_mx,m_mx,child_Init950);
	child_Init950?0;
	run AddListener297(m_items_mx,m_mx,child_AddListener2971);
	child_AddListener2971?0;
	run mutexMonitor(data_mx);
	run Set144(m_items_mx,m_mx,data_mx,child_Set1442);
	child_Set1442?0;
	stop_process: skip;
	child!0
}
proctype Init95(Mutexdef l_items_mx;Mutexdef l_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype AddListener297(Mutexdef l_items_mx;Mutexdef l_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Set144(Mutexdef l_items_mx;Mutexdef l_mx;Mutexdef items_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireLogChanged3673 = [1] of {int};
	chan child_fireLogCleared3732 = [1] of {int};
	l_mx.Lock!false;
	l_mx.Unlock!false;
	run fireLogCleared373(l_items_mx,l_mx,child_fireLogCleared3732);
	child_fireLogCleared3732?0;
	run fireLogChanged367(l_items_mx,l_mx,child_fireLogChanged3673);
	child_fireLogChanged3673?0;
	stop_process: skip;
	child!0
}
proctype fireLogCleared373(Mutexdef l_items_mx;Mutexdef l_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_l_listeners = -2; // opt var_l_listeners
	stop_process: skip;
	child!0
}
proctype fireLogChanged367(Mutexdef l_items_mx;Mutexdef l_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_l_listeners = -2; // opt var_l_listeners
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

