// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gravitational/teleport/blob//lib/benchmark/benchmark.go#L245
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_execute2450 = [1] of {int};
	run execute245(child_execute2450);
	run receiver(child_execute2450)
stop_process:skip
}

proctype execute245(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef out_writer_p_once_m;
	Mutexdef out_writer_p_wrMu;
	Mutexdef out_reader_p_once_m;
	Mutexdef out_reader_p_wrMu;
	Mutexdef writer_p_once_m;
	Mutexdef writer_p_wrMu;
	Mutexdef reader_p_once_m;
	Mutexdef reader_p_wrMu;
	Mutexdef config_TLS_mutex;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(config_TLS_mutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(reader_p_wrMu);
	run mutexMonitor(reader_p_once_m);
	run mutexMonitor(writer_p_wrMu);
	run mutexMonitor(writer_p_once_m);
	run mutexMonitor(out_reader_p_wrMu);
	run mutexMonitor(out_reader_p_once_m);
	run mutexMonitor(out_writer_p_wrMu);
	run mutexMonitor(out_writer_p_once_m);
	

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

