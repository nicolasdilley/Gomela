// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/logx/tracelogger_test.go#L21
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTraceLog210 = [1] of {int};
	run TestTraceLog21(child_TestTraceLog210);
	run receiver(child_TestTraceLog210)
stop_process:skip
}

proctype TestTraceLog21(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_String521 = [1] of {int};
	chan child_String520 = [1] of {int};
	Mutexdef tp_mu;
	Mutexdef buf_lock;
	run mutexMonitor(buf_lock);
	run mutexMonitor(tp_mu);
	run String52(buf_lock,child_String520);
	child_String520?0;
	run String52(buf_lock,child_String521);
	child_String521?0;
	stop_process: skip;
	child!0
}
proctype String52(Mutexdef mw_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	mw_lock.Lock!false;
	goto defer1;
		defer1: skip;
	mw_lock.Unlock!false;
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

