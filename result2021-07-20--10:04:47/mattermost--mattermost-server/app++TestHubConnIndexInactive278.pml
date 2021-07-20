// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/mattermost/mattermost-server/blob/5c16de58a02099df38e1e8486df148d1b798460a/app/web_hub_test.go#L278
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHubConnIndexInactive2780 = [1] of {int};
	run TestHubConnIndexInactive278(child_TestHubConnIndexInactive2780);
	run receiver(child_TestHubConnIndexInactive2780)
stop_process:skip
}

proctype TestHubConnIndexInactive278(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Has6569 = [1] of {int};
	chan child_Has6568 = [1] of {int};
	chan child_Add6317 = [1] of {int};
	chan child_Has6566 = [1] of {int};
	chan child_Add6315 = [1] of {int};
	chan child_Add6314 = [1] of {int};
	chan child_Add6313 = [1] of {int};
	chan child_SetConnectionID2192 = [1] of {int};
	Mutexdef wc3_WebSocket_writeErrMu;
	chan child_SetConnectionID2191 = [1] of {int};
	Mutexdef wc2_WebSocket_writeErrMu;
	chan child_SetConnectionID2190 = [1] of {int};
	Mutexdef wc1_WebSocket_writeErrMu;
	run mutexMonitor(wc1_WebSocket_writeErrMu);
	run SetConnectionID219(wc1_WebSocket_writeErrMu,child_SetConnectionID2190);
	child_SetConnectionID2190?0;
	run mutexMonitor(wc2_WebSocket_writeErrMu);
	run SetConnectionID219(wc2_WebSocket_writeErrMu,child_SetConnectionID2191);
	child_SetConnectionID2191?0;
	run mutexMonitor(wc3_WebSocket_writeErrMu);
	run SetConnectionID219(wc3_WebSocket_writeErrMu,child_SetConnectionID2192);
	child_SetConnectionID2192?0;
	run Add631(wc1_WebSocket_writeErrMu,child_Add6313);
	child_Add6313?0;
	run Add631(wc2_WebSocket_writeErrMu,child_Add6314);
	child_Add6314?0;
	run Add631(wc3_WebSocket_writeErrMu,child_Add6315);
	child_Add6315?0;
	run Has656(wc3_WebSocket_writeErrMu,child_Has6566);
	child_Has6566?0;
	run Add631(wc3_WebSocket_writeErrMu,child_Add6317);
	child_Add6317?0;
	run Has656(wc3_WebSocket_writeErrMu,child_Has6568);
	child_Has6568?0;
	run Has656(wc3_WebSocket_writeErrMu,child_Has6569);
	child_Has6569?0;
	stop_process: skip;
	child!0
}
proctype SetConnectionID219(Mutexdef wc_WebSocket_writeErrMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Add631(Mutexdef wc_WebSocket_writeErrMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Has656(Mutexdef wc_WebSocket_writeErrMu;chan child) {
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

