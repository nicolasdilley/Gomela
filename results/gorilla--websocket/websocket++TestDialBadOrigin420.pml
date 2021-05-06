
// https://github.com/gorilla/websocket/blob/master/client_server_test.go#L420
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDialBadOrigin4200 = [1] of {int};
	run TestDialBadOrigin420(child_TestDialBadOrigin4200)
stop_process:skip
}

proctype TestDialBadOrigin420(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close1050 = [1] of {int};
	chan child_Close3431 = [1] of {int};
	Mutexdef ws_writeErrMu;
	Mutexdef s_t_context_mu;
	Mutexdef s_t_context_match_mu;
	run mutexMonitor(s_t_context_match_mu);
	run mutexMonitor(s_t_context_mu);
	run mutexMonitor(ws_writeErrMu);
	

	if
	:: true -> 
		run Close343(ws_writeErrMu,child_Close3431);
		child_Close3431?0
	:: true;
	fi;
	stop_process: skip;
		run Close105(s_t_context_match_mu,s_t_context_mu,child_Close1050);
	child_Close1050?0;
	child!0
}
proctype Close105(Mutexdef w_t_context_match_mu;Mutexdef w_t_context_mu;chan child) {
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
proctype Close343(Mutexdef c_writeErrMu;chan child) {
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

