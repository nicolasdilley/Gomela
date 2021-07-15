
// https://github.com/istio/istio/blob/master/pkg/webhooks/validation/controller/controller_test.go#L204
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGreenfield2040 = [1] of {int};
	run TestGreenfield204(child_TestGreenfield2040)
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
	chan child_reconcileRequest2710 = [1] of {int};
	run reconcileRequest271(c_injectedMu,child_reconcileRequest2710);
	child_reconcileRequest2710?0;
	stop_process: skip;
	child!0
}
proctype reconcileRequest271(Mutexdef c_injectedMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_updateValidatingWebhookConfiguration3502 = [1] of {int};
	chan child_loadCABundle4251 = [1] of {int};
	chan child_readyForFailClose2980 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run readyForFailClose298(c_injectedMu,child_readyForFailClose2980);
	child_readyForFailClose2980?0;
	run loadCABundle425(c_injectedMu,child_loadCABundle4251);
	child_loadCABundle4251?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run updateValidatingWebhookConfiguration350(c_injectedMu,child_updateValidatingWebhookConfiguration3502);
	child_updateValidatingWebhookConfiguration3502?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype readyForFailClose298(Mutexdef c_injectedMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_isDryRunOfInvalidConfigRejected3180 = [1] of {int};
	

	if
	:: true -> 
		run isDryRunOfInvalidConfigRejected318(c_injectedMu,child_isDryRunOfInvalidConfigRejected3180);
		child_isDryRunOfInvalidConfigRejected3180?0;
		

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
proctype isDryRunOfInvalidConfigRejected318(Mutexdef c_injectedMu;chan child) {
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
proctype loadCABundle425(Mutexdef c_injectedMu;chan child) {
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
proctype updateValidatingWebhookConfiguration350(Mutexdef c_injectedMu;chan child) {
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

