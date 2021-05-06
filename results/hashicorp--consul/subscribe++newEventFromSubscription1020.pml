
// https://github.com/hashicorp/consul/blob/master/agent/rpc/subscribe/subscribe_test.go#L1020
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newEventFromSubscription10200 = [1] of {int};
	run newEventFromSubscription1020(child_newEventFromSubscription10200)
stop_process:skip
}

proctype newEventFromSubscription1020(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Subscribe2990 = [1] of {int};
	Mutexdef ep_subscriptions_lock;
	Mutexdef ep_lock;
	run mutexMonitor(ep_lock);
	run mutexMonitor(ep_subscriptions_lock);
	run Subscribe299(ep_lock,ep_subscriptions_lock,child_Subscribe2990);
	child_Subscribe2990?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Subscribe299(Mutexdef b_lock;Mutexdef b_subscriptions_lock;chan child) {
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

