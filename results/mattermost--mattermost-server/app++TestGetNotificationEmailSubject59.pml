
// https://github.com/mattermost/mattermost-server/blob/master/app/notification_email_test.go#L59
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetNotificationEmailSubject590 = [1] of {int};
	run TestGetNotificationEmailSubject59(child_TestGetNotificationEmailSubject590)
stop_process:skip
}

proctype TestGetNotificationEmailSubject59(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getNotificationEmailSubject1350 = [1] of {int};
	Mutexdef post_propsMu;
	run mutexMonitor(post_propsMu);
	run getNotificationEmailSubject135(post_propsMu,child_getNotificationEmailSubject1350);
	child_getNotificationEmailSubject1350?0;
	stop_process: skip;
	child!0
}
proctype getNotificationEmailSubject135(Mutexdef post_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getFormattedPostTime2590 = [1] of {int};
	run getFormattedPostTime259(post_propsMu,child_getFormattedPostTime2590);
	child_getFormattedPostTime2590?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getFormattedPostTime259(Mutexdef post_propsMu;chan child) {
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

