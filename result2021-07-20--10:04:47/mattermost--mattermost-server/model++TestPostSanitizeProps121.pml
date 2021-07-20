// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/mattermost/mattermost-server/blob/5c16de58a02099df38e1e8486df148d1b798460a/model/post_test.go#L121
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPostSanitizeProps1210 = [1] of {int};
	run TestPostSanitizeProps121(child_TestPostSanitizeProps1210);
	run receiver(child_TestPostSanitizeProps1210)
stop_process:skip
}

proctype TestPostSanitizeProps121(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetProp4606 = [1] of {int};
	chan child_GetProp4605 = [1] of {int};
	chan child_SanitizeProps3714 = [1] of {int};
	Mutexdef post3_propsMu;
	chan child_GetProp4603 = [1] of {int};
	chan child_SanitizeProps3712 = [1] of {int};
	Mutexdef post2_propsMu;
	chan child_GetProp4601 = [1] of {int};
	chan child_SanitizeProps3710 = [1] of {int};
	Mutexdef post1_propsMu;
	run mutexMonitor(post1_propsMu);
	run SanitizeProps371(post1_propsMu,child_SanitizeProps3710);
	child_SanitizeProps3710?0;
	run GetProp460(post1_propsMu,child_GetProp4601);
	child_GetProp4601?0;
	run mutexMonitor(post2_propsMu);
	run SanitizeProps371(post2_propsMu,child_SanitizeProps3712);
	child_SanitizeProps3712?0;
	run GetProp460(post2_propsMu,child_GetProp4603);
	child_GetProp4603?0;
	run mutexMonitor(post3_propsMu);
	run SanitizeProps371(post3_propsMu,child_SanitizeProps3714);
	child_SanitizeProps3714?0;
	run GetProp460(post3_propsMu,child_GetProp4605);
	child_GetProp4605?0;
	run GetProp460(post3_propsMu,child_GetProp4606);
	child_GetProp4606?0;
	stop_process: skip;
	child!0
}
proctype SanitizeProps371(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DelProp4260 = [1] of {int};
	chan child_DelProp4261 = [1] of {int};
	int var_o_Participantso_Participants = -2; // opt var_o_Participantso_Participants
	int var_membersToSanitizemembersToSanitize = -2; // opt var_membersToSanitizemembersToSanitize
	

	if
	:: var_membersToSanitize-1 != -3 -> 
				for(i : 0.. var_membersToSanitize-1) {
			for10: skip;
			

			if
			:: true -> 
				run DelProp426(o_propsMu,child_DelProp4260);
				child_DelProp4260?0
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
				run DelProp426(o_propsMu,child_DelProp4261);
				child_DelProp4261?0
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
proctype DelProp426(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_o_Propso_Props = -2; // opt var_o_Propso_Props
	o_propsMu.Lock!false;
		defer1: skip;
	o_propsMu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype GetProp460(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	o_propsMu.RLock!false;
	goto defer1;
		defer1: skip;
	o_propsMu.RUnlock!false;
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

