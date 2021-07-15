
// https://github.com/go-delve/delve/blob/master/pkg/terminal/starbind/conv.go#L450
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_AttrNames4500 = [1] of {int};
	run AttrNames450(child_AttrNames4500)
stop_process:skip
}

proctype AttrNames450(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AttrNames3130 = [1] of {int};
	Mutexdef x_env_contextMu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(x_env_contextMu);
	run AttrNames313(x_env_contextMu,child_AttrNames3130);
	child_AttrNames3130?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AttrNames313(Mutexdef v_env_contextMu;chan child) {
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

