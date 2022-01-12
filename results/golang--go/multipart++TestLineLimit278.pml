// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//mime/multipart/multipart_test.go#L278
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLineLimit2780 = [1] of {int};
	run TestLineLimit278(child_TestLineLimit2780);
	run receiver(child_TestLineLimit2780)
stop_process:skip
}

proctype TestLineLimit278(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewReader940 = [1] of {int};
	Mutexdef mr_t_context_mu;
	Mutexdef mr_t_context_match_mu;
	run mutexMonitor(mr_t_context_match_mu);
	run mutexMonitor(mr_t_context_mu);
	run NewReader94(mr_t_context_match_mu,mr_t_context_mu,child_NewReader940);
	child_NewReader940?0;
	stop_process: skip;
	child!0
}
proctype NewReader94(Mutexdef r_t_context_match_mu;Mutexdef r_t_context_mu;chan child) {
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

proctype receiver(chan c) {
c?0
}

