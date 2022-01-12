// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/cmd/vtctldclient/command/validate.go#L63
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_commandValidate630 = [1] of {int};
	run commandValidate63(child_commandValidate630);
	run receiver(child_commandValidate630)
stop_process:skip
}

proctype commandValidate63(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_consumeValidationResults1400 = [1] of {int};
	Mutexdef resp_state_atomicMessageInfo_initMu;
	run mutexMonitor(resp_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run consumeValidationResults140(resp_state_atomicMessageInfo_initMu,child_consumeValidationResults1400);
	child_consumeValidationResults1400?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype consumeValidationResults140(Mutexdef resp_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_resp_ResultsByKeyspace = -2; // opt var_resp_ResultsByKeyspace
	int var_resp_Results = -2; // opt var_resp_Results
	

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

