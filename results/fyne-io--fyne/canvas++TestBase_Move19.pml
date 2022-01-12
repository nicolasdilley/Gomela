// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/fyne-io/fyne/blob//canvas/base_internal_test.go#L19
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBase_Move190 = [1] of {int};
	run TestBase_Move19(child_TestBase_Move190);
	run receiver(child_TestBase_Move190)
stop_process:skip
}

proctype TestBase_Move19(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Position431 = [1] of {int};
	chan child_Move510 = [1] of {int};
	Mutexdef base_propertyLock;
	run mutexMonitor(base_propertyLock);
	run Move51(base_propertyLock,child_Move510);
	child_Move510?0;
	run Position43(base_propertyLock,child_Position431);
	child_Position431?0;
	stop_process: skip;
	child!0
}
proctype Move51(Mutexdef r_propertyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_propertyLock.Lock!false;
		defer1: skip;
	r_propertyLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Position43(Mutexdef r_propertyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_propertyLock.RLock!false;
	goto defer1;
		defer1: skip;
	r_propertyLock.RUnlock!false;
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

