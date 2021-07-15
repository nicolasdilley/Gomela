
// https://github.com/gorilla/websocket/blob/master/conn_test.go#L439
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestWriteAfterMessageWriterClose4390 = [1] of {int};
	run TestWriteAfterMessageWriterClose439(child_TestWriteAfterMessageWriterClose4390)
stop_process:skip
}

proctype TestWriteAfterMessageWriterClose439(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NextWriter5112 = [1] of {int};
	chan child_NextWriter5111 = [1] of {int};
	chan child_NextWriter5110 = [1] of {int};
	Mutexdef wc_writeErrMu;
	run mutexMonitor(wc_writeErrMu);
	run NextWriter511(wc_writeErrMu,child_NextWriter5110);
	child_NextWriter5110?0;
	run NextWriter511(wc_writeErrMu,child_NextWriter5111);
	child_NextWriter5111?0;
	run NextWriter511(wc_writeErrMu,child_NextWriter5112);
	child_NextWriter5112?0;
	stop_process: skip;
	child!0
}
proctype NextWriter511(Mutexdef c_writeErrMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_beginMessage4680 = [1] of {int};
	Mutexdef mw_c_writeErrMu;
	run mutexMonitor(mw_c_writeErrMu);
	run beginMessage468(c_writeErrMu,child_beginMessage4680);
	child_beginMessage4680?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype beginMessage468(Mutexdef c_writeErrMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	c_writeErrMu.Lock!false;
	c_writeErrMu.Unlock!false;
	

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

