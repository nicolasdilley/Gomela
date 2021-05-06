
// https://github.com/pingcap/tidb/blob/master/expression/builtin_cast.go#L166
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_getFunction1660 = [1] of {int};
	run getFunction166(child_getFunction1660)
stop_process:skip
}

proctype getFunction166(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newBaseBuiltinCastFunc4500 = [1] of {int};
	Mutexdef b_childrenReversedOnce_m;
	Mutexdef b_childrenVectorizedOnce_m;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(b_childrenVectorizedOnce_m);
	run mutexMonitor(b_childrenReversedOnce_m);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run newBaseBuiltinCastFunc450(b_childrenVectorizedOnce_m,b_childrenReversedOnce_m,child_newBaseBuiltinCastFunc4500);
	child_newBaseBuiltinCastFunc4500?0;
	

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
proctype newBaseBuiltinCastFunc450(Mutexdef builtinFunc_childrenVectorizedOnce_m;Mutexdef builtinFunc_childrenReversedOnce_m;chan child) {
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

