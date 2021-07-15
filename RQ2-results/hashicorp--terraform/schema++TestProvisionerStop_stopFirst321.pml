
// https://github.com/hashicorp/terraform/blob/master/internal/legacy/helper/schema/provisioner_test.go#L321
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestProvisionerStop_stopFirst3210 = [1] of {int};
	run TestProvisionerStop_stopFirst321(child_TestProvisionerStop_stopFirst3210)
stop_process:skip
}

proctype TestProvisionerStop_stopFirst321(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stop1180 = [1] of {int};
	Mutexdef p_stopOnce_m;
	run mutexMonitor(p_stopOnce_m);
	run Stop118(p_stopOnce_m,child_Stop1180);
	child_Stop1180?0;
	do
	:: true -> 
		break
	:: true -> 
		break
	od;
	stop_process: skip;
	child!0
}
proctype Stop118(Mutexdef p_stopOnce_m;chan child) {
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

