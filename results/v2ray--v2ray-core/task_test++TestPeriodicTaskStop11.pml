// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/v2ray/v2ray-core/blob//common/task/periodic_test.go#L11
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPeriodicTaskStop110 = [1] of {int};
	run TestPeriodicTaskStop11(child_TestPeriodicTaskStop110);
	run receiver(child_TestPeriodicTaskStop110)
stop_process:skip
}

proctype TestPeriodicTaskStop11(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close743 = [1] of {int};
	chan child_Start542 = [1] of {int};
	chan child_Close741 = [1] of {int};
	chan child_Start540 = [1] of {int};
	Mutexdef task_access;
	run mutexMonitor(task_access);
	run Start54(task_access,child_Start540);
	child_Start540?0;
	run Close74(task_access,child_Close741);
	child_Close741?0;
	run Start54(task_access,child_Start542);
	child_Start542?0;
	run Close74(task_access,child_Close743);
	child_Close743?0;
	stop_process: skip;
	child!0
}
proctype Start54(Mutexdef t_access;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkedExecute270 = [1] of {int};
	t_access.Lock!false;
	

	if
	:: true -> 
		t_access.Unlock!false;
		goto stop_process
	:: true;
	fi;
	t_access.Unlock!false;
	run checkedExecute27(t_access,child_checkedExecute270);
	child_checkedExecute270?0;
	

	if
	:: true -> 
		t_access.Lock!false;
		t_access.Unlock!false;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype checkedExecute27(Mutexdef t_access;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_hasClosed200 = [1] of {int};
	run hasClosed20(t_access,child_hasClosed200);
	child_hasClosed200?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		t_access.Lock!false;
		t_access.Unlock!false;
		goto stop_process
	:: true;
	fi;
	t_access.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	t_access.Unlock!false;
	stop_process: skip;
	child!0
}
proctype hasClosed20(Mutexdef t_access;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	t_access.Lock!false;
	goto defer1;
		defer1: skip;
	t_access.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Close74(Mutexdef t_access;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	t_access.Lock!false;
	goto defer1;
		defer1: skip;
	t_access.Unlock!false;
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

