// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtgate/grpcvtgateconn/suite_test.go#L282
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_RunTests2820 = [1] of {int};
	run RunTests282(child_RunTests2820);
	run receiver(child_RunTests2820)
stop_process:skip
}

proctype RunTests282(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_testPreparePanic5237 = [1] of {int};
	chan child_testStreamExecutePanic4886 = [1] of {int};
	chan child_testExecuteBatchPanic4155 = [1] of {int};
	chan child_testExecutePanic3844 = [1] of {int};
	chan child_testPrepare5023 = [1] of {int};
	chan child_testExecuteBatch3912 = [1] of {int};
	chan child_testStreamExecute4221 = [1] of {int};
	chan child_testExecute3600 = [1] of {int};
	Mutexdef fs_t_context_mu;
	Mutexdef fs_t_context_match_mu;
	Mutexdef session_session_state_atomicMessageInfo_initMu;
	run mutexMonitor(session_session_state_atomicMessageInfo_initMu);
	run mutexMonitor(fs_t_context_match_mu);
	run mutexMonitor(fs_t_context_mu);
	run testExecute360(session_session_state_atomicMessageInfo_initMu,child_testExecute3600);
	child_testExecute3600?0;
	run testStreamExecute422(session_session_state_atomicMessageInfo_initMu,child_testStreamExecute4221);
	child_testStreamExecute4221?0;
	run testExecuteBatch391(session_session_state_atomicMessageInfo_initMu,child_testExecuteBatch3912);
	child_testExecuteBatch3912?0;
	run testPrepare502(session_session_state_atomicMessageInfo_initMu,child_testPrepare5023);
	child_testPrepare5023?0;
	run testExecutePanic384(session_session_state_atomicMessageInfo_initMu,child_testExecutePanic3844);
	child_testExecutePanic3844?0;
	run testExecuteBatchPanic415(session_session_state_atomicMessageInfo_initMu,child_testExecuteBatchPanic4155);
	child_testExecuteBatchPanic4155?0;
	run testStreamExecutePanic488(session_session_state_atomicMessageInfo_initMu,child_testStreamExecutePanic4886);
	child_testStreamExecutePanic4886?0;
	run testPreparePanic523(session_session_state_atomicMessageInfo_initMu,child_testPreparePanic5237);
	child_testPreparePanic5237?0;
	stop_process: skip;
	child!0
}
proctype testExecute360(Mutexdef session_session_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype testStreamExecute422(Mutexdef session_session_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype testExecuteBatch391(Mutexdef session_session_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype testPrepare502(Mutexdef session_session_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype testExecutePanic384(Mutexdef session_session_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype testExecuteBatchPanic415(Mutexdef session_session_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype testStreamExecutePanic488(Mutexdef session_session_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype testPreparePanic523(Mutexdef session_session_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

