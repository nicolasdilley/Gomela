// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/minikube/blob/ce01c06fef829245cf1b940ca59cc55f4fc9c658/pkg/minikube/tunnel/kic/ssh_conn.go#L96
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_createSSHConnWithRandomPorts960 = [1] of {int};
	run createSSHConnWithRandomPorts96(child_createSSHConnWithRandomPorts960);
	run receiver(child_createSSHConnWithRandomPorts960)
stop_process:skip
}

proctype createSSHConnWithRandomPorts96(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cmd_Process_sigMu;
	int var_svc_Spec_Portssvc_Spec_Ports = -2; // opt var_svc_Spec_Portssvc_Spec_Ports
	run mutexMonitor(cmd_Process_sigMu);
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
