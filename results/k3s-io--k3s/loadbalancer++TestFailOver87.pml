
// https://github.com/k3s-io/k3s/blob/master/pkg/agent/loadbalancer/loadbalancer_test.go#L87
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFailOver870 = [1] of {int};
	run TestFailOver87(child_TestFailOver870)
stop_process:skip
}

proctype TestFailOver87(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Update1021 = [1] of {int};
	chan child_LoadBalancerServerURL1160 = [1] of {int};
	Mutexdef lb_dialer_Resolver_lookupGroup_mu;
	Mutexdef lb_mutex;
	run mutexMonitor(lb_mutex);
	run mutexMonitor(lb_dialer_Resolver_lookupGroup_mu);
	run LoadBalancerServerURL116(lb_mutex,lb_dialer_Resolver_lookupGroup_mu,child_LoadBalancerServerURL1160);
	child_LoadBalancerServerURL1160?0;
	run Update102(lb_mutex,lb_dialer_Resolver_lookupGroup_mu,child_Update1021);
	child_Update1021?0;
	stop_process: skip;
	child!0
}
proctype LoadBalancerServerURL116(Mutexdef lb_mutex;Mutexdef lb_dialer_Resolver_lookupGroup_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Update102(Mutexdef lb_mutex;Mutexdef lb_dialer_Resolver_lookupGroup_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_writeConfig102 = [1] of {int};
	chan child_setServers91 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run setServers9(lb_mutex,lb_dialer_Resolver_lookupGroup_mu,child_setServers91);
	child_setServers91?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run writeConfig10(lb_mutex,lb_dialer_Resolver_lookupGroup_mu,child_writeConfig102);
	child_writeConfig102?0;
	stop_process: skip;
	child!0
}
proctype setServers9(Mutexdef lb_mutex;Mutexdef lb_dialer_Resolver_lookupGroup_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	lb_mutex.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		lb_mutex.Unlock!false;
	child!0
}
proctype writeConfig10(Mutexdef lb_mutex;Mutexdef lb_dialer_Resolver_lookupGroup_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

