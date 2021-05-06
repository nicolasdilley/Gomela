
// https://github.com/pingcap/tidb/blob/master/expression/builtin_cast_bench_test.go#L26
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_genCastIntAsInt260 = [1] of {int};
	run genCastIntAsInt26(child_genCastIntAsInt260)
stop_process:skip
}

proctype genCastIntAsInt26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newBaseBuiltinCastFunc4500 = [1] of {int};
	Mutexdef baseFunc_childrenReversedOnce_m;
	Mutexdef baseFunc_childrenVectorizedOnce_m;
	run mutexMonitor(baseFunc_childrenVectorizedOnce_m);
	run mutexMonitor(baseFunc_childrenReversedOnce_m);
	run newBaseBuiltinCastFunc450(baseFunc_childrenVectorizedOnce_m,baseFunc_childrenReversedOnce_m,child_newBaseBuiltinCastFunc4500);
	child_newBaseBuiltinCastFunc4500?0;
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

