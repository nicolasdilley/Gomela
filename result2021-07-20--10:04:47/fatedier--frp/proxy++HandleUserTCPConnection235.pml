// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/fatedier/frp/blob/2408f1df04ad9128ee31a013799f5790dbda5cb3/server/proxy/proxy.go#L235
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_HandleUserTCPConnection2350 = [1] of {int};
	run HandleUserTCPConnection235(child_HandleUserTCPConnection2350);
	run receiver(child_HandleUserTCPConnection2350)
stop_process:skip
}

proctype HandleUserTCPConnection235(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef rc_NatHoleController_mu;
	Mutexdef rc_UDPPortManager_mu;
	Mutexdef rc_TCPPortManager_mu;
	Mutexdef rc_TCPMuxGroupCtl_mu;
	Mutexdef rc_HTTPGroupCtl_mu;
	Mutexdef rc_TCPGroupCtl_mu;
	Mutexdef rc_VisitorManager_mu;
	run mutexMonitor(rc_VisitorManager_mu);
	run mutexMonitor(rc_TCPGroupCtl_mu);
	run mutexMonitor(rc_HTTPGroupCtl_mu);
	run mutexMonitor(rc_TCPMuxGroupCtl_mu);
	run mutexMonitor(rc_TCPPortManager_mu);
	run mutexMonitor(rc_UDPPortManager_mu);
	run mutexMonitor(rc_NatHoleController_mu);
	

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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
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

