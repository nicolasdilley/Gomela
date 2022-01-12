// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/wrangler/traffic_switcher_test.go#L1693
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestReverseVReplicationUpdateQuery16930 = [1] of {int};
	run TestReverseVReplicationUpdateQuery1693(child_TestReverseVReplicationUpdateQuery16930);
	run receiver(child_TestReverseVReplicationUpdateQuery16930)
stop_process:skip
}

proctype TestReverseVReplicationUpdateQuery1693(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ts_externalTopo_mu;
	Mutexdef ts_wr_sourceTs_mu;
	Mutexdef ts_wr_ts_mu;
	int var_tCases = -2; // opt var_tCases
	run mutexMonitor(ts_wr_ts_mu);
	run mutexMonitor(ts_wr_sourceTs_mu);
	run mutexMonitor(ts_externalTopo_mu);
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

