// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vttablet/tabletserver/tabletenv/logstats_test.go#L153
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLogStatsFilter1530 = [1] of {int};
	run TestLogStatsFilter153(child_TestLogStatsFilter1530);
	run receiver(child_TestLogStatsFilter1530)
stop_process:skip
}

proctype TestLogStatsFilter153(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_testFormat553 = [1] of {int};
	chan child_testFormat552 = [1] of {int};
	chan child_testFormat551 = [1] of {int};
	chan child_AddRewrittenSQL1040 = [1] of {int};
	Mutexdef logStats_Target_state_atomicMessageInfo_initMu;
	run mutexMonitor(logStats_Target_state_atomicMessageInfo_initMu);
	run AddRewrittenSQL104(logStats_Target_state_atomicMessageInfo_initMu,child_AddRewrittenSQL1040);
	child_AddRewrittenSQL1040?0;
	run testFormat55(logStats_Target_state_atomicMessageInfo_initMu,child_testFormat551);
	child_testFormat551?0;
	run testFormat55(logStats_Target_state_atomicMessageInfo_initMu,child_testFormat552);
	child_testFormat552?0;
	run testFormat55(logStats_Target_state_atomicMessageInfo_initMu,child_testFormat553);
	child_testFormat553?0;
	stop_process: skip;
	child!0
}
proctype AddRewrittenSQL104(Mutexdef stats_Target_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype testFormat55(Mutexdef stats_Target_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Logf1841 = [1] of {int};
	run Logf184(stats_Target_state_atomicMessageInfo_initMu,child_Logf1841);
	child_Logf1841?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Logf184(Mutexdef stats_Target_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ErrorStr1667 = [1] of {int};
	chan child_SizeOfResponse1256 = [1] of {int};
	chan child_FmtQuerySources1415 = [1] of {int};
	chan child_EffectiveCaller944 = [1] of {int};
	chan child_ImmediateCaller893 = [1] of {int};
	chan child_CallInfo1742 = [1] of {int};
	chan child_RewrittenSQL1181 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run RewrittenSQL118(stats_Target_state_atomicMessageInfo_initMu,child_RewrittenSQL1181);
		child_RewrittenSQL1181?0
	:: true;
	fi;
	run CallInfo174(stats_Target_state_atomicMessageInfo_initMu,child_CallInfo1742);
	child_CallInfo1742?0;
	

	if
	:: true;
	:: true;
	fi;
	run ImmediateCaller89(stats_Target_state_atomicMessageInfo_initMu,child_ImmediateCaller893);
	child_ImmediateCaller893?0;
	run EffectiveCaller94(stats_Target_state_atomicMessageInfo_initMu,child_EffectiveCaller944);
	child_EffectiveCaller944?0;
	run FmtQuerySources141(stats_Target_state_atomicMessageInfo_initMu,child_FmtQuerySources1415);
	child_FmtQuerySources1415?0;
	run SizeOfResponse125(stats_Target_state_atomicMessageInfo_initMu,child_SizeOfResponse1256);
	child_SizeOfResponse1256?0;
	run ErrorStr166(stats_Target_state_atomicMessageInfo_initMu,child_ErrorStr1667);
	child_ErrorStr1667?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype RewrittenSQL118(Mutexdef stats_Target_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype CallInfo174(Mutexdef stats_Target_state_atomicMessageInfo_initMu;chan child) {
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
proctype ImmediateCaller89(Mutexdef stats_Target_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype EffectiveCaller94(Mutexdef stats_Target_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype FmtQuerySources141(Mutexdef stats_Target_state_atomicMessageInfo_initMu;chan child) {
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
proctype SizeOfResponse125(Mutexdef stats_Target_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_row = -2; // opt var_row
	int var_stats_Rows = -2; // opt var_stats_Rows
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
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

