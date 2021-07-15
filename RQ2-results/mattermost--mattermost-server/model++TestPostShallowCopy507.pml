
// https://github.com/mattermost/mattermost-server/blob/master/model/post_test.go#L507
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPostShallowCopy5070 = [1] of {int};
	run TestPostShallowCopy507(child_TestPostShallowCopy5070)
stop_process:skip
}

proctype TestPostShallowCopy507(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ShallowCopy1781 = [1] of {int};
	chan child_ShallowCopy1780 = [1] of {int};
	Mutexdef p_propsMu;
	Mutexdef dst_propsMu;
	run mutexMonitor(dst_propsMu);
	run mutexMonitor(p_propsMu);
	run ShallowCopy178(p_propsMu,dst_propsMu,child_ShallowCopy1780);
	child_ShallowCopy1780?0;
	run ShallowCopy178(p_propsMu,dst_propsMu,child_ShallowCopy1781);
	child_ShallowCopy1781?0;
	stop_process: skip;
	child!0
}
proctype ShallowCopy178(Mutexdef o_propsMu;Mutexdef dst_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	o_propsMu.RLock!false;
	dst_propsMu.Lock!false;
	goto stop_process;
	stop_process: skip;
		dst_propsMu.Unlock!false;
		o_propsMu.RUnlock!false;
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

