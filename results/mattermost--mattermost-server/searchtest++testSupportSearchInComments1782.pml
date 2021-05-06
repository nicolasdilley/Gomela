
// https://github.com/mattermost/mattermost-server/blob/master/store/searchtest/post_layer.go#L1782
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testSupportSearchInComments17820 = [1] of {int};
	run testSupportSearchInComments1782(child_testSupportSearchInComments17820)
stop_process:skip
}

proctype testSupportSearchInComments1782(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_createReply3850 = [1] of {int};
	Mutexdef r1_propsMu;
	Mutexdef p1_propsMu;
	run mutexMonitor(p1_propsMu);
	run mutexMonitor(r1_propsMu);
	run createReply385(p1_propsMu,child_createReply3850);
	child_createReply3850?0;
	stop_process: skip;
	child!0
}
proctype createReply385(Mutexdef parent_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef replyModel_propsMu;
	run mutexMonitor(replyModel_propsMu);
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

