// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vttablet/tabletserver/txserializer/tx_serializer_test.go#L513
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTxSerializerPending5130 = [1] of {int};
	run TestTxSerializerPending513(child_TestTxSerializerPending5130);
	run receiver(child_TestTxSerializerPending5130)
stop_process:skip
}

proctype TestTxSerializerPending513(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Pending2960 = [1] of {int};
	Mutexdef txs_mu;
	Mutexdef txs_logGlobalQueueExceededDryRun_mu;
	Mutexdef txs_logQueueExceededDryRun_mu;
	Mutexdef txs_logWaitsDryRun_mu;
	Mutexdef txs_logDryRun_mu;
	Mutexdef txs_log_mu;
	run mutexMonitor(txs_log_mu);
	run mutexMonitor(txs_logDryRun_mu);
	run mutexMonitor(txs_logWaitsDryRun_mu);
	run mutexMonitor(txs_logQueueExceededDryRun_mu);
	run mutexMonitor(txs_logGlobalQueueExceededDryRun_mu);
	run mutexMonitor(txs_mu);
	run Pending296(txs_log_mu,txs_logDryRun_mu,txs_logGlobalQueueExceededDryRun_mu,txs_logQueueExceededDryRun_mu,txs_logWaitsDryRun_mu,txs_mu,child_Pending2960);
	child_Pending2960?0;
	stop_process: skip;
	child!0
}
proctype Pending296(Mutexdef txs_log_mu;Mutexdef txs_logDryRun_mu;Mutexdef txs_logGlobalQueueExceededDryRun_mu;Mutexdef txs_logQueueExceededDryRun_mu;Mutexdef txs_logWaitsDryRun_mu;Mutexdef txs_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	txs_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	txs_mu.Unlock!false;
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

