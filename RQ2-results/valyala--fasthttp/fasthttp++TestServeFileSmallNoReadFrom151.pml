
// https://github.com/valyala/fasthttp/blob/master/fs_test.go#L151
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestServeFileSmallNoReadFrom1510 = [1] of {int};
	run TestServeFileSmallNoReadFrom151(child_TestServeFileSmallNoReadFrom1510)
stop_process:skip
}

proctype TestServeFileSmallNoReadFrom151(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WriteTo6541 = [1] of {int};
	Mutexdef reader_ff_bigFilesLock;
	Mutexdef reader_ff_h_cacheLock;
	chan child_Init25430 = [1] of {int};
	Mutexdef ctx_s_mu;
	Mutexdef ctx_s_perIPConnCounter_lock;
	Mutexdef ctx_s_tlsConfig_mutex;
	run mutexMonitor(ctx_s_tlsConfig_mutex);
	run mutexMonitor(ctx_s_perIPConnCounter_lock);
	run mutexMonitor(ctx_s_mu);
	run Init2543(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_Init25430);
	child_Init25430?0;
	run mutexMonitor(reader_ff_h_cacheLock);
	run mutexMonitor(reader_ff_bigFilesLock);
	run WriteTo654(reader_ff_h_cacheLock,reader_ff_bigFilesLock,child_WriteTo6541);
	child_WriteTo6541?0;
	stop_process: skip;
	child!0
}
proctype Init2543(Mutexdef ctx_s_tlsConfig_mutex;Mutexdef ctx_s_perIPConnCounter_lock;Mutexdef ctx_s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Init225250 = [1] of {int};
	run Init22525(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_Init225250);
	child_Init225250?0;
	stop_process: skip;
	child!0
}
proctype Init22525(Mutexdef ctx_s_tlsConfig_mutex;Mutexdef ctx_s_perIPConnCounter_lock;Mutexdef ctx_s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype WriteTo654(Mutexdef r_ff_h_cacheLock;Mutexdef r_ff_bigFilesLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ff_bigFilesLock;
	Mutexdef ff_h_cacheLock;
	run mutexMonitor(ff_h_cacheLock);
	run mutexMonitor(ff_bigFilesLock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

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

