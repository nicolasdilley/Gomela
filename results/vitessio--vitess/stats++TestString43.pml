// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/stats/export_test.go#L43
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestString430 = [1] of {int};
	run TestString43(child_TestString430);
	run receiver(child_TestString430)
stop_process:skip
}

proctype TestString43(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_String2072 = [1] of {int};
	chan child_Get1991 = [1] of {int};
	chan child_Set1920 = [1] of {int};
	Mutexdef v_mu;
	Mutexdef gotv_mu;
	run mutexMonitor(gotv_mu);
	run mutexMonitor(v_mu);
	run Set192(v_mu,child_Set1920);
	child_Set1920?0;
	run Get199(v_mu,child_Get1991);
	child_Get1991?0;
	run String207(v_mu,child_String2072);
	child_String2072?0;
	stop_process: skip;
	child!0
}
proctype Set192(Mutexdef v_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	v_mu.Lock!false;
	v_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Get199(Mutexdef v_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	v_mu.Lock!false;
	v_mu.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype String207(Mutexdef v_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get1992 = [1] of {int};
	run Get199(v_mu,child_Get1992);
	child_Get1992?0;
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

