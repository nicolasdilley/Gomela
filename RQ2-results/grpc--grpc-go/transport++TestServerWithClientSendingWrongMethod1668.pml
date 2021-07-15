
// https://github.com/grpc/grpc-go/blob/master/internal/transport/transport_test.go#L1668
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestServerWithClientSendingWrongMethod16680 = [1] of {int};
	run TestServerWithClientSendingWrongMethod1668(child_TestServerWithClientSendingWrongMethod16680)
stop_process:skip
}

proctype TestServerWithClientSendingWrongMethod1668(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_stop4070 = [1] of {int};
	chan child_AnonymousTestServerWithClientSendingWrongMethod169216691 = [1] of {int};
	Mutexdef server_h_t_mu;
	Mutexdef server_h_t_bdpEst_mu;
	Mutexdef server_h_t_controlBuf_mu;
	Mutexdef server_h_t_loopy_bdpEst_mu;
	Mutexdef server_h_t_loopy_cbuf_mu;
	Mutexdef server_mu;
	run mutexMonitor(server_mu);
	run mutexMonitor(server_h_t_loopy_cbuf_mu);
	run mutexMonitor(server_h_t_loopy_bdpEst_mu);
	run mutexMonitor(server_h_t_controlBuf_mu);
	run mutexMonitor(server_h_t_bdpEst_mu);
	run mutexMonitor(server_h_t_mu);
	run AnonymousTestServerWithClientSendingWrongMethod16921669(server_mu,server_h_t_loopy_cbuf_mu,server_h_t_loopy_bdpEst_mu,server_h_t_controlBuf_mu,server_h_t_bdpEst_mu,server_h_t_mu,child_AnonymousTestServerWithClientSendingWrongMethod169216691);
	stop_process: skip;
		run stop407(server_mu,server_h_t_loopy_cbuf_mu,server_h_t_loopy_bdpEst_mu,server_h_t_controlBuf_mu,server_h_t_bdpEst_mu,server_h_t_mu,child_stop4070);
	child_stop4070?0;
	child!0
}
proctype stop407(Mutexdef s_mu;Mutexdef s_h_t_loopy_cbuf_mu;Mutexdef s_h_t_loopy_bdpEst_mu;Mutexdef s_h_t_controlBuf_mu;Mutexdef s_h_t_bdpEst_mu;Mutexdef s_h_t_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.Lock!false;
	s_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype AnonymousTestServerWithClientSendingWrongMethod16921669(Mutexdef server_mu;Mutexdef server_h_t_loopy_cbuf_mu;Mutexdef server_h_t_loopy_bdpEst_mu;Mutexdef server_h_t_controlBuf_mu;Mutexdef server_h_t_bdpEst_mu;Mutexdef server_h_t_mu;chan child) {
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

