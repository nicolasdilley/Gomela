#define not_found_2006  -2

// https://github.com/dapr/dapr/blob/master/pkg/http/api_test.go#L374
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestV1OutputBindingsEndpointsWithTracer3740 = [1] of {int};
	run TestV1OutputBindingsEndpointsWithTracer374(child_TestV1OutputBindingsEndpointsWithTracer3740)
stop_process:skip
}

proctype TestV1OutputBindingsEndpointsWithTracer374(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Shutdown20721 = [1] of {int};
	chan child_StartServerWithTracing20050 = [1] of {int};
	Mutexdef testAPI_extendedMetadata_mu;
	Mutexdef fakeServer_ln_lock;
	run mutexMonitor(fakeServer_ln_lock);
	run mutexMonitor(testAPI_extendedMetadata_mu);
	run StartServerWithTracing2005(fakeServer_ln_lock,child_StartServerWithTracing20050);
	child_StartServerWithTracing20050?0;
	run Shutdown2072(fakeServer_ln_lock,child_Shutdown20721);
	child_Shutdown20721?0;
	stop_process: skip;
	child!0
}
proctype StartServerWithTracing2005(Mutexdef f_ln_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousStartServerWithTracing200801 = [1] of {int};
	chan child_getRouter20600 = [1] of {int};
	run getRouter2060(f_ln_lock,not_found_2006,child_getRouter20600);
	child_getRouter20600?0;
	run AnonymousStartServerWithTracing20080(f_ln_lock,child_AnonymousStartServerWithTracing200801);
	stop_process: skip;
	child!0
}
proctype getRouter2060(Mutexdef f_ln_lock;int endpoints;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousStartServerWithTracing20080(Mutexdef f_ln_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Shutdown2072(Mutexdef f_ln_lock;chan child) {
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

