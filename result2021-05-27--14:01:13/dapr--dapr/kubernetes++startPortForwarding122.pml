// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/dapr/dapr/blob/ab83d3535478699a2f2707d9ed9008f78c155d6d/tests/platforms/kubernetes/portforward.go#L122
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_startPortForwarding1220 = [1] of {int};
	run startPortForwarding122(child_startPortForwarding1220);
	run receiver(child_startPortForwarding1220)
stop_process:skip
}

proctype startPortForwarding122(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousstartPortForwarding1451400 = [1] of {int};
	Mutexdef fw_requestIDLock;
	int req_podPorts = -2; // opt req_podPorts
	

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
	run receiver(child_AnonymousstartPortForwarding1451400);
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

proctype receiver(chan c) {
c?0
}

