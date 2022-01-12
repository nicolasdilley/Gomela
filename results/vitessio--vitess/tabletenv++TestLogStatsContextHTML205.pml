// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vttablet/tabletserver/tabletenv/logstats_test.go#L205
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLogStatsContextHTML2050 = [1] of {int};
	run TestLogStatsContextHTML205(child_TestLogStatsContextHTML2050);
	run receiver(child_TestLogStatsContextHTML2050)
stop_process:skip
}

proctype TestLogStatsContextHTML205(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ContextHTML1611 = [1] of {int};
	chan child_ContextHTML1610 = [1] of {int};
	Mutexdef logStats_Target_state_atomicMessageInfo_initMu;
	run mutexMonitor(logStats_Target_state_atomicMessageInfo_initMu);
	run ContextHTML161(logStats_Target_state_atomicMessageInfo_initMu,child_ContextHTML1610);
	child_ContextHTML1610?0;
	

	if
	:: true -> 
		run ContextHTML161(logStats_Target_state_atomicMessageInfo_initMu,child_ContextHTML1611);
		child_ContextHTML1611?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype ContextHTML161(Mutexdef stats_Target_state_atomicMessageInfo_initMu;chan child) {
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

