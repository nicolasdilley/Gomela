
// https://github.com/moby/moby/blob/master/pkg/tarsum/tarsum_test.go#L169
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_emptyTarSum1690 = [1] of {int};
	run emptyTarSum169(child_emptyTarSum1690)
stop_process:skip
}

proctype emptyTarSum169(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewTarSum471 = [1] of {int};
	chan child_AnonymousemptyTarSum1751700 = [1] of {int};
	Mutexdef writer_p_once_m;
	Mutexdef writer_p_wrMu;
	Mutexdef reader_p_once_m;
	Mutexdef reader_p_wrMu;
	run mutexMonitor(reader_p_wrMu);
	run mutexMonitor(reader_p_once_m);
	run mutexMonitor(writer_p_wrMu);
	run mutexMonitor(writer_p_once_m);
	run AnonymousemptyTarSum175170(reader_p_wrMu,reader_p_once_m,writer_p_wrMu,writer_p_once_m,child_AnonymousemptyTarSum1751700);
	run NewTarSum47(reader_p_wrMu,reader_p_once_m,child_NewTarSum471);
	child_NewTarSum471?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousemptyTarSum175170(Mutexdef reader_p_wrMu;Mutexdef reader_p_once_m;Mutexdef writer_p_wrMu;Mutexdef writer_p_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close160 = [1] of {int};
	run Close16(writer_p_wrMu,writer_p_once_m,child_Close160);
	child_Close160?0;
	stop_process: skip;
	child!0
}
proctype Close16(Mutexdef n_p_wrMu;Mutexdef n_p_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewTarSum47(Mutexdef r_p_wrMu;Mutexdef r_p_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewTarSumHash531 = [1] of {int};
	run NewTarSumHash53(r_p_wrMu,r_p_once_m,child_NewTarSumHash531);
	child_NewTarSumHash531?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewTarSumHash53(Mutexdef r_p_wrMu;Mutexdef r_p_once_m;chan child) {
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

