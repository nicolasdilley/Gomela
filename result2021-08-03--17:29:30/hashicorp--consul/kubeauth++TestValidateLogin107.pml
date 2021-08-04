// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/consul/blob/8d6cbe72813779f60ac24d119cc311c21003f4ce/agent/consul/authmethod/kubeauth/k8s_test.go#L107
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestValidateLogin1070 = [1] of {int};
	run TestValidateLogin107(child_TestValidateLogin1070);
	run receiver(child_TestValidateLogin1070)
stop_process:skip
}

proctype TestValidateLogin107(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stop1020 = [1] of {int};
	chan child_SetAllowedServiceAccount833 = [1] of {int};
	chan child_SetAllowedServiceAccount832 = [1] of {int};
	chan child_AuthorizeJWT701 = [1] of {int};
	Mutexdef testSrv_mu;
	Mutexdef testSrv_srv_mu;
	Wgdef testSrv_srv_wg;
	run wgMonitor(testSrv_srv_wg);
	run mutexMonitor(testSrv_srv_mu);
	run mutexMonitor(testSrv_mu);
	run AuthorizeJWT70(testSrv_srv_wg,testSrv_mu,testSrv_srv_mu,child_AuthorizeJWT701);
	child_AuthorizeJWT701?0;
	run SetAllowedServiceAccount83(testSrv_srv_wg,testSrv_mu,testSrv_srv_mu,child_SetAllowedServiceAccount832);
	child_SetAllowedServiceAccount832?0;
	run SetAllowedServiceAccount83(testSrv_srv_wg,testSrv_mu,testSrv_srv_mu,child_SetAllowedServiceAccount833);
	child_SetAllowedServiceAccount833?0;
		defer1: skip;
	run Stop102(testSrv_srv_wg,testSrv_mu,testSrv_srv_mu,child_Stop1020);
	child_Stop1020?0;
	stop_process: skip;
	child!0
}
proctype Stop102(Wgdef s_srv_wg;Mutexdef s_mu;Mutexdef s_srv_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype AuthorizeJWT70(Wgdef s_srv_wg;Mutexdef s_mu;Mutexdef s_srv_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.Lock!false;
		defer1: skip;
	s_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype SetAllowedServiceAccount83(Wgdef s_srv_wg;Mutexdef s_mu;Mutexdef s_srv_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
		defer1: skip;
	s_mu.Unlock!false;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

