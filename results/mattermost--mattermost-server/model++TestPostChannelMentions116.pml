
// https://github.com/mattermost/mattermost-server/blob/master/model/post_test.go#L116
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPostChannelMentions1160 = [1] of {int};
	run TestPostChannelMentions116(child_TestPostChannelMentions1160)
stop_process:skip
}

proctype TestPostChannelMentions116(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ChannelMentions5490 = [1] of {int};
	Mutexdef post_propsMu;
	run mutexMonitor(post_propsMu);
	run ChannelMentions549(post_propsMu,child_ChannelMentions5490);
	child_ChannelMentions5490?0;
	stop_process: skip;
	child!0
}
proctype ChannelMentions549(Mutexdef o_propsMu;chan child) {
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

