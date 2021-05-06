
// https://github.com/hashicorp/terraform/blob/master/builtin/provisioners/local-exec/resource_provisioner_test.go#L168
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestResourceProvider_ApplyCustomEnv1680 = [1] of {int};
	run TestResourceProvider_ApplyCustomEnv168(child_TestResourceProvider_ApplyCustomEnv1680)
stop_process:skip
}

proctype TestResourceProvider_ApplyCustomEnv168(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef output_once_m;
	run mutexMonitor(output_once_m);
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

