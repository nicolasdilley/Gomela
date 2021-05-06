
// https://github.com/kubernetes/minikube/blob/master/pkg/minikube/registry/registry_test.go#L25
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRegister250 = [1] of {int};
	run TestRegister25(child_TestRegister250)
stop_process:skip
}

proctype TestRegister25(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Register1351 = [1] of {int};
	chan child_Register1350 = [1] of {int};
	Mutexdef r_lock;
	run mutexMonitor(r_lock);
	run Register135(r_lock,child_Register1350);
	child_Register1350?0;
	run Register135(r_lock,child_Register1351);
	child_Register1351?0;
	stop_process: skip;
	child!0
}
proctype Register135(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_lock.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		r_lock.Unlock!false;
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

