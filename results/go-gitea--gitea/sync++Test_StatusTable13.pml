
// https://github.com/go-gitea/gitea/blob/master/modules/sync/status_pool_test.go#L13
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test_StatusTable130 = [1] of {int};
	run Test_StatusTable13(child_Test_StatusTable130)
stop_process:skip
}

proctype Test_StatusTable13(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IsRunning5410 = [1] of {int};
	chan child_Stop479 = [1] of {int};
	chan child_IsRunning548 = [1] of {int};
	chan child_StartIfNotRunning297 = [1] of {int};
	chan child_IsRunning546 = [1] of {int};
	chan child_Stop475 = [1] of {int};
	chan child_IsRunning544 = [1] of {int};
	chan child_StartIfNotRunning293 = [1] of {int};
	chan child_IsRunning542 = [1] of {int};
	chan child_Start401 = [1] of {int};
	chan child_IsRunning540 = [1] of {int};
	Mutexdef table_lock;
	run mutexMonitor(table_lock);
	run IsRunning54(table_lock,child_IsRunning540);
	child_IsRunning540?0;
	run Start40(table_lock,child_Start401);
	child_Start401?0;
	run IsRunning54(table_lock,child_IsRunning542);
	child_IsRunning542?0;
	run StartIfNotRunning29(table_lock,child_StartIfNotRunning293);
	child_StartIfNotRunning293?0;
	run IsRunning54(table_lock,child_IsRunning544);
	child_IsRunning544?0;
	run Stop47(table_lock,child_Stop475);
	child_Stop475?0;
	run IsRunning54(table_lock,child_IsRunning546);
	child_IsRunning546?0;
	run StartIfNotRunning29(table_lock,child_StartIfNotRunning297);
	child_StartIfNotRunning297?0;
	run IsRunning54(table_lock,child_IsRunning548);
	child_IsRunning548?0;
	run Stop47(table_lock,child_Stop479);
	child_Stop479?0;
	run IsRunning54(table_lock,child_IsRunning5410);
	child_IsRunning5410?0;
	stop_process: skip;
	child!0
}
proctype IsRunning54(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	p_lock.RLock!false;
	p_lock.RUnlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Start40(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	p_lock.Lock!false;
	p_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype StartIfNotRunning29(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	p_lock.Lock!false;
	p_lock.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Stop47(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	p_lock.Lock!false;
	p_lock.Unlock!false;
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

