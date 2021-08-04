// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/executor/builder.go#L2293
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_constructDAGReq22930 = [1] of {int};
	run constructDAGReq2293(child_constructDAGReq22930);
	run receiver(child_constructDAGReq22930)
stop_process:skip
}

proctype constructDAGReq2293(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PushDownFlags6000 = [1] of {int};
	Mutexdef sc_RuntimeStatsColl_mu;
	Mutexdef sc_mu;
	run mutexMonitor(sc_mu);
	run mutexMonitor(sc_RuntimeStatsColl_mu);
	run PushDownFlags600(sc_mu,sc_RuntimeStatsColl_mu,child_PushDownFlags6000);
	child_PushDownFlags6000?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype PushDownFlags600(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
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

