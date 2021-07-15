
// https://github.com/grpc/grpc-go/blob/master/xds/internal/httpfilter/router/router.go#L52
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ParseFilterConfig520 = [1] of {int};
	run ParseFilterConfig52(child_ParseFilterConfig520)
stop_process:skip
}

proctype ParseFilterConfig52(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef msg_DynamicStats_state_atomicMessageInfo_initMu;
	Mutexdef msg_state_atomicMessageInfo_initMu;
	Mutexdef any_state_atomicMessageInfo_initMu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(any_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(msg_state_atomicMessageInfo_initMu);
	run mutexMonitor(msg_DynamicStats_state_atomicMessageInfo_initMu);
	

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

