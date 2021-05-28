// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/fyne-io/fyne/blob/9b5a176fe1dc80beae72a3074d0d5cd2b409637c/internal/preferences_test.go#L135
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInMemoryPreferences_OnChange1350 = [1] of {int};
	run TestInMemoryPreferences_OnChange135(child_TestInMemoryPreferences_OnChange1350);
	run receiver(child_TestInMemoryPreferences_OnChange1350)
stop_process:skip
}

proctype TestInMemoryPreferences_OnChange135(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetString1701 = [1] of {int};
	chan child_AddChangeListener200 = [1] of {int};
	Mutexdef p_lock;
	run mutexMonitor(p_lock);
	run AddChangeListener20(p_lock,child_AddChangeListener200);
	child_AddChangeListener200?0;
	run SetString170(p_lock,child_SetString1701);
	child_SetString1701?0;
	stop_process: skip;
	child!0
}
proctype AddChangeListener20(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	p_lock.Lock!false;
		defer1: skip;
	p_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype SetString170(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_set451 = [1] of {int};
	run set45(p_lock,child_set451);
	child_set451?0;
	stop_process: skip;
	child!0
}
proctype set45(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireChange691 = [1] of {int};
	p_lock.Lock!false;
	p_lock.Unlock!false;
	run fireChange69(p_lock,child_fireChange691);
	child_fireChange691?0;
	stop_process: skip;
	child!0
}
proctype fireChange69(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int p_changeListeners = -2; // opt p_changeListeners
	p_lock.Lock!false;
		defer1: skip;
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

proctype receiver(chan c) {
c?0
}

