// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pkg/webhooks/validation/controller/controller_test.go#L204
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGreenfield2040 = [1] of {int};
	run TestGreenfield204(child_TestGreenfield2040);
	run receiver(child_TestGreenfield2040)
stop_process:skip
}

proctype TestGreenfield204(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_reconcileHelper1953 = [1] of {int};
	chan child_reconcileHelper1952 = [1] of {int};
	chan child_reconcileHelper1951 = [1] of {int};
	chan child_reconcileHelper1950 = [1] of {int};
	Mutexdef c_injectedMu;
	run mutexMonitor(c_injectedMu);
	run reconcileHelper195(c_injectedMu,child_reconcileHelper1950);
	child_reconcileHelper1950?0;
	run reconcileHelper195(c_injectedMu,child_reconcileHelper1951);
	child_reconcileHelper1951?0;
	run reconcileHelper195(c_injectedMu,child_reconcileHelper1952);
	child_reconcileHelper1952?0;
	run reconcileHelper195(c_injectedMu,child_reconcileHelper1953);
	child_reconcileHelper1953?0;
	stop_process: skip;
	child!0
}
proctype reconcileHelper195(Mutexdef c_injectedMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_reconcileRequest2800 = [1] of {int};
	run reconcileRequest280(c_injectedMu,child_reconcileRequest2800);
	child_reconcileRequest2800?0;
	stop_process: skip;
	child!0
}
proctype reconcileRequest280(Mutexdef c_injectedMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_updateValidatingWebhookConfiguration3572 = [1] of {int};
	chan child_loadCABundle4321 = [1] of {int};
	chan child_readyForFailClose3070 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run readyForFailClose307(c_injectedMu,child_readyForFailClose3070);
	child_readyForFailClose3070?0;
	run loadCABundle432(c_injectedMu,child_loadCABundle4321);
	child_loadCABundle4321?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run updateValidatingWebhookConfiguration357(c_injectedMu,child_updateValidatingWebhookConfiguration3572);
	child_updateValidatingWebhookConfiguration3572?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype readyForFailClose307(Mutexdef c_injectedMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_isDryRunOfInvalidConfigRejected3250 = [1] of {int};
	

	if
	:: true -> 
		run isDryRunOfInvalidConfigRejected325(c_injectedMu,child_isDryRunOfInvalidConfigRejected3250);
		child_isDryRunOfInvalidConfigRejected3250?0;
		

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
proctype isDryRunOfInvalidConfigRejected325(Mutexdef c_injectedMu;chan child) {
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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype loadCABundle432(Mutexdef c_injectedMu;chan child) {
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
proctype updateValidatingWebhookConfiguration357(Mutexdef c_injectedMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_updated_Webhooksupdated_Webhooks = -2; // opt var_updated_Webhooksupdated_Webhooks
	

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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
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
