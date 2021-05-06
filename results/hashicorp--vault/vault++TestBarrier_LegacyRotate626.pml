
// https://github.com/hashicorp/vault/blob/master/vault/barrier_aes_gcm_test.go#L626
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBarrier_LegacyRotate6260 = [1] of {int};
	run TestBarrier_LegacyRotate626(child_TestBarrier_LegacyRotate6260)
stop_process:skip
}

proctype TestBarrier_LegacyRotate626(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CheckBarrierAutoRotate11416 = [1] of {int};
	chan child_Unseal4225 = [1] of {int};
	chan child_Seal5344 = [1] of {int};
	chan child_persistKeyring2103 = [1] of {int};
	chan child_Unseal4222 = [1] of {int};
	chan child_Initialize1531 = [1] of {int};
	chan child_GenerateKey2740 = [1] of {int};
	Mutexdef b1_cacheLock;
	Mutexdef b1_l;
	run mutexMonitor(b1_l);
	run mutexMonitor(b1_cacheLock);
	run GenerateKey274(b1_l,b1_cacheLock,child_GenerateKey2740);
	child_GenerateKey2740?0;
	run Initialize153(b1_l,b1_cacheLock,child_Initialize1531);
	child_Initialize1531?0;
	run Unseal422(b1_l,b1_cacheLock,child_Unseal4222);
	child_Unseal4222?0;
	run persistKeyring210(b1_l,b1_cacheLock,child_persistKeyring2103);
	child_persistKeyring2103?0;
	run Seal534(b1_l,b1_cacheLock,child_Seal5344);
	child_Seal5344?0;
	run Unseal422(b1_l,b1_cacheLock,child_Unseal4225);
	child_Unseal4225?0;
	run CheckBarrierAutoRotate1141(b1_l,b1_cacheLock,child_CheckBarrierAutoRotate11416);
	child_CheckBarrierAutoRotate11416?0;
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
proctype Initialize153(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_putInternal7986 = [1] of {int};
	chan child_aeadFromKey9445 = [1] of {int};
	chan child_persistKeyring2104 = [1] of {int};
	chan child_GenerateKey2743 = [1] of {int};
	chan child_Initialized1272 = [1] of {int};
	chan child_KeyLength2831 = [1] of {int};
	run KeyLength283(b_l,b_cacheLock,child_KeyLength2831);
	child_KeyLength2831?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Initialized127(b_l,b_cacheLock,child_Initialized1272);
	child_Initialized1272?0;
	

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
	run GenerateKey274(b_l,b_cacheLock,child_GenerateKey2743);
	child_GenerateKey2743?0;
	

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
	run persistKeyring210(b_l,b_cacheLock,child_persistKeyring2104);
	child_persistKeyring2104?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run aeadFromKey944(b_l,b_cacheLock,child_aeadFromKey9445);
		child_aeadFromKey9445?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run putInternal798(b_l,b_cacheLock,child_putInternal7986);
		child_putInternal7986?0;
		

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
proctype persistKeyring210(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_encryptTracked11237 = [1] of {int};
	chan child_aeadFromKey9446 = [1] of {int};
	chan child_encrypt9605 = [1] of {int};
	chan child_aeadFromKey9444 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run aeadFromKey944(b_l,b_cacheLock,child_aeadFromKey9444);
	child_aeadFromKey9444?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run encrypt960(b_l,b_cacheLock,child_encrypt9605);
	child_encrypt9605?0;
	

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
	run aeadFromKey944(b_l,b_cacheLock,child_aeadFromKey9446);
	child_aeadFromKey9446?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run encryptTracked1123(b_l,b_cacheLock,child_encryptTracked11237);
	child_encryptTracked11237?0;
	

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
	chan child_encrypt9607 = [1] of {int};
	run encrypt960(b_l,b_cacheLock,child_encrypt9607);
	child_encrypt9607?0;
	

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
	chan child_encryptTracked11236 = [1] of {int};
	run encryptTracked1123(b_l,b_cacheLock,child_encryptTracked11236);
	child_encryptTracked11236?0;
	

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
	chan child_persistKeyring2106 = [1] of {int};
	chan child_decrypt10135 = [1] of {int};
	chan child_recoverKeyring3594 = [1] of {int};
	chan child_decrypt10133 = [1] of {int};
	chan child_aeadFromKey9442 = [1] of {int};
	b_l.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run aeadFromKey944(b_l,b_cacheLock,child_aeadFromKey9442);
	child_aeadFromKey9442?0;
	

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
		run decrypt1013(b_l,b_cacheLock,child_decrypt10133);
		child_decrypt10133?0;
		

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
		run recoverKeyring359(b_l,b_cacheLock,child_recoverKeyring3594);
		child_recoverKeyring3594?0;
		

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
	run decrypt1013(b_l,b_cacheLock,child_decrypt10135);
	child_decrypt10135?0;
	

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
	run persistKeyring210(b_l,b_cacheLock,child_persistKeyring2106);
	child_persistKeyring2106?0;
	

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
proctype CheckBarrierAutoRotate1141(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_persistEncryptions11908 = [1] of {int};
	chan child_encryptions12147 = [1] of {int};
	chan child_RotationConfig916 = [1] of {int};
	b_l.RLock!false;
	

	if
	:: true -> 
		run RotationConfig91(b_l,b_cacheLock,child_RotationConfig916);
		child_RotationConfig916?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			run encryptions1214(b_l,b_cacheLock,child_encryptions12147);
			child_encryptions12147?0;
			

			if
			:: true;
			:: true;
			:: true;
			fi
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
		b_l.RUnlock!false;
	

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
	b_l.Lock!false;
	

	if
	:: true -> 
		run persistEncryptions1190(b_l,b_cacheLock,child_persistEncryptions11908);
		child_persistEncryptions11908?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		b_l.Unlock!false;
	child!0
}
proctype RotationConfig91(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
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
proctype encryptions1214(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

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
proctype persistEncryptions1190(Mutexdef b_l;Mutexdef b_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_persistKeyring2108 = [1] of {int};
	

	if
	:: true -> 
		

		if
		:: true -> 
			run persistKeyring210(b_l,b_cacheLock,child_persistKeyring2108);
			child_persistKeyring2108?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
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

