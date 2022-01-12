// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//go/build/deps_test.go#L737
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_parseDepsRules7370 = [1] of {int};
	run parseDepsRules737(child_parseDepsRules7370);
	run receiver(child_parseDepsRules7370)
stop_process:skip
}

proctype parseDepsRules737(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_syntaxError7752 = [1] of {int};
	chan child_syntaxError7751 = [1] of {int};
	chan child_nextList7800 = [1] of {int};
	Mutexdef p_t_context_mu;
	Mutexdef p_t_context_match_mu;
	run mutexMonitor(p_t_context_match_mu);
	run mutexMonitor(p_t_context_mu);
	do
	:: true -> 
		for10: skip;
		run nextList780(p_t_context_match_mu,p_t_context_mu,child_nextList7800);
		child_nextList7800?0;
		

		if
		:: true -> 
			

			if
			:: true -> 
				break
			:: true;
			fi;
			run syntaxError775(p_t_context_match_mu,p_t_context_mu,child_syntaxError7751);
			child_syntaxError7751?0
		:: true;
		fi;
		

		if
		:: true -> 
			goto for14_end
		:: true;
		fi;
		

		if
		:: true -> 
			run syntaxError775(p_t_context_match_mu,p_t_context_mu,child_syntaxError7752);
			child_syntaxError7752?0
		:: true;
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype nextList780(Mutexdef p_t_context_match_mu;Mutexdef p_t_context_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_nextToken8032 = [1] of {int};
	chan child_syntaxError7751 = [1] of {int};
	chan child_nextToken8030 = [1] of {int};
	do
	:: true -> 
		for11: skip;
		run nextToken803(p_t_context_match_mu,p_t_context_mu,child_nextToken8030);
		child_nextToken8030?0;
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			run syntaxError775(p_t_context_match_mu,p_t_context_mu,child_syntaxError7751);
			child_syntaxError7751?0
		fi;
		run nextToken803(p_t_context_match_mu,p_t_context_mu,child_nextToken8032);
		child_nextToken8032?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		for11_end: skip
	od;
	for11_exit: skip;
	stop_process: skip;
	child!0
}
proctype nextToken803(Mutexdef p_t_context_match_mu;Mutexdef p_t_context_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_syntaxError7750 = [1] of {int};
	do
	:: true -> 
		for12: skip;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			

			if
			:: true -> 
				run syntaxError775(p_t_context_match_mu,p_t_context_mu,child_syntaxError7750);
				child_syntaxError7750?0
			:: true;
			fi;
			goto stop_process
		:: true -> 
			goto for12_end
		:: true;
		:: true -> 
			goto for12_end
		:: true -> 
			goto stop_process
		fi;
		for12_end: skip
	od;
	for12_exit: skip;
	stop_process: skip;
	child!0
}
proctype syntaxError775(Mutexdef p_t_context_match_mu;Mutexdef p_t_context_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

