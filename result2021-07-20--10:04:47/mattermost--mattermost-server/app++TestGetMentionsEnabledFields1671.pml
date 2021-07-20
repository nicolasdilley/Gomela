// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/mattermost/mattermost-server/blob/5c16de58a02099df38e1e8486df148d1b798460a/app/notification_test.go#L1671
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetMentionsEnabledFields16710 = [1] of {int};
	run TestGetMentionsEnabledFields1671(child_TestGetMentionsEnabledFields16710);
	run receiver(child_TestGetMentionsEnabledFields16710)
stop_process:skip
}

proctype TestGetMentionsEnabledFields1671(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getMentionsEnabledFields8120 = [1] of {int};
	Mutexdef post_propsMu;
	run mutexMonitor(post_propsMu);
	run getMentionsEnabledFields812(post_propsMu,child_getMentionsEnabledFields8120);
	child_getMentionsEnabledFields8120?0;
	stop_process: skip;
	child!0
}
proctype getMentionsEnabledFields812(Mutexdef post_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_post_Attachments__post_Attachments__ = -2; // opt var_post_Attachments__post_Attachments__
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

proctype receiver(chan c) {
c?0
}
