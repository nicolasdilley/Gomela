
// https://github.com/dapr/dapr/blob/master/tests/platforms/kubernetes/portforward.go#L122
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_startPortForwarding1220 = [1] of {int};
	run startPortForwarding122(child_startPortForwarding1220)
stop_process:skip
}

proctype startPortForwarding122(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousstartPortForwarding1451400 = [1] of {int};
	Mutexdef fw_requestIDLock;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(fw_requestIDLock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run AnonymousstartPortForwarding145140(fw_requestIDLock,child_AnonymousstartPortForwarding1451400);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousstartPortForwarding145140(Mutexdef fw_requestIDLock;chan child) {
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

