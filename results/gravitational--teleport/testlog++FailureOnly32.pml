// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gravitational/teleport/blob//lib/utils/testlog/log.go#L32
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_FailureOnly320 = [1] of {int};
	run FailureOnly32(child_FailureOnly320);
	run receiver(child_FailureOnly320)
stop_process:skip
}

proctype FailureOnly32(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef logger_mu_lock;
	Mutexdef buf_writer_p_once_m;
	Mutexdef buf_writer_p_wrMu;
	Mutexdef buf_reader_p_once_m;
	Mutexdef buf_reader_p_wrMu;
	run mutexMonitor(buf_reader_p_wrMu);
	run mutexMonitor(buf_reader_p_once_m);
	run mutexMonitor(buf_writer_p_wrMu);
	run mutexMonitor(buf_writer_p_once_m);
	run mutexMonitor(logger_mu_lock);
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

