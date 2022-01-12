// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grafana/k6/blob//js/modules/k6/grpc/client.go#L76
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_XClient760 = [1] of {int};
	run XClient76(child_XClient760);
	run receiver(child_XClient760)
stop_process:skip
}

proctype XClient76(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Bind1370 = [1] of {int};
	Mutexdef rt_vm_interruptLock;
	Mutexdef rt_vm_prg_src_mu;
	run mutexMonitor(rt_vm_prg_src_mu);
	run mutexMonitor(rt_vm_interruptLock);
	run Bind137(rt_vm_interruptLock,rt_vm_prg_src_mu,child_Bind1370);
	child_Bind1370?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Bind137(Mutexdef rt_vm_interruptLock;Mutexdef rt_vm_prg_src_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_typ_NumField = -2; // opt var_typ_NumField
	int var_varArgsLen = -2; // opt var_varArgsLen
	int var_numIn = -2; // opt var_numIn
	int var_typ_NumMethod = -2; // opt var_typ_NumMethod
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

