// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//libbeat/autodiscover/builder_test.go#L41
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBuilderRegistry410 = [1] of {int};
	run TestBuilderRegistry41(child_TestBuilderRegistry410);
	run receiver(child_TestBuilderRegistry410)
stop_process:skip
}

proctype TestBuilderRegistry41(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_BuildBuilder812 = [1] of {int};
	chan child_GetBuilder721 = [1] of {int};
	chan child_AddBuilder490 = [1] of {int};
	Mutexdef reg_lock;
	run mutexMonitor(reg_lock);
	run AddBuilder49(reg_lock,child_AddBuilder490);
	child_AddBuilder490?0;
	run GetBuilder72(reg_lock,child_GetBuilder721);
	child_GetBuilder721?0;
	run BuildBuilder81(reg_lock,child_BuildBuilder812);
	child_BuildBuilder812?0;
	stop_process: skip;
	child!0
}
proctype AddBuilder49(Mutexdef r_lock;chan child) {
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
proctype GetBuilder72(Mutexdef r_lock;chan child) {
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
proctype BuildBuilder81(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetBuilder722 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run GetBuilder72(r_lock,child_GetBuilder722);
	child_GetBuilder722?0;
	

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

