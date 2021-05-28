// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/kubernetes/minikube/blob/ce01c06fef829245cf1b940ca59cc55f4fc9c658/pkg/minikube/registry/registry_test.go#L55
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestList550 = [1] of {int};
	run TestList55(child_TestList550);
	run receiver(child_TestList550)
stop_process:skip
}

proctype TestList55(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_List1551 = [1] of {int};
	chan child_Register1350 = [1] of {int};
	Mutexdef r_lock;
	run mutexMonitor(r_lock);
	run Register135(r_lock,child_Register1350);
	child_Register1350?0;
	run List155(r_lock,child_List1551);
	child_List1551?0;
	stop_process: skip;
	child!0
}
proctype Register135(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int def_Alias = -2; // opt def_Alias
	r_lock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	r_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype List155(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int r_drivers = -2; // opt r_drivers
	r_lock.RLock!false;
	goto defer1;
		defer1: skip;
	r_lock.RUnlock!false;
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

