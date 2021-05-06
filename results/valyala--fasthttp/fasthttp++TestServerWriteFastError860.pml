
// https://github.com/valyala/fasthttp/blob/master/server_test.go#L860
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestServerWriteFastError8600 = [1] of {int};
	run TestServerWriteFastError860(child_TestServerWriteFastError8600)
stop_process:skip
}

proctype TestServerWriteFastError860(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_writeFastError26580 = [1] of {int};
	Mutexdef s_mu;
	Mutexdef s_perIPConnCounter_lock;
	Mutexdef s_tlsConfig_mutex;
	run mutexMonitor(s_tlsConfig_mutex);
	run mutexMonitor(s_perIPConnCounter_lock);
	run mutexMonitor(s_mu);
	run writeFastError2658(s_tlsConfig_mutex,s_perIPConnCounter_lock,s_mu,child_writeFastError26580);
	child_writeFastError26580?0;
	stop_process: skip;
	child!0
}
proctype writeFastError2658(Mutexdef s_tlsConfig_mutex;Mutexdef s_perIPConnCounter_lock;Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getServerName26430 = [1] of {int};
	

	if
	:: true -> 
		run getServerName2643(s_tlsConfig_mutex,s_perIPConnCounter_lock,s_mu,child_getServerName26430);
		child_getServerName26430?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype getServerName2643(Mutexdef s_tlsConfig_mutex;Mutexdef s_perIPConnCounter_lock;Mutexdef s_mu;chan child) {
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

