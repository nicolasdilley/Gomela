
// https://github.com/hashicorp/vault/blob/master/vault/barrier_aes_gcm_test.go#L38
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAESGCMBarrier_Basic380 = [1] of {int};
	run TestAESGCMBarrier_Basic38(child_TestAESGCMBarrier_Basic380)
stop_process:skip
}

proctype TestAESGCMBarrier_Basic38(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_testBarrier130 = [1] of {int};
	Mutexdef b_cacheLock;
	Mutexdef b_l;
	run mutexMonitor(b_l);
	run mutexMonitor(b_cacheLock);
	run testBarrier13(b_l,b_cacheLock,child_testBarrier130);
	child_testBarrier130?0;
	stop_process: skip;
	child!0
}
proctype testBarrier13(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Unseal42217 = [1] of {int};
	chan child_Seal53416 = [1] of {int};
	chan child_Delete88215 = [1] of {int};
	chan child_Get81214 = [1] of {int};
	chan child_Unseal42213 = [1] of {int};
	chan child_Get81212 = [1] of {int};
	chan child_Seal53411 = [1] of {int};
	chan child_Put78010 = [1] of {int};
	chan child_List8969 = [1] of {int};
	chan child_Get8128 = [1] of {int};
	chan child_Delete8827 = [1] of {int};
	chan child_Delete8826 = [1] of {int};
	chan child_List8965 = [1] of {int};
	chan child_Get8124 = [1] of {int};
	chan child_Put7803 = [1] of {int};
	chan child_List8962 = [1] of {int};
	chan child_Get8121 = [1] of {int};
	chan child_testInitAndUnseal1390 = [1] of {int};
	run testInitAndUnseal139(b_l,b_cacheLock,child_testInitAndUnseal1390);
	child_testInitAndUnseal1390?0;
	run Get812(b_l,b_cacheLock,child_Get8121);
	child_Get8121?0;
	run List896(b_l,b_cacheLock,child_List8962);
	child_List8962?0;
	run Put780(b_l,b_cacheLock,child_Put7803);
	child_Put7803?0;
	run Get812(b_l,b_cacheLock,child_Get8124);
	child_Get8124?0;
	run List896(b_l,b_cacheLock,child_List8965);
	child_List8965?0;
	run Delete882(b_l,b_cacheLock,child_Delete8826);
	child_Delete8826?0;
	run Delete882(b_l,b_cacheLock,child_Delete8827);
	child_Delete8827?0;
	run Get812(b_l,b_cacheLock,child_Get8128);
	child_Get8128?0;
	run List896(b_l,b_cacheLock,child_List8969);
	child_List8969?0;
	run Put780(b_l,b_cacheLock,child_Put78010);
	child_Put78010?0;
	run Seal534(b_l,b_cacheLock,child_Seal53411);
	child_Seal53411?0;
	run Get812(b_l,b_cacheLock,child_Get81212);
	child_Get81212?0;
	run Unseal422(b_l,b_cacheLock,child_Unseal42213);
	child_Unseal42213?0;
	run Get812(b_l,b_cacheLock,child_Get81214);
	child_Get81214?0;
	run Delete882(b_l,b_cacheLock,child_Delete88215);
	child_Delete88215?0;
	run Seal534(b_l,b_cacheLock,child_Seal53416);
	child_Seal53416?0;
	run Unseal422(b_l,b_cacheLock,child_Unseal42217);
	child_Unseal42217?0;
	stop_process: skip;
	child!0
}
proctype testInitAndUnseal139(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_VerifyMaster29717 = [1] of {int};
	chan child_Sealed28916 = [1] of {int};
	chan child_Unseal42215 = [1] of {int};
	chan child_Unseal42214 = [1] of {int};
	chan child_Sealed28913 = [1] of {int};
	chan child_Initialized12712 = [1] of {int};
	chan child_Initialize15311 = [1] of {int};
	chan child_Initialize15310 = [1] of {int};
	chan child_Unseal4229 = [1] of {int};
	chan child_KeyLength2838 = [1] of {int};
	chan child_GenerateKey2747 = [1] of {int};
	chan child_List8966 = [1] of {int};
	chan child_Delete8825 = [1] of {int};
	chan child_Get8124 = [1] of {int};
	chan child_Put7803 = [1] of {int};
	chan child_Seal5342 = [1] of {int};
	chan child_Sealed2891 = [1] of {int};
	chan child_Initialized1270 = [1] of {int};
	run Initialized127(b_l,b_cacheLock,child_Initialized1270);
	child_Initialized1270?0;
	run Sealed289(b_l,b_cacheLock,child_Sealed2891);
	child_Sealed2891?0;
	run Seal534(b_l,b_cacheLock,child_Seal5342);
	child_Seal5342?0;
	run Put780(b_l,b_cacheLock,child_Put7803);
	child_Put7803?0;
	run Get812(b_l,b_cacheLock,child_Get8124);
	child_Get8124?0;
	run Delete882(b_l,b_cacheLock,child_Delete8825);
	child_Delete8825?0;
	run List896(b_l,b_cacheLock,child_List8966);
	child_List8966?0;
	run GenerateKey274(b_l,b_cacheLock,child_GenerateKey2747);
	child_GenerateKey2747?0;
	run KeyLength283(b_l,b_cacheLock,child_KeyLength2838);
	child_KeyLength2838?0;
	run Unseal422(b_l,b_cacheLock,child_Unseal4229);
	child_Unseal4229?0;
	run Initialize153(b_l,b_cacheLock,child_Initialize15310);
	child_Initialize15310?0;
	run Initialize153(b_l,b_cacheLock,child_Initialize15311);
	child_Initialize15311?0;
	run Initialized127(b_l,b_cacheLock,child_Initialized12712);
	child_Initialized12712?0;
	run Sealed289(b_l,b_cacheLock,child_Sealed28913);
	child_Sealed28913?0;
	run Unseal422(b_l,b_cacheLock,child_Unseal42214);
	child_Unseal42214?0;
	run Unseal422(b_l,b_cacheLock,child_Unseal42215);
	child_Unseal42215?0;
	run Sealed289(b_l,b_cacheLock,child_Sealed28916);
	child_Sealed28916?0;
	run VerifyMaster297(b_l,b_cacheLock,child_VerifyMaster29717);
	child_VerifyMaster29717?0;
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
proctype Sealed289(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	b_l.RLock!false;
	b_l.RUnlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Seal534(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	b_l.Lock!false;
	goto stop_process;
	stop_process: skip;
		b_l.Unlock!false;
	child!0
}
proctype Put780(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_putInternal7984 = [1] of {int};
	chan child_aeadForTerm9093 = [1] of {int};
	b_l.RLock!false;
	

	if
	:: true -> 
		b_l.RUnlock!false;
		goto stop_process
	:: true;
	fi;
	run aeadForTerm909(b_l,b_cacheLock,child_aeadForTerm9093);
	child_aeadForTerm9093?0;
	b_l.RUnlock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run putInternal798(b_l,b_cacheLock,child_putInternal7984);
	child_putInternal7984?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype aeadForTerm909(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_aeadFromKey9443 = [1] of {int};
	

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
	run aeadFromKey944(b_l,b_cacheLock,child_aeadFromKey9443);
	child_aeadFromKey9443?0;
	

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
proctype putInternal798(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_encryptTracked11234 = [1] of {int};
	run encryptTracked1123(b_l,b_cacheLock,child_encryptTracked11234);
	child_encryptTracked11234?0;
	

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
	chan child_encrypt9604 = [1] of {int};
	run encrypt960(b_l,b_cacheLock,child_encrypt9604);
	child_encrypt9604?0;
	

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
proctype Get812(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_lockSwitchedGet8164 = [1] of {int};
	run lockSwitchedGet816(b_l,b_cacheLock,child_lockSwitchedGet8164);
	child_lockSwitchedGet8164?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype lockSwitchedGet816(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_decrypt10135 = [1] of {int};
	chan child_aeadForTerm9094 = [1] of {int};
	

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
	run aeadForTerm909(b_l,b_cacheLock,child_aeadForTerm9094);
	child_aeadForTerm9094?0;
	

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
	run decrypt1013(b_l,b_cacheLock,child_decrypt10135);
	child_decrypt10135?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
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
proctype Delete882(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	b_l.RLock!false;
	b_l.RUnlock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype List896(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	b_l.RLock!false;
	b_l.RUnlock!false;
	

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
proctype KeyLength283(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Unseal422(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_persistKeyring21013 = [1] of {int};
	chan child_decrypt101312 = [1] of {int};
	chan child_recoverKeyring35911 = [1] of {int};
	chan child_decrypt101310 = [1] of {int};
	chan child_aeadFromKey9449 = [1] of {int};
	b_l.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run aeadFromKey944(b_l,b_cacheLock,child_aeadFromKey9449);
	child_aeadFromKey9449?0;
	

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
		run recoverKeyring359(b_l,b_cacheLock,child_recoverKeyring35911);
		child_recoverKeyring35911?0;
		

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
	run decrypt1013(b_l,b_cacheLock,child_decrypt101312);
	child_decrypt101312?0;
	

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
	run persistKeyring210(b_l,b_cacheLock,child_persistKeyring21013);
	child_persistKeyring21013?0;
	

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
	chan child_encryptTracked112316 = [1] of {int};
	chan child_aeadFromKey94415 = [1] of {int};
	chan child_encrypt96014 = [1] of {int};
	chan child_aeadFromKey94413 = [1] of {int};
	

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
	run encrypt960(b_l,b_cacheLock,child_encrypt96014);
	child_encrypt96014?0;
	

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
	run aeadFromKey944(b_l,b_cacheLock,child_aeadFromKey94415);
	child_aeadFromKey94415?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run encryptTracked1123(b_l,b_cacheLock,child_encryptTracked112316);
	child_encryptTracked112316?0;
	

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
proctype Initialize153(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_putInternal79815 = [1] of {int};
	chan child_aeadFromKey94414 = [1] of {int};
	chan child_persistKeyring21013 = [1] of {int};
	chan child_GenerateKey27412 = [1] of {int};
	chan child_Initialized12711 = [1] of {int};
	chan child_KeyLength28310 = [1] of {int};
	run KeyLength283(b_l,b_cacheLock,child_KeyLength28310);
	child_KeyLength28310?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Initialized127(b_l,b_cacheLock,child_Initialized12711);
	child_Initialized12711?0;
	

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
	run GenerateKey274(b_l,b_cacheLock,child_GenerateKey27412);
	child_GenerateKey27412?0;
	

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
	run persistKeyring210(b_l,b_cacheLock,child_persistKeyring21013);
	child_persistKeyring21013?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run aeadFromKey944(b_l,b_cacheLock,child_aeadFromKey94414);
		child_aeadFromKey94414?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run putInternal798(b_l,b_cacheLock,child_putInternal79815);
		child_putInternal79815?0;
		

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
proctype VerifyMaster297(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	b_l.RLock!false;
	

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
		b_l.RUnlock!false;
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

