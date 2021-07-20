// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/command/views/hook_json_test.go#L257
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestJSONHook_refresh2570 = [1] of {int};
	run TestJSONHook_refresh257(child_TestJSONHook_refresh2570);
	run receiver(child_TestJSONHook_refresh2570)
stop_process:skip
}

proctype TestJSONHook_refresh257(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PostRefresh1521 = [1] of {int};
	chan child_PreRefresh1460 = [1] of {int};
	Mutexdef hook_applyingLock;
	run mutexMonitor(hook_applyingLock);
	run PreRefresh146(hook_applyingLock,child_PreRefresh1460);
	child_PreRefresh1460?0;
	run PostRefresh152(hook_applyingLock,child_PostRefresh1521);
	child_PostRefresh1521?0;
	stop_process: skip;
	child!0
}
proctype PreRefresh146(Mutexdef h_applyingLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype PostRefresh152(Mutexdef h_applyingLock;chan child) {
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

proctype receiver(chan c) {
c?0
}

