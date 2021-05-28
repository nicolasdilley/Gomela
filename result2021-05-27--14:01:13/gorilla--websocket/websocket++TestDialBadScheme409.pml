// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gorilla/websocket/blob/e8629af678b7fe13f35dff5e197de93b4148a909/client_server_test.go#L409
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDialBadScheme4090 = [1] of {int};
	run TestDialBadScheme409(child_TestDialBadScheme4090);
	run receiver(child_TestDialBadScheme4090)
stop_process:skip
}

proctype TestDialBadScheme409(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close3430 = [1] of {int};
	Mutexdef ws_writeErrMu;
	run mutexMonitor(ws_writeErrMu);
	

	if
	:: true -> 
		run Close343(ws_writeErrMu,child_Close3430);
		child_Close3430?0
	:: true;
	fi;
		stop_process: skip;
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

proctype receiver(chan c) {
c?0
}

