
// https://github.com/dgraph-io/dgraph/blob/master/graphql/resolve/auth_test.go#L739
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_checkAddUpdateCase7390 = [1] of {int};
	run checkAddUpdateCase739(child_checkAddUpdateCase7390)
stop_process:skip
}

proctype checkAddUpdateCase739(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewDgraphResolver1660 = [1] of {int};
	Mutexdef ex_t_context_mu;
	Mutexdef ex_t_context_match_mu;
	run mutexMonitor(ex_t_context_match_mu);
	run mutexMonitor(ex_t_context_mu);
	run NewDgraphResolver166(ex_t_context_match_mu,ex_t_context_mu,child_NewDgraphResolver1660);
	child_NewDgraphResolver1660?0;
	stop_process: skip;
	child!0
}
proctype NewDgraphResolver166(Mutexdef ex_t_context_match_mu;Mutexdef ex_t_context_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

