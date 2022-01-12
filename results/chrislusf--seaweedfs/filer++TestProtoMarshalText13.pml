// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/chrislusf/seaweedfs/blob//weed/filer/filer_notify_test.go#L13
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestProtoMarshalText130 = [1] of {int};
	run TestProtoMarshalText13(child_TestProtoMarshalText130);
	run receiver(child_TestProtoMarshalText130)
stop_process:skip
}

proctype TestProtoMarshalText13(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef notification2_NewEntry_state_atomicMessageInfo_initMu;
	Mutexdef notification2_OldEntry_state_atomicMessageInfo_initMu;
	Mutexdef notification2_state_atomicMessageInfo_initMu;
	Mutexdef notification_NewEntry_state_atomicMessageInfo_initMu;
	Mutexdef notification_OldEntry_state_atomicMessageInfo_initMu;
	Mutexdef notification_state_atomicMessageInfo_initMu;
	Mutexdef oldEntry_Remote_state_atomicMessageInfo_initMu;
	run mutexMonitor(oldEntry_Remote_state_atomicMessageInfo_initMu);
	run mutexMonitor(notification_state_atomicMessageInfo_initMu);
	run mutexMonitor(notification_OldEntry_state_atomicMessageInfo_initMu);
	run mutexMonitor(notification_NewEntry_state_atomicMessageInfo_initMu);
	run mutexMonitor(notification2_state_atomicMessageInfo_initMu);
	run mutexMonitor(notification2_OldEntry_state_atomicMessageInfo_initMu);
	run mutexMonitor(notification2_NewEntry_state_atomicMessageInfo_initMu);
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

