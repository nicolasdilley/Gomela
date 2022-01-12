// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/iox/read_test.go#L127
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestReadBytesChunks1270 = [1] of {int};
	run TestReadBytesChunks127(child_TestReadBytesChunks1270);
	run receiver(child_TestReadBytesChunks1270)
stop_process:skip
}

proctype TestReadBytesChunks127(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ReadBytes401 = [1] of {int};
	chan child_AnonymousTestReadBytesChunks1311290 = [1] of {int};
	Mutexdef writer_p_once_m;
	Mutexdef writer_p_wrMu;
	Mutexdef reader_p_once_m;
	Mutexdef reader_p_wrMu;
	run mutexMonitor(reader_p_wrMu);
	run mutexMonitor(reader_p_once_m);
	run mutexMonitor(writer_p_wrMu);
	run mutexMonitor(writer_p_once_m);
	run AnonymousTestReadBytesChunks131129(reader_p_wrMu,reader_p_once_m,writer_p_wrMu,writer_p_once_m,child_AnonymousTestReadBytesChunks1311290);
	run receiver(child_AnonymousTestReadBytesChunks1311290);
	run ReadBytes40(reader_p_once_m,reader_p_wrMu,child_ReadBytes401);
	child_ReadBytes401?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestReadBytesChunks131129(Mutexdef reader_p_wrMu;Mutexdef reader_p_once_m;Mutexdef writer_p_wrMu;Mutexdef writer_p_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype ReadBytes40(Mutexdef reader_p_once_m;Mutexdef reader_p_wrMu;chan child) {
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

