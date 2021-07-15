
// https://github.com/istio/istio/blob/master/pkg/config/event/router_test.go#L111
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRouter_Multi_NoTarget1110 = [1] of {int};
	run TestRouter_Multi_NoTarget111(child_TestRouter_Multi_NoTarget1110)
stop_process:skip
}

proctype TestRouter_Multi_NoTarget111(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AddToRouter921 = [1] of {int};
	chan child_AddToRouter920 = [1] of {int};
	Mutexdef acc2_mu;
	Mutexdef acc1_mu;
	run mutexMonitor(acc1_mu);
	run mutexMonitor(acc2_mu);
	run AddToRouter92(acc1_mu,child_AddToRouter920);
	child_AddToRouter920?0;
	run AddToRouter92(acc2_mu,child_AddToRouter921);
	child_AddToRouter921?0;
	stop_process: skip;
	child!0
}
proctype AddToRouter92(Mutexdef handler_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
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

