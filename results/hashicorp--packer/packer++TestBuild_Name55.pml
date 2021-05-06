
// https://github.com/hashicorp/packer/blob/master/packer/build_test.go#L55
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBuild_Name550 = [1] of {int};
	run TestBuild_Name55(child_TestBuild_Name550)
stop_process:skip
}

proctype TestBuild_Name55(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Name621 = [1] of {int};
	chan child_Name620 = [1] of {int};
	Mutexdef build_l;
	run mutexMonitor(build_l);
	run Name62(build_l,child_Name620);
	child_Name620?0;
	

	if
	:: true -> 
		run Name62(build_l,child_Name621);
		child_Name621?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype Name62(Mutexdef b_l;chan child) {
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

