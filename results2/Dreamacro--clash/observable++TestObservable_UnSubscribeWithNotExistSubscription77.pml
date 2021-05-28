// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/Dreamacro/clash/blob/baf03b81e36e3c5d8b9a370ebb82dd2b25b4a58d/common/observable/observable_test.go#L77
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestObservable_UnSubscribeWithNotExistSubscription770 = [1] of {int};
	run TestObservable_UnSubscribeWithNotExistSubscription77(child_TestObservable_UnSubscribeWithNotExistSubscription770);
	run receiver(child_TestObservable_UnSubscribeWithNotExistSubscription770)
stop_process:skip
}

proctype TestObservable_UnSubscribeWithNotExistSubscription77(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_UnSubscribe470 = [1] of {int};
	Mutexdef src_mux;
	run mutexMonitor(src_mux);
	run UnSubscribe47(src_mux,child_UnSubscribe470);
	child_UnSubscribe470?0;
	stop_process: skip;
	child!0
}
proctype UnSubscribe47(Mutexdef o_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close220 = [1] of {int};
	Mutexdef subscriber_once_m;
	o_mux.Lock!false;
	run mutexMonitor(subscriber_once_m);
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run Close22(subscriber_once_m,child_Close220);
	child_Close220?0;
		defer1: skip;
	o_mux.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Close22(Mutexdef s_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

