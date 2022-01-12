// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/model/cmd_buff_test.go#L42
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCmdBuffDeactivate420 = [1] of {int};
	run TestCmdBuffDeactivate42(child_TestCmdBuffDeactivate420);
	run receiver(child_TestCmdBuffDeactivate420)
stop_process:skip
}

proctype TestCmdBuffDeactivate42(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IsActive642 = [1] of {int};
	chan child_SetActive691 = [1] of {int};
	chan child_AddListener1610 = [1] of {int};
	Mutexdef b_mx;
	run mutexMonitor(b_mx);
	run AddListener161(b_mx,child_AddListener1610);
	child_AddListener1610?0;
	run SetActive69(b_mx,child_SetActive691);
	child_SetActive691?0;
	run IsActive64(b_mx,child_IsActive642);
	child_IsActive642?0;
	stop_process: skip;
	child!0
}
proctype AddListener161(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mx.Lock!false;
		defer1: skip;
	c_mx.Unlock!false;
	stop_process: skip;
	child!0
}
proctype SetActive69(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireActive2001 = [1] of {int};
	run fireActive200(c_mx,child_fireActive2001);
	child_fireActive2001?0;
	stop_process: skip;
	child!0
}
proctype fireActive200(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_c_listeners = -2; // opt var_c_listeners
	stop_process: skip;
	child!0
}
proctype IsActive64(Mutexdef c_mx;chan child) {
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

