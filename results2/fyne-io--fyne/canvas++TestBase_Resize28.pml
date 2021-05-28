// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/fyne-io/fyne/blob/9b5a176fe1dc80beae72a3074d0d5cd2b409637c/canvas/base_internal_test.go#L28
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBase_Resize280 = [1] of {int};
	run TestBase_Resize28(child_TestBase_Resize280);
	run receiver(child_TestBase_Resize280)
stop_process:skip
}

proctype TestBase_Resize28(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Size271 = [1] of {int};
	chan child_Resize350 = [1] of {int};
	Mutexdef base_propertyLock;
	run mutexMonitor(base_propertyLock);
	run Resize35(base_propertyLock,child_Resize350);
	child_Resize350?0;
	run Size27(base_propertyLock,child_Size271);
	child_Size271?0;
	stop_process: skip;
	child!0
}
proctype Resize35(Mutexdef r_propertyLock;chan child) {
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
proctype Size27(Mutexdef r_propertyLock;chan child) {
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

