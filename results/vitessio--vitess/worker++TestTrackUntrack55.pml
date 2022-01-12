// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/vitessio/vitess/blob//go/vt/worker/tablet_tracker_test.go#L55
#define def_var_allTs  -2 // opt stats line 53
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTrackUntrack550 = [1] of {int};
	run TestTrackUntrack55(child_TestTrackUntrack550);
	run receiver(child_TestTrackUntrack550)
stop_process:skip
}

proctype TestTrackUntrack55(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Track533 = [1] of {int};
	int var_allTs = def_var_allTs;
	chan child_Untrack842 = [1] of {int};
	chan child_Track531 = [1] of {int};
	int var_allTs = def_var_allTs;
	chan child_Track530 = [1] of {int};
	int var_allTs = def_var_allTs;
	Mutexdef want_PrimaryTermStartTime_state_atomicMessageInfo_initMu;
	Mutexdef want_KeyRange_state_atomicMessageInfo_initMu;
	Mutexdef want_Alias_state_atomicMessageInfo_initMu;
	Mutexdef want_state_atomicMessageInfo_initMu;
	Mutexdef got_PrimaryTermStartTime_state_atomicMessageInfo_initMu;
	Mutexdef got_KeyRange_state_atomicMessageInfo_initMu;
	Mutexdef got_Alias_state_atomicMessageInfo_initMu;
	Mutexdef got_state_atomicMessageInfo_initMu;
	Mutexdef tt_mu;
	run mutexMonitor(tt_mu);
	run mutexMonitor(got_state_atomicMessageInfo_initMu);
	run mutexMonitor(got_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(got_KeyRange_state_atomicMessageInfo_initMu);
	run mutexMonitor(got_PrimaryTermStartTime_state_atomicMessageInfo_initMu);
	run mutexMonitor(want_state_atomicMessageInfo_initMu);
	run mutexMonitor(want_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(want_KeyRange_state_atomicMessageInfo_initMu);
	run mutexMonitor(want_PrimaryTermStartTime_state_atomicMessageInfo_initMu);
	run Track53(tt_mu,var_allTs,child_Track530);
	child_Track530?0;
	run Track53(tt_mu,var_allTs,child_Track531);
	child_Track531?0;
	run Untrack84(tt_mu,child_Untrack842);
	child_Untrack842?0;
	run Track53(tt_mu,var_allTs,child_Track533);
	child_Track533?0;
	stop_process: skip;
	child!0
}
proctype Track53(Mutexdef t_mu;int var_stats;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_t_tabletsByUsage = -2; // opt var_t_tabletsByUsage
	t_mu.Lock!false;
		defer1: skip;
	t_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Untrack84(Mutexdef t_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	t_mu.Lock!false;
		defer1: skip;
	t_mu.Unlock!false;
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

