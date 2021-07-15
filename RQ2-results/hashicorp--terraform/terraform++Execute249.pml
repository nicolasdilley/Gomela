
// https://github.com/hashicorp/terraform/blob/master/terraform/node_output.go#L249
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Execute2490 = [1] of {int};
	run Execute249(child_Execute2490)
stop_process:skip
}

proctype Execute249(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_setValue4252 = [1] of {int};
	chan child_setValue4251 = [1] of {int};
	chan child_setValue4250 = [1] of {int};
	Mutexdef changes_lock;
	Mutexdef state_lock;
	run mutexMonitor(state_lock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(changes_lock);
	

	if
	:: true -> 
		

		if
		:: true -> 
			run setValue425(state_lock,changes_lock,child_setValue4250);
			child_setValue4250?0;
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	run setValue425(state_lock,changes_lock,child_setValue4251);
	child_setValue4251?0;
	

	if
	:: true -> 
		run setValue425(state_lock,changes_lock,child_setValue4252);
		child_setValue4252?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype setValue425(Mutexdef state_lock;Mutexdef changes_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true;
		:: true;
		:: true;
		fi
	:: true;
	fi;
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

