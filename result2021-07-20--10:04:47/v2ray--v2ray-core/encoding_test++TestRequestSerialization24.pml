// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/v2ray/v2ray-core/blob/5dffca84234a74da9e8174f1e0b0af3dfb2a58ce/proxy/vmess/encoding/encoding_test.go#L24
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRequestSerialization240 = [1] of {int};
	run TestRequestSerialization24(child_TestRequestSerialization240);
	run receiver(child_TestRequestSerialization240)
stop_process:skip
}

proctype TestRequestSerialization24(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close230 = [1] of {int};
	chan child_Close231 = [1] of {int};
	Mutexdef userValidator_task_access;
	Mutexdef sessionHistory_task_access;
	run mutexMonitor(sessionHistory_task_access);
	run mutexMonitor(userValidator_task_access);
		defer2: skip;
	run Close23(userValidator_task_access,child_Close231);
	child_Close231?0;
		defer1: skip;
	run Close23(sessionHistory_task_access,child_Close230);
	child_Close230?0;
	stop_process: skip;
	child!0
}
proctype Close23(Mutexdef obj_task_access;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
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

proctype receiver(chan c) {
c?0
}

