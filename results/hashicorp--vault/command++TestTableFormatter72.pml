// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob//command/format_test.go#L72
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTableFormatter720 = [1] of {int};
	run TestTableFormatter72(child_TestTableFormatter720);
	run receiver(child_TestTableFormatter720)
stop_process:skip
}

proctype TestTableFormatter72(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_outputWithFormat470 = [1] of {int};
	Mutexdef ui_t_context_mu;
	Mutexdef ui_t_context_match_mu;
	run mutexMonitor(ui_t_context_match_mu);
	run mutexMonitor(ui_t_context_mu);
	run outputWithFormat47(ui_t_context_match_mu,ui_t_context_mu,child_outputWithFormat470);
	child_outputWithFormat470?0;
	stop_process: skip;
	child!0
}
proctype outputWithFormat47(Mutexdef ui_t_context_match_mu;Mutexdef ui_t_context_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Format750 = [1] of {int};
	run Format75(ui_t_context_match_mu,ui_t_context_mu,child_Format750);
	child_Format750?0;
	

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
proctype Format75(Mutexdef ui_t_context_match_mu;Mutexdef ui_t_context_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
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

