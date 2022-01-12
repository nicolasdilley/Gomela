// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/model/log_test.go#L19
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLogFullBuffer190 = [1] of {int};
	run TestLogFullBuffer19(child_TestLogFullBuffer190);
	run receiver(child_TestLogFullBuffer190)
stop_process:skip
}

proctype TestLogFullBuffer19(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Notify2494 = [1] of {int};
	chan child_Append2203 = [1] of {int};
	chan child_Append2202 = [1] of {int};
	Mutexdef data_mx;
	chan child_AddListener2971 = [1] of {int};
	chan child_Init950 = [1] of {int};
	Mutexdef m_mx;
	Mutexdef m_items_mx;
	int var_size = -2; // opt var_size
	run mutexMonitor(m_items_mx);
	run mutexMonitor(m_mx);
	run Init95(m_items_mx,m_mx,child_Init950);
	child_Init950?0;
	run AddListener297(m_items_mx,m_mx,child_AddListener2971);
	child_AddListener2971?0;
	run mutexMonitor(data_mx);
	

	if
	:: 0 != -2 && 2*var_size-1 != -3 -> 
				for(i : 0.. 2*var_size-1) {
			for13: skip;
			run Append220(m_items_mx,m_mx,child_Append2203);
			child_Append2203?0;
			for13_end: skip
		};
		for13_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Append220(m_items_mx,m_mx,child_Append2202);
			child_Append2202?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run Notify249(m_items_mx,m_mx,child_Notify2494);
	child_Notify2494?0;
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
proctype Append220(Mutexdef l_items_mx;Mutexdef l_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireLogCleared3732 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	l_mx.Lock!false;
	l_mx.Unlock!false;
	

	if
	:: true -> 
		run fireLogCleared373(l_items_mx,l_mx,child_fireLogCleared3732);
		child_fireLogCleared3732?0
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
	chan child_fireLogBuffChanged3444 = [1] of {int};
	l_mx.Lock!false;
	

	if
	:: true -> 
		run fireLogBuffChanged344(l_items_mx,l_mx,child_fireLogBuffChanged3444);
		child_fireLogBuffChanged3444?0
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
	chan child_fireLogChanged3676 = [1] of {int};
	chan child_fireLogError3615 = [1] of {int};
	chan child_applyFilter3164 = [1] of {int};
	

	if
	:: true -> 
		run applyFilter316(l_items_mx,l_mx,child_applyFilter3164);
		child_applyFilter3164?0;
		

		if
		:: true -> 
			run fireLogError361(l_items_mx,l_mx,child_fireLogError3615);
			child_fireLogError3615?0;
			goto stop_process
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		run fireLogChanged367(l_items_mx,l_mx,child_fireLogChanged3676);
		child_fireLogChanged3676?0
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

