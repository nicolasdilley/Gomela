
// https://github.com/pingcap/tidb/blob/master/expression/builtin_cast.go#L369
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_getFunction3690 = [1] of {int};
	run getFunction369(child_getFunction3690)
stop_process:skip
}

proctype getFunction369(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef bf_childrenReversedOnce_m;
	Mutexdef bf_childrenVectorizedOnce_m;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(bf_childrenVectorizedOnce_m);
	run mutexMonitor(bf_childrenReversedOnce_m);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
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

