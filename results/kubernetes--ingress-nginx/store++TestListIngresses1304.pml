// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/ingress-nginx/blob//internal/ingress/controller/store/store_test.go#L1304
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestListIngresses13040 = [1] of {int};
	run TestListIngresses1304(child_TestListIngresses13040);
	run receiver(child_TestListIngresses13040)
stop_process:skip
}

proctype TestListIngresses1304(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ListIngresses9050 = [1] of {int};
	Mutexdef s_backendConfigMu;
	Mutexdef s_syncSecretMu;
	run mutexMonitor(s_syncSecretMu);
	run mutexMonitor(s_backendConfigMu);
	run ListIngresses905(s_backendConfigMu,s_syncSecretMu,child_ListIngresses9050);
	child_ListIngresses9050?0;
	stop_process: skip;
	child!0
}
proctype ListIngresses905(Mutexdef s_backendConfigMu;Mutexdef s_syncSecretMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_s_listers_IngressWithAnnotation_List = -2; // opt var_s_listers_IngressWithAnnotation_List
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

