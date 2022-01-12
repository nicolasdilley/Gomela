// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/model/log_test.go#L117
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLogClear1170 = [1] of {int};
	run TestLogClear117(child_TestLogClear1170);
	run receiver(child_TestLogClear1170)
stop_process:skip
}

proctype TestLogClear117(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Clear1007 = [1] of {int};
	chan child_Notify2496 = [1] of {int};
	chan child_Append2204 = [1] of {int};
	chan child_Append2205 = [1] of {int};
	Mutexdef data_mx;
	chan child_AddListener2973 = [1] of {int};
	chan child_GetContainer852 = [1] of {int};
	chan child_GetPath801 = [1] of {int};
	chan child_Init950 = [1] of {int};
	Mutexdef m_mx;
	Mutexdef m_items_mx;
	int var_data_Items = -2; // opt var_data_Items
	run mutexMonitor(m_items_mx);
	run mutexMonitor(m_mx);
	run Init95(m_items_mx,m_mx,child_Init950);
	child_Init950?0;
	run GetPath80(m_items_mx,m_mx,child_GetPath801);
	child_GetPath801?0;
	run GetContainer85(m_items_mx,m_mx,child_GetContainer852);
	child_GetContainer852?0;
	run AddListener297(m_items_mx,m_mx,child_AddListener2973);
	child_AddListener2973?0;
	run mutexMonitor(data_mx);
	

	if
	:: var_data_Items-1 != -3 -> 
				for(i : 0.. var_data_Items-1) {
			for10: skip;
			run Append220(m_items_mx,m_mx,child_Append2204);
			child_Append2204?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			run Append220(m_items_mx,m_mx,child_Append2205);
			child_Append2205?0;
			for13_end: skip
		:: true -> 
			break
		od;
		for13_exit: skip
	fi;
	run Notify249(m_items_mx,m_mx,child_Notify2496);
	child_Notify2496?0;
	run Clear100(m_items_mx,m_mx,child_Clear1007);
	child_Clear1007?0;
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
proctype GetPath80(Mutexdef l_items_mx;Mutexdef l_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetContainer85(Mutexdef l_items_mx;Mutexdef l_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
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
proctype Append220(Mutexdef l_items_mx;Mutexdef l_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireLogCleared3734 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	l_mx.Lock!false;
	l_mx.Unlock!false;
	

	if
	:: true -> 
		run fireLogCleared373(l_items_mx,l_mx,child_fireLogCleared3734);
		child_fireLogCleared3734?0
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
proctype fireLogCleared373(Mutexdef l_items_mx;Mutexdef l_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_l_listeners = -2; // opt var_l_listeners
	stop_process: skip;
	child!0
}
proctype Notify249(Mutexdef l_items_mx;Mutexdef l_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireLogBuffChanged3446 = [1] of {int};
	l_mx.Lock!false;
	

	if
	:: true -> 
		run fireLogBuffChanged344(l_items_mx,l_mx,child_fireLogBuffChanged3446);
		child_fireLogBuffChanged3446?0
	:: true;
	fi;
		defer1: skip;
	l_mx.Unlock!false;
	stop_process: skip;
	child!0
}
proctype fireLogBuffChanged344(Mutexdef l_items_mx;Mutexdef l_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireLogChanged3678 = [1] of {int};
	chan child_fireLogError3617 = [1] of {int};
	chan child_applyFilter3166 = [1] of {int};
	

	if
	:: true -> 
		run applyFilter316(l_items_mx,l_mx,child_applyFilter3166);
		child_applyFilter3166?0;
		

		if
		:: true -> 
			run fireLogError361(l_items_mx,l_mx,child_fireLogError3617);
			child_fireLogError3617?0;
			goto stop_process
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		run fireLogChanged367(l_items_mx,l_mx,child_fireLogChanged3678);
		child_fireLogChanged3678?0
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
proctype Clear100(Mutexdef l_items_mx;Mutexdef l_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireLogCleared3737 = [1] of {int};
	l_mx.Lock!false;
	l_mx.Unlock!false;
	run fireLogCleared373(l_items_mx,l_mx,child_fireLogCleared3737);
	child_fireLogCleared3737?0;
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

