
// https://github.com/valyala/fasthttp/blob/master/client_test.go#L587
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestClientHeaderCase5870 = [1] of {int};
	run TestClientHeaderCase587(child_TestClientHeaderCase5870)
stop_process:skip
}

proctype TestClientHeaderCase587(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close5920 = [1] of {int};
	chan child_Get3102 = [1] of {int};
	Mutexdef c_mLock;
	Mutexdef c_TLSConfig_mutex;
	chan child_AnonymousTestClientHeaderCase5935901 = [1] of {int};
	Mutexdef ln_lock;
	run mutexMonitor(ln_lock);
	run AnonymousTestClientHeaderCase593590(ln_lock,child_AnonymousTestClientHeaderCase5935901);
	run mutexMonitor(c_TLSConfig_mutex);
	run mutexMonitor(c_mLock);
	run Get310(c_TLSConfig_mutex,c_mLock,child_Get3102);
	child_Get3102?0;
	stop_process: skip;
		run Close592(ln_lock,child_Close5920);
	child_Close5920?0;
	child!0
}
proctype Close592(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ff_bigFilesLock;
	Mutexdef ff_h_cacheLock;
	

	if
	:: true -> 
		run mutexMonitor(ff_h_cacheLock);
		run mutexMonitor(ff_bigFilesLock);
		ff_bigFilesLock.Lock!false;
		ff_bigFilesLock.Unlock!false
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousTestClientHeaderCase593590(Mutexdef ln_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Accept14681 = [1] of {int};
	run Accept1468(ln_lock,child_Accept14681);
	child_Accept14681?0;
	stop_process: skip;
	child!0
}
proctype Accept1468(Mutexdef ln_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Get310(Mutexdef c_TLSConfig_mutex;Mutexdef c_mLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_clientGetURL8412 = [1] of {int};
	run clientGetURL841(c_TLSConfig_mutex,c_mLock,child_clientGetURL8412);
	child_clientGetURL8412?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype clientGetURL841(Mutexdef c_TLSConfig_mutex;Mutexdef c_mLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_doRequestFollowRedirectsBuffer9662 = [1] of {int};
	run doRequestFollowRedirectsBuffer966(c_TLSConfig_mutex,c_mLock,child_doRequestFollowRedirectsBuffer9662);
	child_doRequestFollowRedirectsBuffer9662?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype doRequestFollowRedirectsBuffer966(Mutexdef c_TLSConfig_mutex;Mutexdef c_mLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_doRequestFollowRedirects9832 = [1] of {int};
	run doRequestFollowRedirects983(c_TLSConfig_mutex,c_mLock,child_doRequestFollowRedirects9832);
	child_doRequestFollowRedirects9832?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype doRequestFollowRedirects983(Mutexdef c_TLSConfig_mutex;Mutexdef c_mLock;chan child) {
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

