// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob//pkg/config/event/handlers_test.go#L71
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHandlers_Handle_Multiple_MultipleEvents710 = [1] of {int};
	run TestHandlers_Handle_Multiple_MultipleEvents71(child_TestHandlers_Handle_Multiple_MultipleEvents710);
	run receiver(child_TestHandlers_Handle_Multiple_MultipleEvents710)
stop_process:skip
}

proctype TestHandlers_Handle_Multiple_MultipleEvents71(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Add331 = [1] of {int};
	Mutexdef h2_mu;
	chan child_Add330 = [1] of {int};
	Mutexdef h1_mu;
	run mutexMonitor(h1_mu);
	run Add33(h1_mu,child_Add330);
	child_Add330?0;
	run mutexMonitor(h2_mu);
	run Add33(h2_mu,child_Add331);
	child_Add331?0;
	stop_process: skip;
	child!0
}
proctype Add33(Mutexdef h_mu;chan child) {
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

proctype receiver(chan c) {
c?0
}

