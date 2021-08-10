// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc/grpc-go/blob/ebd6aba6754d073a696e5727158cd0c917ce1019/internal/transport/transport_test.go#L566
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_performOneRPC5660 = [1] of {int};
	run performOneRPC566(child_performOneRPC5660);
	run receiver(child_performOneRPC5660)
stop_process:skip
}

proctype performOneRPC566(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Read4611 = [1] of {int};
	chan child_Read4610 = [1] of {int};
	Mutexdef s_hdrMu;
	Mutexdef s_fc_mu;
	Mutexdef s_buf_mu;
	Mutexdef s_ct_mu;
	run mutexMonitor(s_ct_mu);
	run mutexMonitor(s_buf_mu);
	run mutexMonitor(s_fc_mu);
	run mutexMonitor(s_hdrMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run Read461(s_buf_mu,s_ct_mu,s_fc_mu,s_hdrMu,child_Read4610);
		child_Read4610?0;
		run Read461(s_buf_mu,s_ct_mu,s_fc_mu,s_hdrMu,child_Read4611);
		child_Read4611?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype Read461(Mutexdef s_buf_mu;Mutexdef s_ct_mu;Mutexdef s_fc_mu;Mutexdef s_hdrMu;chan child) {
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

