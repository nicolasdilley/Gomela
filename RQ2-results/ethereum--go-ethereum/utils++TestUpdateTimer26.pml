
// https://github.com/ethereum/go-ethereum/blob/master/les/utils/timeutils_test.go#L26
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUpdateTimer260 = [1] of {int};
	run TestUpdateTimer26(child_TestUpdateTimer260)
stop_process:skip
}

proctype TestUpdateTimer26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Update495 = [1] of {int};
	chan child_NewUpdateTimer334 = [1] of {int};
	chan child_UpdateAt533 = [1] of {int};
	chan child_Update492 = [1] of {int};
	chan child_Update491 = [1] of {int};
	chan child_NewUpdateTimer330 = [1] of {int};
	Mutexdef sim_mu;
	Mutexdef timer_lock;
	run mutexMonitor(timer_lock);
	run mutexMonitor(sim_mu);
	run NewUpdateTimer33(sim_mu,child_NewUpdateTimer330);
	child_NewUpdateTimer330?0;
	run Update49(timer_lock,child_Update491);
	child_Update491?0;
	run Update49(timer_lock,child_Update492);
	child_Update492?0;
	run UpdateAt53(timer_lock,child_UpdateAt533);
	child_UpdateAt533?0;
	run NewUpdateTimer33(sim_mu,child_NewUpdateTimer334);
	child_NewUpdateTimer334?0;
	run Update49(timer_lock,child_Update495);
	child_Update495?0;
	stop_process: skip;
	child!0
}
proctype NewUpdateTimer33(Mutexdef clock_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Update49(Mutexdef t_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_UpdateAt531 = [1] of {int};
	run UpdateAt53(t_lock,child_UpdateAt531);
	child_UpdateAt531?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype UpdateAt53(Mutexdef t_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	t_lock.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		t_lock.Unlock!false;
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

