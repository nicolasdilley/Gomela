// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/model/log_test.go#L186
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLogTimedout1860 = [1] of {int};
	run TestLogTimedout186(child_TestLogTimedout1860);
	run receiver(child_TestLogTimedout1860)
stop_process:skip
}

proctype TestLogTimedout186(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Notify2495 = [1] of {int};
	chan child_Append2203 = [1] of {int};
	chan child_Append2204 = [1] of {int};
	Mutexdef data_mx;
	chan child_Filter1722 = [1] of {int};
	chan child_AddListener2971 = [1] of {int};
	chan child_Init950 = [1] of {int};
	Mutexdef m_mx;
	Mutexdef m_items_mx;
	int var_data_Items = -2; // opt var_data_Items
	run mutexMonitor(m_items_mx);
	run mutexMonitor(m_mx);
	run Init95(m_items_mx,m_mx,child_Init950);
	child_Init950?0;
	run AddListener297(m_items_mx,m_mx,child_AddListener2971);
	child_AddListener2971?0;
	run Filter172(m_items_mx,m_mx,child_Filter1722);
	child_Filter1722?0;
	run mutexMonitor(data_mx);
	

	if
	:: var_data_Items-1 != -3 -> 
				for(i : 0.. var_data_Items-1) {
			for50: skip;
			run Append220(m_items_mx,m_mx,child_Append2203);
			child_Append2203?0;
			for50_end: skip
		};
		for50_exit: skip
	:: else -> 
		do
		:: true -> 
			for51: skip;
			run Append220(m_items_mx,m_mx,child_Append2204);
			child_Append2204?0;
			for51_end: skip
		:: true -> 
			break
		od;
		for51_exit: skip
	fi;
	run Notify249(m_items_mx,m_mx,child_Notify2495);
	child_Notify2495?0;
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
proctype Filter172(Mutexdef l_items_mx;Mutexdef l_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireLogBuffChanged3445 = [1] of {int};
	chan child_fireLogCleared3734 = [1] of {int};
	chan child_fireLogBuffChanged3443 = [1] of {int};
	chan child_fireLogCleared3732 = [1] of {int};
	l_mx.Lock!false;
	

	if
	:: true -> 
		run fireLogCleared373(l_items_mx,l_mx,child_fireLogCleared3732);
		child_fireLogCleared3732?0;
		run fireLogBuffChanged344(l_items_mx,l_mx,l_items_mx,child_fireLogBuffChanged3443);
		child_fireLogBuffChanged3443?0;
		goto defer1
	:: true;
	fi;
	run fireLogCleared373(l_items_mx,l_mx,child_fireLogCleared3734);
	child_fireLogCleared3734?0;
	run fireLogBuffChanged344(l_items_mx,l_mx,l_items_mx,child_fireLogBuffChanged3445);
	child_fireLogBuffChanged3445?0;
		defer1: skip;
	l_mx.Unlock!false;
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
proctype fireLogBuffChanged344(Mutexdef l_items_mx;Mutexdef l_mx;Mutexdef lines_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireLogChanged3675 = [1] of {int};
	chan child_fireLogError3614 = [1] of {int};
	chan child_applyFilter3163 = [1] of {int};
	

	if
	:: true -> 
		run applyFilter316(l_items_mx,l_mx,child_applyFilter3163);
		child_applyFilter3163?0;
		

		if
		:: true -> 
			run fireLogError361(l_items_mx,l_mx,child_fireLogError3614);
			child_fireLogError3614?0;
			goto stop_process
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		run fireLogChanged367(l_items_mx,l_mx,child_fireLogChanged3675);
		child_fireLogChanged3675?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype applyFilter316(Mutexdef l_items_mx;Mutexdef l_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_matches = -2; // opt var_matches
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype fireLogError361(Mutexdef l_items_mx;Mutexdef l_mx;chan child) {
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
proctype Append220(Mutexdef l_items_mx;Mutexdef l_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireLogCleared3733 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	l_mx.Lock!false;
	l_mx.Unlock!false;
	

	if
	:: true -> 
		run fireLogCleared373(l_items_mx,l_mx,child_fireLogCleared3733);
		child_fireLogCleared3733?0
	:: true;
	fi;
	l_mx.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
		defer1: skip;
	l_mx.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Notify249(Mutexdef l_items_mx;Mutexdef l_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireLogBuffChanged3445 = [1] of {int};
	l_mx.Lock!false;
	

	if
	:: true -> 
		run fireLogBuffChanged344(l_items_mx,l_mx,child_fireLogBuffChanged3445);
		child_fireLogBuffChanged3445?0
	:: true;
	fi;
		defer1: skip;
	l_mx.Unlock!false;
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

