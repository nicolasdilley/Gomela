// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/kubernetes/minikube/blob/ce01c06fef829245cf1b940ca59cc55f4fc9c658/hack/update/github.go#L173
#define def_var_schema  -2 // opt schema line 173
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ghUpdate1730 = [1] of {int};
	run ghUpdate173(def_var_schema,child_ghUpdate1730);
	run receiver(child_ghUpdate1730)
stop_process:skip
}

proctype ghUpdate173(int var_schema;chan child) {
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

proctype receiver(chan c) {
c?0
}

