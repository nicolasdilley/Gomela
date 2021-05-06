
// https://github.com/hashicorp/consul/blob/master/agent/consul/stream/event_publisher_test.go#L477
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEventPublisher_Unsubscribe_ClosesSubscription4770 = [1] of {int};
	run TestEventPublisher_Unsubscribe_ClosesSubscription477(child_TestEventPublisher_Unsubscribe_ClosesSubscription4770)
stop_process:skip
}

proctype TestEventPublisher_Unsubscribe_ClosesSubscription477(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Subscribe1570 = [1] of {int};
	Mutexdef publisher_subscriptions_lock;
	Mutexdef publisher_lock;
	run mutexMonitor(publisher_lock);
	run mutexMonitor(publisher_subscriptions_lock);
	run Subscribe157(publisher_lock,publisher_subscriptions_lock,child_Subscribe1570);
	child_Subscribe1570?0;
	stop_process: skip;
	child!0
}
proctype Subscribe157(Mutexdef e_lock;Mutexdef e_subscriptions_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_add2024 = [1] of {int};
	chan child_add2023 = [1] of {int};
	chan child_setCachedSnapshotLocked2782 = [1] of {int};
	chan child_getCachedSnapshotLocked2631 = [1] of {int};
	chan child_add2020 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	e_lock.Lock!false;
	

	if
	:: true -> 
		run add202(e_subscriptions_lock,child_add2020);
		child_add2020?0;
		goto stop_process
	:: true;
	fi;
	run getCachedSnapshotLocked263(e_lock,e_subscriptions_lock,child_getCachedSnapshotLocked2631);
	child_getCachedSnapshotLocked2631?0;
	

	if
	:: true -> 
		run setCachedSnapshotLocked278(e_lock,e_subscriptions_lock,child_setCachedSnapshotLocked2782);
		child_setCachedSnapshotLocked2782?0
	:: true;
	fi;
	

	if
	:: true -> 
		run add202(e_subscriptions_lock,child_add2023);
		child_add2023?0;
		goto stop_process
	:: true;
	fi;
	run add202(e_subscriptions_lock,child_add2024);
	child_add2024?0;
	goto stop_process;
	stop_process: skip;
		e_lock.Unlock!false;
	child!0
}
proctype add202(Mutexdef s_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_unsubscribe2350 = [1] of {int};
	run unsubscribe235(s_lock,child_unsubscribe2350);
	child_unsubscribe2350?0;
	s_lock.Lock!false;
	goto stop_process;
	stop_process: skip;
		s_lock.Unlock!false;
	child!0
}
proctype unsubscribe235(Mutexdef s_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getCachedSnapshotLocked263(Mutexdef e_lock;Mutexdef e_subscriptions_lock;chan child) {
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
proctype setCachedSnapshotLocked278(Mutexdef e_lock;Mutexdef e_subscriptions_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

