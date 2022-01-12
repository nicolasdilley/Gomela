// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/model/table_test.go#L23
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTableRefresh230 = [1] of {int};
	run TestTableRefresh23(child_TestTableRefresh230);
	run receiver(child_TestTableRefresh230)
stop_process:skip
}

proctype TestTableRefresh23(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Peek1593 = [1] of {int};
	chan child_Refresh982 = [1] of {int};
	chan child_AddListener661 = [1] of {int};
	chan child_SetNamespace1330 = [1] of {int};
	Mutexdef ta_mx;
	run mutexMonitor(ta_mx);
	run SetNamespace133(ta_mx,child_SetNamespace1330);
	child_SetNamespace1330?0;
	run AddListener66(ta_mx,child_AddListener661);
	child_AddListener661?0;
	run Refresh98(ta_mx,child_Refresh982);
	child_Refresh982?0;
	run Peek159(ta_mx,child_Peek1593);
	child_Peek1593?0;
	stop_process: skip;
	child!0
}
proctype SetNamespace133(Mutexdef t_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype AddListener66(Mutexdef t_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Refresh98(Mutexdef t_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_refresh1902 = [1] of {int};
	run refresh190(t_mx,child_refresh1902);
	child_refresh1902?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype refresh190(Mutexdef t_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireTableChanged2753 = [1] of {int};
	chan child_reconcile2202 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run reconcile220(t_mx,child_reconcile2202);
	child_reconcile2202?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run fireTableChanged275(t_mx,child_fireTableChanged2753);
	child_fireTableChanged2753?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype reconcile220(Mutexdef t_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_list2052 = [1] of {int};
	chan child_Get1033 = [1] of {int};
	t_mx.Lock!false;
	

	if
	:: true -> 
		run list205(t_mx,child_list2052);
		child_list2052?0
	:: true -> 
		run Get103(t_mx,child_Get1033);
		child_Get1033?0
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi;
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi
		:: true -> 
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	t_mx.Unlock!false;
	stop_process: skip;
	child!0
}
proctype list205(Mutexdef t_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Get103(Mutexdef t_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype fireTableChanged275(Mutexdef t_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_t_listeners = -2; // opt var_t_listeners
	t_mx.RLock!false;
		defer1: skip;
	t_mx.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype Peek159(Mutexdef t_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	t_mx.RLock!false;
	goto defer1;
		defer1: skip;
	t_mx.RUnlock!false;
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

