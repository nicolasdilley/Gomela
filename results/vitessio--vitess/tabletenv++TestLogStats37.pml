// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vttablet/tabletserver/tabletenv/logstats_test.go#L37
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLogStats370 = [1] of {int};
	run TestLogStats37(child_TestLogStats370);
	run receiver(child_TestLogStats370)
stop_process:skip
}

proctype TestLogStats37(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SizeOfResponse1253 = [1] of {int};
	chan child_SizeOfResponse1252 = [1] of {int};
	chan child_RewrittenSQL1181 = [1] of {int};
	chan child_AddRewrittenSQL1040 = [1] of {int};
	Mutexdef logStats_Target_state_atomicMessageInfo_initMu;
	run mutexMonitor(logStats_Target_state_atomicMessageInfo_initMu);
	run AddRewrittenSQL104(logStats_Target_state_atomicMessageInfo_initMu,child_AddRewrittenSQL1040);
	child_AddRewrittenSQL1040?0;
	run RewrittenSQL118(logStats_Target_state_atomicMessageInfo_initMu,child_RewrittenSQL1181);
	child_RewrittenSQL1181?0;
	run SizeOfResponse125(logStats_Target_state_atomicMessageInfo_initMu,child_SizeOfResponse1252);
	child_SizeOfResponse1252?0;
	run SizeOfResponse125(logStats_Target_state_atomicMessageInfo_initMu,child_SizeOfResponse1253);
	child_SizeOfResponse1253?0;
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
proctype RewrittenSQL118(Mutexdef stats_Target_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

