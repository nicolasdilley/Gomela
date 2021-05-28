// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/traefik/traefik/blob/080cf98e512f6fcb93838de76a6aa34ff147dee4/pkg/server/server_entrypoint_tcp.go#L133
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewTCPEntryPoint1330 = [1] of {int};
	run NewTCPEntryPoint133(child_NewTCPEntryPoint1330);
	run receiver(child_NewTCPEntryPoint1330)
stop_process:skip
}

proctype NewTCPEntryPoint133(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Switch1140 = [1] of {int};
	Mutexdef tcpSwitcher_router_lock;
	Mutexdef h3server_lock;
	Mutexdef rt_httpsTLSConfig_mutex;
	Mutexdef tracker_lock;
	run mutexMonitor(tracker_lock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(rt_httpsTLSConfig_mutex);
	

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
	run mutexMonitor(h3server_lock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(tcpSwitcher_router_lock);
	run Switch114(tcpSwitcher_router_lock,rt_httpsTLSConfig_mutex,child_Switch1140);
	child_Switch1140?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Switch114(Mutexdef eps_router_lock;Mutexdef routersTCP_httpsTLSConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int routersTCP = -2; // opt routersTCP
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

