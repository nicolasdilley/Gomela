
// https://github.com/hashicorp/vault/blob/master/serviceregistration/kubernetes/retry_handler_test.go#L74
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRetryHandlerAdd740 = [1] of {int};
	run TestRetryHandlerAdd74(child_TestRetryHandlerAdd740)
stop_process:skip
}

proctype TestRetryHandlerAdd74(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Notify1078 = [1] of {int};
	chan child_Notify1077 = [1] of {int};
	chan child_Notify1076 = [1] of {int};
	chan child_Notify1075 = [1] of {int};
	chan child_Notify1074 = [1] of {int};
	chan child_Notify1073 = [1] of {int};
	chan child_Notify1072 = [1] of {int};
	chan child_Notify1071 = [1] of {int};
	chan child_Notify1070 = [1] of {int};
	Mutexdef r_lock;
	Mutexdef __m_mu;
	run mutexMonitor(__m_mu);
	run mutexMonitor(r_lock);
	run Notify107(r_lock,child_Notify1070);
	child_Notify1070?0;
	run Notify107(r_lock,child_Notify1071);
	child_Notify1071?0;
	run Notify107(r_lock,child_Notify1072);
	child_Notify1072?0;
	run Notify107(r_lock,child_Notify1073);
	child_Notify1073?0;
	run Notify107(r_lock,child_Notify1074);
	child_Notify1074?0;
	run Notify107(r_lock,child_Notify1075);
	child_Notify1075?0;
	run Notify107(r_lock,child_Notify1076);
	child_Notify1076?0;
	run Notify107(r_lock,child_Notify1077);
	child_Notify1077?0;
	run Notify107(r_lock,child_Notify1078);
	child_Notify1078?0;
	stop_process: skip;
	child!0
}
proctype Notify107(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_lock.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
		r_lock.Unlock!false;
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

