
// https://github.com/Dreamacro/clash/blob/master/common/observable/observable_test.go#L24
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestObservable240 = [1] of {int};
	run TestObservable24(child_TestObservable240)
stop_process:skip
}

proctype TestObservable24(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Subscribe360 = [1] of {int};
	Mutexdef src_mux;
	run mutexMonitor(src_mux);
	run Subscribe36(src_mux,child_Subscribe360);
	child_Subscribe360?0;
	stop_process: skip;
	child!0
}
proctype Subscribe36(Mutexdef o_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Out180 = [1] of {int};
	Mutexdef subscriber_once_m;
	o_mux.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(subscriber_once_m);
	run Out18(subscriber_once_m,child_Out180);
	child_Out180?0;
	goto stop_process;
	stop_process: skip;
		o_mux.Unlock!false;
	child!0
}
proctype Out18(Mutexdef s_once_m;chan child) {
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

