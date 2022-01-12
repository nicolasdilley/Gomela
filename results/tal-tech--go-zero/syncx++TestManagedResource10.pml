// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/syncx/managedresource_test.go#L10
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestManagedResource100 = [1] of {int};
	run TestManagedResource10(child_TestManagedResource100);
	run receiver(child_TestManagedResource100)
stop_process:skip
}

proctype TestManagedResource10(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Take324 = [1] of {int};
	chan child_MarkBroken223 = [1] of {int};
	chan child_Take322 = [1] of {int};
	chan child_Take321 = [1] of {int};
	chan child_Take320 = [1] of {int};
	Mutexdef resource_lock;
	run mutexMonitor(resource_lock);
	run Take32(resource_lock,child_Take320);
	child_Take320?0;
	run Take32(resource_lock,child_Take321);
	child_Take321?0;
	run Take32(resource_lock,child_Take322);
	child_Take322?0;
	run MarkBroken22(resource_lock,child_MarkBroken223);
	child_MarkBroken223?0;
	run Take32(resource_lock,child_Take324);
	child_Take324?0;
	stop_process: skip;
	child!0
}
proctype Take32(Mutexdef mr_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	mr_lock.RLock!false;
	mr_lock.RUnlock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	mr_lock.Lock!false;
	goto defer1;
		defer1: skip;
	mr_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype MarkBroken22(Mutexdef mr_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	mr_lock.Lock!false;
		defer1: skip;
	mr_lock.Unlock!false;
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

