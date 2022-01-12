// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/outputs/websocket/websocket_test.go#L114
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestWebSocket_NoURL1140 = [1] of {int};
	run TestWebSocket_NoURL114(child_TestWebSocket_NoURL1140);
	run receiver(child_TestWebSocket_NoURL1140)
stop_process:skip
}

proctype TestWebSocket_NoURL114(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Init900 = [1] of {int};
	Mutexdef w_conn_writeErrMu;
	run mutexMonitor(w_conn_writeErrMu);
	run Init90(w_conn_writeErrMu,child_Init900);
	child_Init900?0;
	stop_process: skip;
	child!0
}
proctype Init90(Mutexdef w_conn_writeErrMu;chan child) {
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

proctype receiver(chan c) {
c?0
}

