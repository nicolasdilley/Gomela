
// https://github.com/hashicorp/terraform/blob/master/terraform/context_input_test.go#L349
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContext2Input_providerVarsModuleInherit3490 = [1] of {int};
	run TestContext2Input_providerVarsModuleInherit349(child_TestContext2Input_providerVarsModuleInherit3490)
stop_process:skip
}

proctype TestContext2Input_providerVarsModuleInherit349(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Input220 = [1] of {int};
	Mutexdef ctx_l;
	run mutexMonitor(ctx_l);
	run Input22(ctx_l,child_Input220);
	child_Input220?0;
	stop_process: skip;
	child!0
}
proctype Input22(Mutexdef c_l;chan child) {
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

