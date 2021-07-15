
// https://github.com/valyala/fasthttp/blob/master/fasthttputil/pipeconns_test.go#L13
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPipeConnsWriteTimeout130 = [1] of {int};
	run TestPipeConnsWriteTimeout13(child_TestPipeConnsWriteTimeout130)
stop_process:skip
}

proctype TestPipeConnsWriteTimeout13(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Conn2631 = [1] of {int};
	chan child_Conn1550 = [1] of {int};
	Mutexdef pc_stopChLock;
	Mutexdef pc_c2_readDeadlineChLock;
	Mutexdef pc_c1_readDeadlineChLock;
	run mutexMonitor(pc_c1_readDeadlineChLock);
	run mutexMonitor(pc_c2_readDeadlineChLock);
	run mutexMonitor(pc_stopChLock);
	run Conn155(pc_c1_readDeadlineChLock,pc_c2_readDeadlineChLock,pc_stopChLock,child_Conn1550);
	child_Conn1550?0;
	run Conn263(pc_c1_readDeadlineChLock,pc_c2_readDeadlineChLock,pc_stopChLock,child_Conn2631);
	child_Conn2631?0;
	stop_process: skip;
	child!0
}
proctype Conn155(Mutexdef pc_c1_readDeadlineChLock;Mutexdef pc_c2_readDeadlineChLock;Mutexdef pc_stopChLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Conn263(Mutexdef pc_c1_readDeadlineChLock;Mutexdef pc_c2_readDeadlineChLock;Mutexdef pc_stopChLock;chan child) {
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

