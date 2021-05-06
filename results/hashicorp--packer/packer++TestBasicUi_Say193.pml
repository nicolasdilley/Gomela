
// https://github.com/hashicorp/packer/blob/master/packer/ui_test.go#L193
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBasicUi_Say1930 = [1] of {int};
	run TestBasicUi_Say193(child_TestBasicUi_Say1930)
stop_process:skip
}

proctype TestBasicUi_Say193(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_readWriter143 = [1] of {int};
	chan child_Say472 = [1] of {int};
	chan child_readWriter141 = [1] of {int};
	chan child_Say470 = [1] of {int};
	Mutexdef bufferUi_l;
	run mutexMonitor(bufferUi_l);
	run Say47(bufferUi_l,child_Say470);
	child_Say470?0;
	run readWriter14(bufferUi_l,child_readWriter141);
	child_readWriter141?0;
	run Say47(bufferUi_l,child_Say472);
	child_Say472?0;
	run readWriter14(bufferUi_l,child_readWriter143);
	child_readWriter143?0;
	stop_process: skip;
	child!0
}
proctype Say47(Mutexdef u_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_colorize730 = [1] of {int};
	run colorize73(u_l,child_colorize730);
	child_colorize730?0;
	stop_process: skip;
	child!0
}
proctype colorize73(Mutexdef u_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_supportsColors860 = [1] of {int};
	run supportsColors86(u_l,child_supportsColors860);
	child_supportsColors860?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype supportsColors86(Mutexdef u_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype readWriter14(Mutexdef ui_l;chan child) {
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

