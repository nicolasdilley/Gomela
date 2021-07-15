
// https://github.com/hashicorp/consul/blob/master/agent/router/manager_internal_test.go#L125
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestManagerInternal_getServerList1250 = [1] of {int};
	run TestManagerInternal_getServerList125(child_TestManagerInternal_getServerList1250)
stop_process:skip
}

proctype TestManagerInternal_getServerList125(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getServerList2240 = [1] of {int};
	Mutexdef m_listLock;
	run mutexMonitor(m_listLock);
	run getServerList224(m_listLock,child_getServerList2240);
	child_getServerList2240?0;
	stop_process: skip;
	child!0
}
proctype getServerList224(Mutexdef m_listLock;chan child) {
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

