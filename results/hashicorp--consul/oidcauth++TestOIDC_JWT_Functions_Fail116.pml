
// https://github.com/hashicorp/consul/blob/master/internal/go-sso/oidcauth/oidc_test.go#L116
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestOIDC_JWT_Functions_Fail1160 = [1] of {int};
	run TestOIDC_JWT_Functions_Fail116(child_TestOIDC_JWT_Functions_Fail1160)
stop_process:skip
}

proctype TestOIDC_JWT_Functions_Fail116(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ClaimsFromJWT240 = [1] of {int};
	Mutexdef srv_mu;
	Mutexdef srv_httpServer_mu;
	Wgdef srv_httpServer_wg;
	Mutexdef srv_httpServer_Config_mu;
	Mutexdef srv_httpServer_Config_nextProtoOnce_m;
	Mutexdef srv_httpServer_Config_ErrorLog_mu;
	Mutexdef srv_httpServer_Config_TLSConfig_mutex;
	Mutexdef srv_httpServer_TLS_mutex;
	Mutexdef oa_l;
	run mutexMonitor(oa_l);
	run mutexMonitor(srv_httpServer_TLS_mutex);
	run mutexMonitor(srv_httpServer_Config_TLSConfig_mutex);
	run mutexMonitor(srv_httpServer_Config_ErrorLog_mu);
	run mutexMonitor(srv_httpServer_Config_nextProtoOnce_m);
	run mutexMonitor(srv_httpServer_Config_mu);
	run wgMonitor(srv_httpServer_wg);
	run mutexMonitor(srv_httpServer_mu);
	run mutexMonitor(srv_mu);
	run ClaimsFromJWT24(oa_l,child_ClaimsFromJWT240);
	child_ClaimsFromJWT240?0;
	stop_process: skip;
	child!0
}
proctype ClaimsFromJWT24(Mutexdef a_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_extractClaims452 = [1] of {int};
	chan child_verifyVanillaJWT680 = [1] of {int};
	chan child_verifyOIDCToken2071 = [1] of {int};
	

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
		run verifyVanillaJWT68(a_l,child_verifyVanillaJWT680);
		child_verifyVanillaJWT680?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		run verifyOIDCToken207(a_l,child_verifyOIDCToken2071);
		child_verifyOIDCToken2071?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		goto stop_process
	fi;
	run extractClaims45(a_l,child_extractClaims452);
	child_extractClaims452?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype verifyVanillaJWT68(Mutexdef a_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

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
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		goto stop_process
	fi;
	

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
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype verifyOIDCToken207(Mutexdef a_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true;
	:: true;
	:: true -> 
		goto stop_process
	fi;
	

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
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype extractClaims45(Mutexdef a_l;chan child) {
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
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

