
// https://github.com/grpc/grpc-go/blob/master/status/status_test.go#L71
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFromToProto710 = [1] of {int};
	run TestFromToProto71(child_TestFromToProto710)
stop_process:skip
}

proctype TestFromToProto71(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef got_state_atomicMessageInfo_initMu;
	chan child_FromProto720 = [1] of {int};
	Mutexdef err_s_state_atomicMessageInfo_initMu;
	Mutexdef s_state_atomicMessageInfo_initMu;
	run mutexMonitor(s_state_atomicMessageInfo_initMu);
	run mutexMonitor(err_s_state_atomicMessageInfo_initMu);
	run FromProto72(s_state_atomicMessageInfo_initMu,child_FromProto720);
	child_FromProto720?0;
	run mutexMonitor(got_state_atomicMessageInfo_initMu);
	stop_process: skip;
	child!0
}
proctype FromProto72(Mutexdef s_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_FromProto720 = [1] of {int};
	run FromProto72(s_state_atomicMessageInfo_initMu,child_FromProto720);
	child_FromProto720?0;
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

