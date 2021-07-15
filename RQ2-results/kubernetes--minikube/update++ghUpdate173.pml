#define schema173  -2

// https://github.com/kubernetes/minikube/blob/master/hack/update/github.go#L173
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ghUpdate1730 = [1] of {int};
	run ghUpdate173(schema173,child_ghUpdate1730)
stop_process:skip
}

proctype ghUpdate173(int schema;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ghc_rateMu;
	Mutexdef ghc_clientMu;
	run mutexMonitor(ghc_clientMu);
	run mutexMonitor(ghc_rateMu);
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

