
// https://github.com/kubernetes/minikube/blob/master/pkg/minikube/bootstrapper/bsutil/kverify/api_server.go#L221
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_apiServerHealthzNow2210 = [1] of {int};
	run apiServerHealthzNow221(child_apiServerHealthzNow2210)
stop_process:skip
}

proctype apiServerHealthzNow221(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef tr_nextProtoOnce_m;
	Mutexdef tr_TLSClientConfig_mutex;
	Mutexdef tr_connsPerHostMu;
	Mutexdef tr_altMu;
	Mutexdef tr_reqMu;
	Mutexdef tr_idleMu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(tr_idleMu);
	run mutexMonitor(tr_reqMu);
	run mutexMonitor(tr_altMu);
	run mutexMonitor(tr_connsPerHostMu);
	run mutexMonitor(tr_TLSClientConfig_mutex);
	run mutexMonitor(tr_nextProtoOnce_m);
	

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

