
// https://github.com/hashicorp/terraform/blob/master/plugin6/convert/diagnostics.go#L25
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_AppendProtoDiag250 = [1] of {int};
	run AppendProtoDiag25(child_AppendProtoDiag250)
stop_process:skip
}

proctype AppendProtoDiag25(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ap_state_atomicMessageInfo_initMu;
	

	if
	:: true -> 
		run mutexMonitor(ap_state_atomicMessageInfo_initMu)
	:: true;
	:: true;
	:: true;
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

