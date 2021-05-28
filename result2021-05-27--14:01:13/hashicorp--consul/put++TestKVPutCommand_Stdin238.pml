// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/consul/blob/8d6cbe72813779f60ac24d119cc311c21003f4ce/command/kv/put/kv_put_test.go#L238
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestKVPutCommand_Stdin2380 = [1] of {int};
	run TestKVPutCommand_Stdin238(child_TestKVPutCommand_Stdin2380);
	run receiver(child_TestKVPutCommand_Stdin2380)
stop_process:skip
}

proctype TestKVPutCommand_Stdin238(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestKVPutCommand_Stdin2542461 = [1] of {int};
	chan child_New150 = [1] of {int};
	Mutexdef ui_once_m;
	Mutexdef stdinW_p_wrMu;
	Mutexdef stdinR_p_wrMu;
	Mutexdef client_modifyLock;
	run mutexMonitor(client_modifyLock);
	run mutexMonitor(stdinR_p_wrMu);
	run mutexMonitor(stdinW_p_wrMu);
	run mutexMonitor(ui_once_m);
	run New15(ui_once_m,child_New150);
	child_New150?0;
	run AnonymousTestKVPutCommand_Stdin254246(client_modifyLock,stdinR_p_wrMu,stdinW_p_wrMu,ui_once_m,child_AnonymousTestKVPutCommand_Stdin2542461);
	run receiver(child_AnonymousTestKVPutCommand_Stdin2542461);
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype New15(Mutexdef ui_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousTestKVPutCommand_Stdin254246(Mutexdef client_modifyLock;Mutexdef stdinR_p_wrMu;Mutexdef stdinW_p_wrMu;Mutexdef ui_once_m;chan child) {
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

