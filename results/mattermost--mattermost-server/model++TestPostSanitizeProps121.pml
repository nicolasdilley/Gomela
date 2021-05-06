
// https://github.com/mattermost/mattermost-server/blob/master/model/post_test.go#L121
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPostSanitizeProps1210 = [1] of {int};
	run TestPostSanitizeProps121(child_TestPostSanitizeProps1210)
stop_process:skip
}

proctype TestPostSanitizeProps121(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetProp4596 = [1] of {int};
	chan child_GetProp4595 = [1] of {int};
	chan child_SanitizeProps3704 = [1] of {int};
	Mutexdef post3_propsMu;
	chan child_GetProp4593 = [1] of {int};
	chan child_SanitizeProps3702 = [1] of {int};
	Mutexdef post2_propsMu;
	chan child_GetProp4591 = [1] of {int};
	chan child_SanitizeProps3700 = [1] of {int};
	Mutexdef post1_propsMu;
	run mutexMonitor(post1_propsMu);
	run SanitizeProps370(post1_propsMu,child_SanitizeProps3700);
	child_SanitizeProps3700?0;
	run GetProp459(post1_propsMu,child_GetProp4591);
	child_GetProp4591?0;
	run mutexMonitor(post2_propsMu);
	run SanitizeProps370(post2_propsMu,child_SanitizeProps3702);
	child_SanitizeProps3702?0;
	run GetProp459(post2_propsMu,child_GetProp4593);
	child_GetProp4593?0;
	run mutexMonitor(post3_propsMu);
	run SanitizeProps370(post3_propsMu,child_SanitizeProps3704);
	child_SanitizeProps3704?0;
	run GetProp459(post3_propsMu,child_GetProp4595);
	child_GetProp4595?0;
	run GetProp459(post3_propsMu,child_GetProp4596);
	child_GetProp4596?0;
	stop_process: skip;
	child!0
}
proctype SanitizeProps370(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DelProp4250 = [1] of {int};
	chan child_DelProp4251 = [1] of {int};
	int membersToSanitize = -2;
	

	if
	:: membersToSanitize-1 != -3 -> 
				for(i : 0.. membersToSanitize-1) {
			for10: skip;
			

			if
			:: true -> 
				run DelProp425(o_propsMu,child_DelProp4250);
				child_DelProp4250?0
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			

			if
			:: true -> 
				run DelProp425(o_propsMu,child_DelProp4251);
				child_DelProp4251?0
			:: true;
			fi;
			for13_end: skip
		:: true -> 
			break
		od;
		for13_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype DelProp425(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	o_propsMu.Lock!false;
	stop_process: skip;
		o_propsMu.Unlock!false;
	child!0
}
proctype GetProp459(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	o_propsMu.RLock!false;
	goto stop_process;
	stop_process: skip;
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

