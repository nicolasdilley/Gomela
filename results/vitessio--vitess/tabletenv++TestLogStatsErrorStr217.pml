// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vttablet/tabletserver/tabletenv/logstats_test.go#L217
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLogStatsErrorStr2170 = [1] of {int};
	run TestLogStatsErrorStr217(child_TestLogStatsErrorStr2170);
	run receiver(child_TestLogStatsErrorStr2170)
stop_process:skip
}

proctype TestLogStatsErrorStr217(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ErrorStr1663 = [1] of {int};
	chan child_ErrorStr1662 = [1] of {int};
	chan child_ErrorStr1661 = [1] of {int};
	chan child_ErrorStr1660 = [1] of {int};
	Mutexdef logStats_Target_state_atomicMessageInfo_initMu;
	run mutexMonitor(logStats_Target_state_atomicMessageInfo_initMu);
	run ErrorStr166(logStats_Target_state_atomicMessageInfo_initMu,child_ErrorStr1660);
	child_ErrorStr1660?0;
	

	if
	:: true -> 
		run ErrorStr166(logStats_Target_state_atomicMessageInfo_initMu,child_ErrorStr1661);
		child_ErrorStr1661?0
	:: true;
	fi;
	run ErrorStr166(logStats_Target_state_atomicMessageInfo_initMu,child_ErrorStr1662);
	child_ErrorStr1662?0;
	

	if
	:: true -> 
		run ErrorStr166(logStats_Target_state_atomicMessageInfo_initMu,child_ErrorStr1663);
		child_ErrorStr1663?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype ErrorStr166(Mutexdef stats_Target_state_atomicMessageInfo_initMu;chan child) {
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

