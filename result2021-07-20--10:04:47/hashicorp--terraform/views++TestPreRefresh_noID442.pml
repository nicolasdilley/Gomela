// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/command/views/hook_ui_test.go#L442
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPreRefresh_noID4420 = [1] of {int};
	run TestPreRefresh_noID442(child_TestPreRefresh_noID4420);
	run receiver(child_TestPreRefresh_noID4420)
stop_process:skip
}

proctype TestPreRefresh_noID442(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PreRefresh2490 = [1] of {int};
	Mutexdef h_resourcesLock;
	Mutexdef h_viewLock;
	run mutexMonitor(h_viewLock);
	run mutexMonitor(h_resourcesLock);
	run PreRefresh249(h_resourcesLock,h_viewLock,child_PreRefresh2490);
	child_PreRefresh2490?0;
	stop_process: skip;
	child!0
}
proctype PreRefresh249(Mutexdef h_resourcesLock;Mutexdef h_viewLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_println2850 = [1] of {int};
	run println285(h_resourcesLock,h_viewLock,child_println2850);
	child_println2850?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype println285(Mutexdef h_resourcesLock;Mutexdef h_viewLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	h_viewLock.Lock!false;
		defer1: skip;
	h_viewLock.Unlock!false;
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
