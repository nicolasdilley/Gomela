
// https://github.com/grpc/grpc-go/blob/master/internal/transport/transport_test.go#L566
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_performOneRPC5660 = [1] of {int};
	run performOneRPC566(child_performOneRPC5660)
stop_process:skip
}

proctype performOneRPC566(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Read4612 = [1] of {int};
	chan child_Read4611 = [1] of {int};
	chan child_Write2900 = [1] of {int};
	Mutexdef s_status_s_state_atomicMessageInfo_initMu;
	Mutexdef s_hdrMu;
	Mutexdef s_fc_mu;
	Mutexdef s_buf_mu;
	Mutexdef s_ct_mu;
	Mutexdef s_ct_bdpEst_mu;
	Mutexdef s_ct_controlBuf_mu;
	Mutexdef s_ct_loopy_bdpEst_mu;
	Mutexdef s_ct_loopy_cbuf_mu;
	run mutexMonitor(s_ct_loopy_cbuf_mu);
	run mutexMonitor(s_ct_loopy_bdpEst_mu);
	run mutexMonitor(s_ct_controlBuf_mu);
	run mutexMonitor(s_ct_bdpEst_mu);
	run mutexMonitor(s_ct_mu);
	run mutexMonitor(s_buf_mu);
	run mutexMonitor(s_fc_mu);
	run mutexMonitor(s_hdrMu);
	run mutexMonitor(s_status_s_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Write290(s_ct_loopy_cbuf_mu,s_ct_loopy_bdpEst_mu,s_ct_controlBuf_mu,s_ct_bdpEst_mu,s_ct_mu,s_buf_mu,s_fc_mu,s_hdrMu,s_status_s_state_atomicMessageInfo_initMu,child_Write2900);
	child_Write2900?0;
	

	if
	:: true -> 
		run Read461(s_ct_loopy_cbuf_mu,s_ct_loopy_bdpEst_mu,s_ct_controlBuf_mu,s_ct_bdpEst_mu,s_ct_mu,s_buf_mu,s_fc_mu,s_hdrMu,s_status_s_state_atomicMessageInfo_initMu,child_Read4611);
		child_Read4611?0;
		run Read461(s_ct_loopy_cbuf_mu,s_ct_loopy_bdpEst_mu,s_ct_controlBuf_mu,s_ct_bdpEst_mu,s_ct_mu,s_buf_mu,s_fc_mu,s_hdrMu,s_status_s_state_atomicMessageInfo_initMu,child_Read4612);
		child_Read4612?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype Write290(Mutexdef s_ct_loopy_cbuf_mu;Mutexdef s_ct_loopy_bdpEst_mu;Mutexdef s_ct_controlBuf_mu;Mutexdef s_ct_bdpEst_mu;Mutexdef s_ct_mu;Mutexdef s_buf_mu;Mutexdef s_fc_mu;Mutexdef s_hdrMu;Mutexdef s_status_s_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_updateHeaderSent3000 = [1] of {int};
	run updateHeaderSent300(s_ct_loopy_cbuf_mu,s_ct_loopy_bdpEst_mu,s_ct_controlBuf_mu,s_ct_bdpEst_mu,s_ct_mu,s_buf_mu,s_fc_mu,s_hdrMu,s_status_s_state_atomicMessageInfo_initMu,child_updateHeaderSent3000);
	child_updateHeaderSent3000?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype updateHeaderSent300(Mutexdef s_ct_loopy_cbuf_mu;Mutexdef s_ct_loopy_bdpEst_mu;Mutexdef s_ct_controlBuf_mu;Mutexdef s_ct_bdpEst_mu;Mutexdef s_ct_mu;Mutexdef s_buf_mu;Mutexdef s_fc_mu;Mutexdef s_hdrMu;Mutexdef s_status_s_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Read461(Mutexdef s_ct_loopy_cbuf_mu;Mutexdef s_ct_loopy_bdpEst_mu;Mutexdef s_ct_controlBuf_mu;Mutexdef s_ct_bdpEst_mu;Mutexdef s_ct_mu;Mutexdef s_buf_mu;Mutexdef s_fc_mu;Mutexdef s_hdrMu;Mutexdef s_status_s_state_atomicMessageInfo_initMu;chan child) {
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

