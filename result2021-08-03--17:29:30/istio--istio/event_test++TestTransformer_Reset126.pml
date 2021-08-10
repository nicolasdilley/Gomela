// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pkg/config/event/transformer_test.go#L126
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTransformer_Reset1260 = [1] of {int};
	run TestTransformer_Reset126(child_TestTransformer_Reset1260);
	run receiver(child_TestTransformer_Reset1260)
stop_process:skip
}

proctype TestTransformer_Reset126(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DispatchFor921 = [1] of {int};
	Mutexdef accBaz_mu;
	chan child_DispatchFor920 = [1] of {int};
	Mutexdef accBar_mu;
	run mutexMonitor(accBar_mu);
	run DispatchFor92(accBar_mu,child_DispatchFor920);
	child_DispatchFor920?0;
	run mutexMonitor(accBaz_mu);
	run DispatchFor92(accBaz_mu,child_DispatchFor921);
	child_DispatchFor921?0;
	stop_process: skip;
	child!0
}
proctype DispatchFor92(Mutexdef h_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AddToRouter920 = [1] of {int};
	run AddToRouter92(h_mu,child_AddToRouter920);
	child_AddToRouter920?0;
	stop_process: skip;
	child!0
}
proctype AddToRouter92(Mutexdef handler_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_v_routers = -2; // opt var_v_routers
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		goto stop_process
	:: true;
	fi;
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
