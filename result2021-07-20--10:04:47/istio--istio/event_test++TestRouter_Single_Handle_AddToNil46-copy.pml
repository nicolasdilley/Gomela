// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pkg/config/event/router_test.go#L46
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRouter_Single_Handle_AddToNil460 = [1] of {int};
	run TestRouter_Single_Handle_AddToNil46(child_TestRouter_Single_Handle_AddToNil460);
	run receiver(child_TestRouter_Single_Handle_AddToNil460)
stop_process:skip
}

proctype TestRouter_Single_Handle_AddToNil46(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AddToRouter920 = [1] of {int};
	Mutexdef acc_mu;
	run mutexMonitor(acc_mu);
	run AddToRouter92(acc_mu,child_AddToRouter920);
	child_AddToRouter920?0;
	stop_process: skip;
	child!0
}
proctype AddToRouter92(Mutexdef handler_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_v_routersv_routers = -2; // opt var_v_routersv_routers
	

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
