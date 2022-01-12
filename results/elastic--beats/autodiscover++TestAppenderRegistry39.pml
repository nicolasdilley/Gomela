// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//libbeat/autodiscover/appender_test.go#L39
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAppenderRegistry390 = [1] of {int};
	run TestAppenderRegistry39(child_TestAppenderRegistry390);
	run receiver(child_TestAppenderRegistry390)
stop_process:skip
}

proctype TestAppenderRegistry39(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_BuildAppender732 = [1] of {int};
	chan child_GetAppender641 = [1] of {int};
	chan child_AddAppender410 = [1] of {int};
	Mutexdef reg_lock;
	run mutexMonitor(reg_lock);
	run AddAppender41(reg_lock,child_AddAppender410);
	child_AddAppender410?0;
	run GetAppender64(reg_lock,child_GetAppender641);
	child_GetAppender641?0;
	run BuildAppender73(reg_lock,child_BuildAppender732);
	child_BuildAppender732?0;
	stop_process: skip;
	child!0
}
proctype AddAppender41(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_lock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	r_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype GetAppender64(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_lock.RLock!false;
	goto defer1;
		defer1: skip;
	r_lock.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype BuildAppender73(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetAppender642 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run GetAppender64(r_lock,child_GetAppender642);
	child_GetAppender642?0;
	

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

proctype receiver(chan c) {
c?0
}

