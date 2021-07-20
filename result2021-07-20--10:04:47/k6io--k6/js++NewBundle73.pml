// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/k6io/k6/blob/af1e032ebf949cde092d4a2eddb78528ea0a5864/js/bundle.go#L73
#define not_found_318  -2 // opt data line 120
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewBundle730 = [1] of {int};
	run NewBundle73(child_NewBundle730);
	run receiver(child_NewBundle730)
stop_process:skip
}

proctype NewBundle73(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getExports1941 = [1] of {int};
	chan child_instantiate2860 = [1] of {int};
	Mutexdef rt_vm_interruptLock;
	Mutexdef pgm_src_mu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(pgm_src_mu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(rt_vm_interruptLock);
	run instantiate286(rt_vm_interruptLock,child_instantiate2860);
	child_instantiate2860?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getExports194(rt_vm_interruptLock,child_getExports1941);
	child_getExports1941?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype instantiate286(Mutexdef rt_vm_interruptLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_BindToGlobal1202 = [1] of {int};
	chan child_WithRuntime371 = [1] of {int};
	chan child_Bind1370 = [1] of {int};
	int var_b_RuntimeOptions_Envb_RuntimeOptions_Env = -2; // opt var_b_RuntimeOptions_Envb_RuntimeOptions_Env
	run Bind137(rt_vm_interruptLock,child_Bind1370);
	child_Bind1370?0;
	run WithRuntime37(rt_vm_interruptLock,child_WithRuntime371);
	child_WithRuntime371?0;
	run BindToGlobal120(rt_vm_interruptLock,not_found_318,child_BindToGlobal1202);
	child_BindToGlobal1202?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Bind137(Mutexdef rt_vm_interruptLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_typ_NumField__typ_NumField__ = -2; // opt var_typ_NumField__typ_NumField__
	int var_varArgsLenvarArgsLen = -2; // opt var_varArgsLenvarArgsLen
	int var_numInnumIn = -2; // opt var_numInnumIn
	int var_typ_NumMethod__typ_NumMethod__ = -2; // opt var_typ_NumMethod__typ_NumMethod__
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype WithRuntime37(Mutexdef rt_vm_interruptLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype BindToGlobal120(Mutexdef rt_vm_interruptLock;int data;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_keyskeys = -2; // opt var_keyskeys
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getExports194(Mutexdef rt_vm_interruptLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_exports_Keys__exports_Keys__ = -2; // opt var_exports_Keys__exports_Keys__
	

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

proctype receiver(chan c) {
c?0
}

