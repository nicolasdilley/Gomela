
// https://github.com/Dreamacro/clash/blob/master/common/observable/observable_test.go#L77
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestObservable_UnSubscribeWithNotExistSubscription770 = [1] of {int};
	run TestObservable_UnSubscribeWithNotExistSubscription77(child_TestObservable_UnSubscribeWithNotExistSubscription770)
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
		goto stop_process
	:: true;
	fi;
	run Close22(subscriber_once_m,child_Close220);
	child_Close220?0;
	stop_process: skip;
		o_mux.Unlock!false;
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

