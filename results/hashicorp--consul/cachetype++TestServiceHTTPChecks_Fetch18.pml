
// https://github.com/hashicorp/consul/blob/master/agent/cache-types/service_checks_test.go#L18
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestServiceHTTPChecks_Fetch180 = [1] of {int};
	run TestServiceHTTPChecks_Fetch18(child_TestServiceHTTPChecks_Fetch180)
stop_process:skip
}

proctype TestServiceHTTPChecks_Fetch18(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RemoveCheck2083 = [1] of {int};
	chan child_AddCheck2012 = [1] of {int};
	chan child_AddCheck2011 = [1] of {int};
	chan child_AddCheck2010 = [1] of {int};
	Mutexdef a_state_tokens_persistenceLock;
	Mutexdef a_state_tokens_l;
	run mutexMonitor(a_state_tokens_l);
	run mutexMonitor(a_state_tokens_persistenceLock);
	run AddCheck201(a_state_tokens_l,a_state_tokens_persistenceLock,child_AddCheck2010);
	child_AddCheck2010?0;
	run AddCheck201(a_state_tokens_l,a_state_tokens_persistenceLock,child_AddCheck2011);
	child_AddCheck2011?0;
	run AddCheck201(a_state_tokens_l,a_state_tokens_persistenceLock,child_AddCheck2012);
	child_AddCheck2012?0;
	run RemoveCheck208(a_state_tokens_l,a_state_tokens_persistenceLock,child_RemoveCheck2083);
	child_RemoveCheck2083?0;
	stop_process: skip;
	child!0
}
proctype AddCheck201(Mutexdef m_state_tokens_l;Mutexdef m_state_tokens_persistenceLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype RemoveCheck208(Mutexdef m_state_tokens_l;Mutexdef m_state_tokens_persistenceLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

