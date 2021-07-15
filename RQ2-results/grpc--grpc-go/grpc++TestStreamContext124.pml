
// https://github.com/grpc/grpc-go/blob/master/server_test.go#L124
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStreamContext1240 = [1] of {int};
	run TestStreamContext124(child_TestStreamContext1240)
stop_process:skip
}

proctype TestStreamContext124(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef stream_status_s_state_atomicMessageInfo_initMu;
	Mutexdef stream_hdrMu;
	Mutexdef stream_fc_mu;
	Mutexdef stream_buf_mu;
	Mutexdef stream_ct_mu;
	Mutexdef stream_ct_bdpEst_mu;
	Mutexdef stream_ct_controlBuf_mu;
	Mutexdef stream_ct_loopy_bdpEst_mu;
	Mutexdef stream_ct_loopy_cbuf_mu;
	chan child_NewContextWithServerTransportStream15850 = [1] of {int};
	Mutexdef expectedStream_status_s_state_atomicMessageInfo_initMu;
	Mutexdef expectedStream_hdrMu;
	Mutexdef expectedStream_fc_mu;
	Mutexdef expectedStream_buf_mu;
	Mutexdef expectedStream_ct_mu;
	Mutexdef expectedStream_ct_bdpEst_mu;
	Mutexdef expectedStream_ct_controlBuf_mu;
	Mutexdef expectedStream_ct_loopy_bdpEst_mu;
	Mutexdef expectedStream_ct_loopy_cbuf_mu;
	run mutexMonitor(expectedStream_ct_loopy_cbuf_mu);
	run mutexMonitor(expectedStream_ct_loopy_bdpEst_mu);
	run mutexMonitor(expectedStream_ct_controlBuf_mu);
	run mutexMonitor(expectedStream_ct_bdpEst_mu);
	run mutexMonitor(expectedStream_ct_mu);
	run mutexMonitor(expectedStream_buf_mu);
	run mutexMonitor(expectedStream_fc_mu);
	run mutexMonitor(expectedStream_hdrMu);
	run mutexMonitor(expectedStream_status_s_state_atomicMessageInfo_initMu);
	run NewContextWithServerTransportStream1585(expectedStream_ct_loopy_cbuf_mu,expectedStream_ct_loopy_bdpEst_mu,expectedStream_ct_controlBuf_mu,expectedStream_ct_bdpEst_mu,expectedStream_ct_mu,expectedStream_buf_mu,expectedStream_fc_mu,expectedStream_hdrMu,expectedStream_status_s_state_atomicMessageInfo_initMu,child_NewContextWithServerTransportStream15850);
	child_NewContextWithServerTransportStream15850?0;
	run mutexMonitor(stream_ct_loopy_cbuf_mu);
	run mutexMonitor(stream_ct_loopy_bdpEst_mu);
	run mutexMonitor(stream_ct_controlBuf_mu);
	run mutexMonitor(stream_ct_bdpEst_mu);
	run mutexMonitor(stream_ct_mu);
	run mutexMonitor(stream_buf_mu);
	run mutexMonitor(stream_fc_mu);
	run mutexMonitor(stream_hdrMu);
	run mutexMonitor(stream_status_s_state_atomicMessageInfo_initMu);
	stop_process: skip;
	child!0
}
proctype NewContextWithServerTransportStream1585(Mutexdef stream_ct_loopy_cbuf_mu;Mutexdef stream_ct_loopy_bdpEst_mu;Mutexdef stream_ct_controlBuf_mu;Mutexdef stream_ct_bdpEst_mu;Mutexdef stream_ct_mu;Mutexdef stream_buf_mu;Mutexdef stream_fc_mu;Mutexdef stream_hdrMu;Mutexdef stream_status_s_state_atomicMessageInfo_initMu;chan child) {
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

