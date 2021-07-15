
// https://github.com/hashicorp/packer/blob/master/post-processor/yandex-export/step-create-s3-keys.go#L26
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Run260 = [1] of {int};
	run Run26(child_Run260)
stop_process:skip
}

proctype Run26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef respWithKey_AccessKey_CreatedAt_state_atomicMessageInfo_initMu;
	Mutexdef respWithKey_AccessKey_state_atomicMessageInfo_initMu;
	Mutexdef respWithKey_state_atomicMessageInfo_initMu;
	run mutexMonitor(respWithKey_state_atomicMessageInfo_initMu);
	run mutexMonitor(respWithKey_AccessKey_state_atomicMessageInfo_initMu);
	run mutexMonitor(respWithKey_AccessKey_CreatedAt_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

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

