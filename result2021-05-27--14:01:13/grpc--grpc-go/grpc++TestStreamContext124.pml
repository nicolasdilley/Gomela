// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc/grpc-go/blob/ebd6aba6754d073a696e5727158cd0c917ce1019/server_test.go#L124
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStreamContext1240 = [1] of {int};
	run TestStreamContext124(child_TestStreamContext1240);
	run receiver(child_TestStreamContext1240)
stop_process:skip
}

proctype TestStreamContext124(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef stream_hdrMu;
	Mutexdef stream_fc_mu;
	Mutexdef stream_buf_mu;
	Mutexdef stream_ct_mu;
	chan child_NewContextWithServerTransportStream15850 = [1] of {int};
	Mutexdef expectedStream_hdrMu;
	Mutexdef expectedStream_fc_mu;
	Mutexdef expectedStream_buf_mu;
	Mutexdef expectedStream_ct_mu;
	run mutexMonitor(expectedStream_ct_mu);
	run mutexMonitor(expectedStream_buf_mu);
	run mutexMonitor(expectedStream_fc_mu);
	run mutexMonitor(expectedStream_hdrMu);
	run NewContextWithServerTransportStream1585(expectedStream_buf_mu,expectedStream_ct_mu,expectedStream_fc_mu,expectedStream_hdrMu,child_NewContextWithServerTransportStream15850);
	child_NewContextWithServerTransportStream15850?0;
	run mutexMonitor(stream_ct_mu);
	run mutexMonitor(stream_buf_mu);
	run mutexMonitor(stream_fc_mu);
	run mutexMonitor(stream_hdrMu);
	stop_process: skip;
	child!0
}
proctype NewContextWithServerTransportStream1585(Mutexdef stream_buf_mu;Mutexdef stream_ct_mu;Mutexdef stream_fc_mu;Mutexdef stream_hdrMu;chan child) {
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

