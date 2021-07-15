
// https://github.com/caddyserver/caddy/blob/master/modules/caddypki/command.go#L80
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_cmdTrust800 = [1] of {int};
	run cmdTrust80(child_cmdTrust800)
stop_process:skip
}

proctype cmdTrust80(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_installRoot3651 = [1] of {int};
	chan child_Provision820 = [1] of {int};
	Mutexdef ca_mu;
	run mutexMonitor(ca_mu);
	run Provision82(ca_mu,child_Provision820);
	child_Provision820?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run installRoot365(ca_mu,child_installRoot3651);
	child_installRoot3651?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Provision82(Mutexdef ca_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_loadOrGenIntermediate2782 = [1] of {int};
	chan child_loadOrGenRoot2171 = [1] of {int};
	chan child_storageKeyRootCert3430 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	ca_mu.Lock!false;
	ca_mu.Unlock!false;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		run storageKeyRootCert343(ca_mu,child_storageKeyRootCert3430);
		child_storageKeyRootCert3430?0;
		run loadOrGenRoot217(ca_mu,child_loadOrGenRoot2171);
		child_loadOrGenRoot2171?0
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run loadOrGenIntermediate278(ca_mu,child_loadOrGenIntermediate2782);
		child_loadOrGenIntermediate2782?0
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	ca_mu.Lock!false;
	ca_mu.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype storageKeyRootCert343(Mutexdef ca_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_storageKeyCAPrefix3400 = [1] of {int};
	run storageKeyCAPrefix340(ca_mu,child_storageKeyCAPrefix3400);
	child_storageKeyCAPrefix3400?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype storageKeyCAPrefix340(Mutexdef ca_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype loadOrGenRoot217(Mutexdef ca_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_storageKeyRootKey3463 = [1] of {int};
	chan child_genRoot2512 = [1] of {int};
	chan child_storageKeyRootCert3431 = [1] of {int};
	run storageKeyRootCert343(ca_mu,child_storageKeyRootCert3431);
	child_storageKeyRootCert3431?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run genRoot251(ca_mu,child_genRoot2512);
		child_genRoot2512?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
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
		run storageKeyRootKey346(ca_mu,child_storageKeyRootKey3463);
		child_storageKeyRootKey3463?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

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
proctype genRoot251(Mutexdef ca_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_storageKeyRootKey3464 = [1] of {int};
	chan child_storageKeyRootCert3433 = [1] of {int};
	chan child_newReplacer3562 = [1] of {int};
	run newReplacer356(ca_mu,child_newReplacer3562);
	child_newReplacer3562?0;
	

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
	run storageKeyRootCert343(ca_mu,child_storageKeyRootCert3433);
	child_storageKeyRootCert3433?0;
	

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
	run storageKeyRootKey346(ca_mu,child_storageKeyRootKey3464);
	child_storageKeyRootKey3464?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newReplacer356(Mutexdef ca_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype storageKeyRootKey346(Mutexdef ca_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_storageKeyCAPrefix3404 = [1] of {int};
	run storageKeyCAPrefix340(ca_mu,child_storageKeyCAPrefix3404);
	child_storageKeyCAPrefix3404?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype loadOrGenIntermediate278(Mutexdef ca_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_storageKeyIntermediateKey3524 = [1] of {int};
	chan child_genIntermediate3133 = [1] of {int};
	chan child_storageKeyIntermediateCert3492 = [1] of {int};
	run storageKeyIntermediateCert349(ca_mu,child_storageKeyIntermediateCert3492);
	child_storageKeyIntermediateCert3492?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run genIntermediate313(ca_mu,child_genIntermediate3133);
		child_genIntermediate3133?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
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
		run storageKeyIntermediateKey352(ca_mu,child_storageKeyIntermediateKey3524);
		child_storageKeyIntermediateKey3524?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

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
proctype storageKeyIntermediateCert349(Mutexdef ca_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_storageKeyCAPrefix3402 = [1] of {int};
	run storageKeyCAPrefix340(ca_mu,child_storageKeyCAPrefix3402);
	child_storageKeyCAPrefix3402?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype genIntermediate313(Mutexdef ca_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_storageKeyIntermediateKey3525 = [1] of {int};
	chan child_storageKeyIntermediateCert3494 = [1] of {int};
	chan child_newReplacer3563 = [1] of {int};
	run newReplacer356(ca_mu,child_newReplacer3563);
	child_newReplacer3563?0;
	

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
	run storageKeyIntermediateCert349(ca_mu,child_storageKeyIntermediateCert3494);
	child_storageKeyIntermediateCert3494?0;
	

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
	run storageKeyIntermediateKey352(ca_mu,child_storageKeyIntermediateKey3525);
	child_storageKeyIntermediateKey3525?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype storageKeyIntermediateKey352(Mutexdef ca_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_storageKeyCAPrefix3405 = [1] of {int};
	run storageKeyCAPrefix340(ca_mu,child_storageKeyCAPrefix3405);
	child_storageKeyCAPrefix3405?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype installRoot365(Mutexdef ca_mu;chan child) {
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

