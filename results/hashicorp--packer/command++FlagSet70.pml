
// https://github.com/hashicorp/packer/blob/master/command/meta.go#L70
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_FlagSet700 = [1] of {int};
	run FlagSet70(child_FlagSet700)
stop_process:skip
}

proctype FlagSet70(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousFlagSet79770 = [1] of {int};
	Mutexdef errW_p_once_m;
	Mutexdef errW_p_wrMu;
	Mutexdef errR_p_once_m;
	Mutexdef errR_p_wrMu;
	run mutexMonitor(errR_p_wrMu);
	run mutexMonitor(errR_p_once_m);
	run mutexMonitor(errW_p_wrMu);
	run mutexMonitor(errW_p_once_m);
	run AnonymousFlagSet7977(errR_p_wrMu,errR_p_once_m,errW_p_wrMu,errW_p_once_m,child_AnonymousFlagSet79770);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousFlagSet7977(Mutexdef errR_p_wrMu;Mutexdef errR_p_once_m;Mutexdef errW_p_wrMu;Mutexdef errW_p_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

