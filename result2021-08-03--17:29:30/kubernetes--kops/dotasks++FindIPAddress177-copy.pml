// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kops/blob/e3fbc2ad043e58cfdcf934e015ef8d5d9e42273e/upup/pkg/fi/cloudup/dotasks/loadbalancer.go#L177
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_FindIPAddress1770 = [1] of {int};
	run FindIPAddress177(child_FindIPAddress1770);
	run receiver(child_FindIPAddress1770)
stop_process:skip
}

proctype FindIPAddress177(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetAllLoadBalancers1931 = [1] of {int};
	chan child_LoadBalancers1890 = [1] of {int};
	Mutexdef cloud_Client_ratemtx;
	int var_loadBalancers = -2; // opt var_loadBalancers
	run mutexMonitor(cloud_Client_ratemtx);
	run LoadBalancers189(cloud_Client_ratemtx,child_LoadBalancers1890);
	child_LoadBalancers1890?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		run GetAllLoadBalancers193(cloud_Client_ratemtx,child_GetAllLoadBalancers1931);
		child_GetAllLoadBalancers1931?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype LoadBalancers189(Mutexdef c_Client_ratemtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetAllLoadBalancers193(Mutexdef c_Client_ratemtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getAllLoadBalancers3041 = [1] of {int};
	run getAllLoadBalancers304(c_Client_ratemtx,child_getAllLoadBalancers3041);
	child_getAllLoadBalancers3041?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getAllLoadBalancers304(Mutexdef cloud_Client_ratemtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

