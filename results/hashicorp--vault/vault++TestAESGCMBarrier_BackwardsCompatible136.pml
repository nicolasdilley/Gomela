
// https://github.com/hashicorp/vault/blob/master/vault/barrier_aes_gcm_test.go#L136
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAESGCMBarrier_BackwardsCompatible1360 = [1] of {int};
	run TestAESGCMBarrier_BackwardsCompatible136(child_TestAESGCMBarrier_BackwardsCompatible1360)
stop_process:skip
}

proctype TestAESGCMBarrier_BackwardsCompatible136(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get8128 = [1] of {int};
	chan child_Unseal4227 = [1] of {int};
	chan child_Initialized1276 = [1] of {int};
	chan child_encrypt9605 = [1] of {int};
	chan child_aeadFromKey9444 = [1] of {int};
	chan child_encrypt9603 = [1] of {int};
	chan child_aeadFromKey9442 = [1] of {int};
	chan child_GenerateKey2741 = [1] of {int};
	chan child_GenerateKey2740 = [1] of {int};
	Mutexdef b_cacheLock;
	Mutexdef b_l;
	run mutexMonitor(b_l);
	run mutexMonitor(b_cacheLock);
	run GenerateKey274(b_l,b_cacheLock,child_GenerateKey2740);
	child_GenerateKey2740?0;
	run GenerateKey274(b_l,b_cacheLock,child_GenerateKey2741);
	child_GenerateKey2741?0;
	run aeadFromKey944(b_l,b_cacheLock,child_aeadFromKey9442);
	child_aeadFromKey9442?0;
	run encrypt960(b_l,b_cacheLock,child_encrypt9603);
	child_encrypt9603?0;
	run aeadFromKey944(b_l,b_cacheLock,child_aeadFromKey9444);
	child_aeadFromKey9444?0;
	run encrypt960(b_l,b_cacheLock,child_encrypt9605);
	child_encrypt9605?0;
	run Initialized127(b_l,b_cacheLock,child_Initialized1276);
	child_Initialized1276?0;
	run Unseal422(b_l,b_cacheLock,child_Unseal4227);
	child_Unseal4227?0;
	run Get812(b_l,b_cacheLock,child_Get8128);
	child_Get8128?0;
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
proctype Unseal422(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_persistKeyring21011 = [1] of {int};
	chan child_decrypt101310 = [1] of {int};
	chan child_recoverKeyring3599 = [1] of {int};
	chan child_decrypt10138 = [1] of {int};
	chan child_aeadFromKey9447 = [1] of {int};
	b_l.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run aeadFromKey944(b_l,b_cacheLock,child_aeadFromKey9447);
	child_aeadFromKey9447?0;
	

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
		fi;
		run decrypt1013(b_l,b_cacheLock,child_decrypt10138);
		child_decrypt10138?0;
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto stop_process
		:: true;
		fi;
		run recoverKeyring359(b_l,b_cacheLock,child_recoverKeyring3599);
		child_recoverKeyring3599?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
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
	run decrypt1013(b_l,b_cacheLock,child_decrypt101310);
	child_decrypt101310?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
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
	run persistKeyring210(b_l,b_cacheLock,child_persistKeyring21011);
	child_persistKeyring21011?0;
	

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
		b_l.Unlock!false;
	child!0
}
proctype decrypt1013(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	stop_process: skip;
	child!0
}
proctype recoverKeyring359(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
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
proctype persistKeyring210(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_encryptTracked112314 = [1] of {int};
	chan child_aeadFromKey94413 = [1] of {int};
	chan child_encrypt96012 = [1] of {int};
	chan child_aeadFromKey94411 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run aeadFromKey944(b_l,b_cacheLock,child_aeadFromKey94411);
	child_aeadFromKey94411?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run encrypt960(b_l,b_cacheLock,child_encrypt96012);
	child_encrypt96012?0;
	

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
	run aeadFromKey944(b_l,b_cacheLock,child_aeadFromKey94413);
	child_aeadFromKey94413?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run encryptTracked1123(b_l,b_cacheLock,child_encryptTracked112314);
	child_encryptTracked112314?0;
	

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
proctype encryptTracked1123(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_encrypt96014 = [1] of {int};
	run encrypt960(b_l,b_cacheLock,child_encrypt96014);
	child_encrypt96014?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Get812(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_lockSwitchedGet8168 = [1] of {int};
	run lockSwitchedGet816(b_l,b_cacheLock,child_lockSwitchedGet8168);
	child_lockSwitchedGet8168?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype lockSwitchedGet816(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_decrypt10139 = [1] of {int};
	chan child_aeadForTerm9098 = [1] of {int};
	

	if
	:: true -> 
		b_l.RLock!false
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			b_l.RUnlock!false
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			b_l.RUnlock!false
		:: true;
		fi;
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				b_l.RUnlock!false
			:: true;
			fi;
			goto stop_process
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			b_l.RUnlock!false
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	run aeadForTerm909(b_l,b_cacheLock,child_aeadForTerm9098);
	child_aeadForTerm9098?0;
	

	if
	:: true -> 
		b_l.RUnlock!false
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
	run decrypt1013(b_l,b_cacheLock,child_decrypt10139);
	child_decrypt10139?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype aeadForTerm909(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_aeadFromKey9448 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	b_cacheLock.RLock!false;
	b_cacheLock.RUnlock!false;
	

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
	run aeadFromKey944(b_l,b_cacheLock,child_aeadFromKey9448);
	child_aeadFromKey9448?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	b_cacheLock.Lock!false;
	b_cacheLock.Unlock!false;
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

