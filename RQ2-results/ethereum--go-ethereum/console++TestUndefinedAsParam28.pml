
// https://github.com/ethereum/go-ethereum/blob/master/console/bridge_test.go#L28
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUndefinedAsParam280 = [1] of {int};
	run TestUndefinedAsParam28(child_TestUndefinedAsParam280)
stop_process:skip
}

proctype TestUndefinedAsParam28(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Sleep3162 = [1] of {int};
	chan child_Sign2781 = [1] of {int};
	chan child_UnlockAccount2310 = [1] of {int};
	Mutexdef call_VM_vm_interruptLock;
	Mutexdef call_VM_vm_prg_src_lineOffsetsLock;
	Mutexdef b_client_services_mu;
	run mutexMonitor(b_client_services_mu);
	run mutexMonitor(call_VM_vm_prg_src_lineOffsetsLock);
	run mutexMonitor(call_VM_vm_interruptLock);
	run UnlockAccount231(b_client_services_mu,call_VM_vm_prg_src_lineOffsetsLock,call_VM_vm_interruptLock,child_UnlockAccount2310);
	child_UnlockAccount2310?0;
	run Sign278(b_client_services_mu,call_VM_vm_prg_src_lineOffsetsLock,call_VM_vm_interruptLock,child_Sign2781);
	child_Sign2781?0;
	run Sleep316(b_client_services_mu,call_VM_vm_prg_src_lineOffsetsLock,call_VM_vm_interruptLock,child_Sleep3162);
	child_Sleep3162?0;
	stop_process: skip;
	child!0
}
proctype UnlockAccount231(Mutexdef b_client_services_mu;Mutexdef call_VM_vm_prg_src_lineOffsetsLock;Mutexdef call_VM_vm_interruptLock;chan child) {
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
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
proctype Sign278(Mutexdef b_client_services_mu;Mutexdef call_VM_vm_prg_src_lineOffsetsLock;Mutexdef call_VM_vm_interruptLock;chan child) {
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
proctype Sleep316(Mutexdef b_client_services_mu;Mutexdef call_VM_vm_prg_src_lineOffsetsLock;Mutexdef call_VM_vm_interruptLock;chan child) {
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

