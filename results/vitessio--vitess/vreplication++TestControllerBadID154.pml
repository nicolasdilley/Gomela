// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vttablet/tabletmanager/vreplication/controller_test.go#L154
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestControllerBadID1540 = [1] of {int};
	run TestControllerBadID154(child_TestControllerBadID1540);
	run receiver(child_TestControllerBadID1540)
stop_process:skip
}

proctype TestControllerBadID154(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef __sourceTablet_mu;
	Mutexdef __tabletPicker_ts_mu;
	Mutexdef __source_state_atomicMessageInfo_initMu;
	Mutexdef __blpStats_VReplicationLagRates_mu;
	Mutexdef __blpStats_VReplicationLags_mu;
	Mutexdef __blpStats_QueryTimings_mu;
	Mutexdef __blpStats_PhaseTimings_mu;
	Mutexdef __blpStats_State_mu;
	Mutexdef __blpStats_History_mu;
	Mutexdef __blpStats_heartbeatMutex;
	Mutexdef __blpStats_lastPositionMutex;
	Mutexdef __blpStats_Rates_mu;
	Mutexdef __blpStats_Timings_mu;
	Mutexdef __vre_throttlerClient_throttler_throttledAppsMutex;
	Mutexdef __vre_throttlerClient_throttler_initMutex;
	Mutexdef __vre_ec_mu;
	Mutexdef __vre_ts_mu;
	Wgdef __vre_wg;
	Mutexdef __vre_mu;
	run mutexMonitor(__vre_mu);
	run wgMonitor(__vre_wg);
	run mutexMonitor(__vre_ts_mu);
	run mutexMonitor(__vre_ec_mu);
	run mutexMonitor(__vre_throttlerClient_throttler_initMutex);
	run mutexMonitor(__vre_throttlerClient_throttler_throttledAppsMutex);
	run mutexMonitor(__blpStats_Timings_mu);
	run mutexMonitor(__blpStats_Rates_mu);
	run mutexMonitor(__blpStats_lastPositionMutex);
	run mutexMonitor(__blpStats_heartbeatMutex);
	run mutexMonitor(__blpStats_History_mu);
	run mutexMonitor(__blpStats_State_mu);
	run mutexMonitor(__blpStats_PhaseTimings_mu);
	run mutexMonitor(__blpStats_QueryTimings_mu);
	run mutexMonitor(__blpStats_VReplicationLags_mu);
	run mutexMonitor(__blpStats_VReplicationLagRates_mu);
	run mutexMonitor(__source_state_atomicMessageInfo_initMu);
	run mutexMonitor(__tabletPicker_ts_mu);
	run mutexMonitor(__sourceTablet_mu);
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

