
// https://github.com/dapr/dapr/blob/master/pkg/grpc/api_test.go#L462
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInvokeServiceFromHTTPResponse4620 = [1] of {int};
	run TestInvokeServiceFromHTTPResponse462(child_TestInvokeServiceFromHTTPResponse4620)
stop_process:skip
}

proctype TestInvokeServiceFromHTTPResponse462(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef fakeAPI_extendedMetadata_mu;
	run mutexMonitor(fakeAPI_extendedMetadata_mu);
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

