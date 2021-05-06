
// https://github.com/v2ray/v2ray-core/blob/master/proxy/vmess/encoding/encoding_test.go#L116
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMuxRequest1160 = [1] of {int};
	run TestMuxRequest116(child_TestMuxRequest1160)
stop_process:skip
}

proctype TestMuxRequest116(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close231 = [1] of {int};
	chan child_Close232 = [1] of {int};
	Mutexdef server_sessionHistory_task_access;
	Mutexdef server_userValidator_aeadDecoderHolder_apw_lock;
	Mutexdef server_userValidator_task_access;
	Mutexdef userValidator_aeadDecoderHolder_apw_lock;
	Mutexdef userValidator_task_access;
	Mutexdef sessionHistory_task_access;
	chan child_toAccount180 = [1] of {int};
	Mutexdef account_SecuritySettings_state_atomicMessageInfo_initMu;
	Mutexdef account_state_atomicMessageInfo_initMu;
	run mutexMonitor(account_state_atomicMessageInfo_initMu);
	run mutexMonitor(account_SecuritySettings_state_atomicMessageInfo_initMu);
	run toAccount18(account_state_atomicMessageInfo_initMu,account_SecuritySettings_state_atomicMessageInfo_initMu,child_toAccount180);
	child_toAccount180?0;
	run mutexMonitor(sessionHistory_task_access);
	run mutexMonitor(userValidator_task_access);
	run mutexMonitor(userValidator_aeadDecoderHolder_apw_lock);
	run mutexMonitor(server_userValidator_task_access);
	run mutexMonitor(server_userValidator_aeadDecoderHolder_apw_lock);
	run mutexMonitor(server_sessionHistory_task_access);
	stop_process: skip;
		run Close23(userValidator_task_access,userValidator_aeadDecoderHolder_apw_lock,child_Close232);
	child_Close232?0;
		run Close23(sessionHistory_task_access,child_Close231);
	child_Close231?0;
	child!0
}
proctype toAccount18(Mutexdef a_state_atomicMessageInfo_initMu;Mutexdef a_SecuritySettings_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
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

