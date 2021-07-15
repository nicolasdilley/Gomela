
// https://github.com/gin-gonic/gin/blob/master/context_test.go#L1395
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextClientIP13950 = [1] of {int};
	run TestContextClientIP1395(child_TestContextClientIP13950)
stop_process:skip
}

proctype TestContextClientIP1395(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ClientIP73331 = [1] of {int};
	chan child_ClientIP73330 = [1] of {int};
	chan child_ClientIP73329 = [1] of {int};
	chan child_ClientIP73328 = [1] of {int};
	chan child_resetTrustedCIDRs139127 = [1] of {int};
	chan child_ClientIP73326 = [1] of {int};
	chan child_resetTrustedCIDRs139125 = [1] of {int};
	chan child_ClientIP73324 = [1] of {int};
	chan child_resetTrustedCIDRs139123 = [1] of {int};
	chan child_ClientIP73322 = [1] of {int};
	chan child_resetTrustedCIDRs139121 = [1] of {int};
	chan child_ClientIP73320 = [1] of {int};
	chan child_resetTrustedCIDRs139119 = [1] of {int};
	chan child_ClientIP73318 = [1] of {int};
	chan child_resetTrustedCIDRs139117 = [1] of {int};
	chan child_ClientIP73316 = [1] of {int};
	chan child_resetTrustedCIDRs139115 = [1] of {int};
	chan child_ClientIP73314 = [1] of {int};
	chan child_resetTrustedCIDRs139113 = [1] of {int};
	chan child_ClientIP73312 = [1] of {int};
	chan child_resetTrustedCIDRs139111 = [1] of {int};
	chan child_ClientIP73310 = [1] of {int};
	chan child_resetTrustedCIDRs13919 = [1] of {int};
	chan child_resetContextForClientIPTests14948 = [1] of {int};
	chan child_ClientIP7337 = [1] of {int};
	chan child_ClientIP7336 = [1] of {int};
	chan child_ClientIP7335 = [1] of {int};
	chan child_ClientIP7334 = [1] of {int};
	chan child_ClientIP7333 = [1] of {int};
	chan child_ClientIP7332 = [1] of {int};
	chan child_resetContextForClientIPTests14941 = [1] of {int};
	chan child_resetTrustedCIDRs13910 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run resetTrustedCIDRs1391(c_mu,child_resetTrustedCIDRs13910);
	child_resetTrustedCIDRs13910?0;
	run resetContextForClientIPTests1494(c_mu,child_resetContextForClientIPTests14941);
	child_resetContextForClientIPTests14941?0;
	run ClientIP733(c_mu,child_ClientIP7332);
	child_ClientIP7332?0;
	run ClientIP733(c_mu,child_ClientIP7333);
	child_ClientIP7333?0;
	run ClientIP733(c_mu,child_ClientIP7334);
	child_ClientIP7334?0;
	run ClientIP733(c_mu,child_ClientIP7335);
	child_ClientIP7335?0;
	run ClientIP733(c_mu,child_ClientIP7336);
	child_ClientIP7336?0;
	run ClientIP733(c_mu,child_ClientIP7337);
	child_ClientIP7337?0;
	run resetContextForClientIPTests1494(c_mu,child_resetContextForClientIPTests14948);
	child_resetContextForClientIPTests14948?0;
	run resetTrustedCIDRs1391(c_mu,child_resetTrustedCIDRs13919);
	child_resetTrustedCIDRs13919?0;
	run ClientIP733(c_mu,child_ClientIP73310);
	child_ClientIP73310?0;
	run resetTrustedCIDRs1391(c_mu,child_resetTrustedCIDRs139111);
	child_resetTrustedCIDRs139111?0;
	run ClientIP733(c_mu,child_ClientIP73312);
	child_ClientIP73312?0;
	run resetTrustedCIDRs1391(c_mu,child_resetTrustedCIDRs139113);
	child_resetTrustedCIDRs139113?0;
	run ClientIP733(c_mu,child_ClientIP73314);
	child_ClientIP73314?0;
	run resetTrustedCIDRs1391(c_mu,child_resetTrustedCIDRs139115);
	child_resetTrustedCIDRs139115?0;
	run ClientIP733(c_mu,child_ClientIP73316);
	child_ClientIP73316?0;
	run resetTrustedCIDRs1391(c_mu,child_resetTrustedCIDRs139117);
	child_resetTrustedCIDRs139117?0;
	run ClientIP733(c_mu,child_ClientIP73318);
	child_ClientIP73318?0;
	run resetTrustedCIDRs1391(c_mu,child_resetTrustedCIDRs139119);
	child_resetTrustedCIDRs139119?0;
	run ClientIP733(c_mu,child_ClientIP73320);
	child_ClientIP73320?0;
	run resetTrustedCIDRs1391(c_mu,child_resetTrustedCIDRs139121);
	child_resetTrustedCIDRs139121?0;
	run ClientIP733(c_mu,child_ClientIP73322);
	child_ClientIP73322?0;
	run resetTrustedCIDRs1391(c_mu,child_resetTrustedCIDRs139123);
	child_resetTrustedCIDRs139123?0;
	run ClientIP733(c_mu,child_ClientIP73324);
	child_ClientIP73324?0;
	run resetTrustedCIDRs1391(c_mu,child_resetTrustedCIDRs139125);
	child_resetTrustedCIDRs139125?0;
	run ClientIP733(c_mu,child_ClientIP73326);
	child_ClientIP73326?0;
	run resetTrustedCIDRs1391(c_mu,child_resetTrustedCIDRs139127);
	child_resetTrustedCIDRs139127?0;
	run ClientIP733(c_mu,child_ClientIP73328);
	child_ClientIP73328?0;
	run ClientIP733(c_mu,child_ClientIP73329);
	child_ClientIP73329?0;
	run ClientIP733(c_mu,child_ClientIP73330);
	child_ClientIP73330?0;
	run ClientIP733(c_mu,child_ClientIP73331);
	child_ClientIP73331?0;
	stop_process: skip;
	child!0
}
proctype resetTrustedCIDRs1391(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype resetContextForClientIPTests1494(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype ClientIP733(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_requestHeader8194 = [1] of {int};
	chan child_requestHeader8195 = [1] of {int};
	chan child_RemoteIP7603 = [1] of {int};
	chan child_requestHeader8192 = [1] of {int};
	int c_engine_RemoteIPHeaders = -2;
	

	if
	:: true -> 
		run requestHeader819(c_mu,child_requestHeader8192);
		child_requestHeader8192?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run RemoteIP760(c_mu,child_RemoteIP7603);
	child_RemoteIP7603?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: c_engine_RemoteIPHeaders-1 != -3 -> 
						for(i : 0.. c_engine_RemoteIPHeaders-1) {
				for20: skip;
				run requestHeader819(c_mu,child_requestHeader8194);
				child_requestHeader8194?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				for20_end: skip
			};
			for20_exit: skip
		:: else -> 
			do
			:: true -> 
				for21: skip;
				run requestHeader819(c_mu,child_requestHeader8195);
				child_requestHeader8195?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				for21_end: skip
			:: true -> 
				break
			od;
			for21_exit: skip
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype requestHeader819(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype RemoteIP760(Mutexdef c_mu;chan child) {
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

