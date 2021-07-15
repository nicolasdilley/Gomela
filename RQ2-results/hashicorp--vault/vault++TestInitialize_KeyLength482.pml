
// https://github.com/hashicorp/vault/blob/master/vault/barrier_aes_gcm_test.go#L482
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInitialize_KeyLength4820 = [1] of {int};
	run TestInitialize_KeyLength482(child_TestInitialize_KeyLength4820)
stop_process:skip
}

proctype TestInitialize_KeyLength482(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Initialize1532 = [1] of {int};
	chan child_Initialize1531 = [1] of {int};
	chan child_Initialize1530 = [1] of {int};
	Mutexdef b_cacheLock;
	Mutexdef b_l;
	run mutexMonitor(b_l);
	run mutexMonitor(b_cacheLock);
	run Initialize153(b_l,b_cacheLock,child_Initialize1530);
	child_Initialize1530?0;
	run Initialize153(b_l,b_cacheLock,child_Initialize1531);
	child_Initialize1531?0;
	run Initialize153(b_l,b_cacheLock,child_Initialize1532);
	child_Initialize1532?0;
	stop_process: skip;
	child!0
}
proctype Initialize153(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_putInternal7985 = [1] of {int};
	chan child_aeadFromKey9444 = [1] of {int};
	chan child_persistKeyring2103 = [1] of {int};
	chan child_GenerateKey2742 = [1] of {int};
	chan child_Initialized1271 = [1] of {int};
	chan child_KeyLength2830 = [1] of {int};
	run KeyLength283(b_l,b_cacheLock,child_KeyLength2830);
	child_KeyLength2830?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Initialized127(b_l,b_cacheLock,child_Initialized1271);
	child_Initialized1271?0;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	run GenerateKey274(b_l,b_cacheLock,child_GenerateKey2742);
	child_GenerateKey2742?0;
	

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
	run persistKeyring210(b_l,b_cacheLock,child_persistKeyring2103);
	child_persistKeyring2103?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run aeadFromKey944(b_l,b_cacheLock,child_aeadFromKey9444);
		child_aeadFromKey9444?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run putInternal798(b_l,b_cacheLock,child_putInternal7985);
		child_putInternal7985?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype KeyLength283(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Initialized127(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
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
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GenerateKey274(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype persistKeyring210(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_encryptTracked11236 = [1] of {int};
	chan child_aeadFromKey9445 = [1] of {int};
	chan child_encrypt9604 = [1] of {int};
	chan child_aeadFromKey9443 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run aeadFromKey944(b_l,b_cacheLock,child_aeadFromKey9443);
	child_aeadFromKey9443?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run encrypt960(b_l,b_cacheLock,child_encrypt9604);
	child_encrypt9604?0;
	

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
	run aeadFromKey944(b_l,b_cacheLock,child_aeadFromKey9445);
	child_aeadFromKey9445?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run encryptTracked1123(b_l,b_cacheLock,child_encryptTracked11236);
	child_encryptTracked11236?0;
	

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
proctype aeadFromKey944(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
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
proctype encrypt960(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
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
	:: true;
	:: true;
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype encryptTracked1123(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_encrypt9606 = [1] of {int};
	run encrypt960(b_l,b_cacheLock,child_encrypt9606);
	child_encrypt9606?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype putInternal798(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_encryptTracked11235 = [1] of {int};
	run encryptTracked1123(b_l,b_cacheLock,child_encryptTracked11235);
	child_encryptTracked11235?0;
	

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

