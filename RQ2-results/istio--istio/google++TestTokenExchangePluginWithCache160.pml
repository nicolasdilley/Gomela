
// https://github.com/istio/istio/blob/master/security/pkg/stsservice/tokenmanager/google/tokenexchangeplugin_test.go#L160
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTokenExchangePluginWithCache1600 = [1] of {int};
	run TestTokenExchangePluginWithCache160(child_TestTokenExchangePluginWithCache1600)
stop_process:skip
}

proctype TestTokenExchangePluginWithCache160(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ExchangeToken1124 = [1] of {int};
	chan child_ExchangeToken1123 = [1] of {int};
	chan child_ClearCache5322 = [1] of {int};
	chan child_ExchangeToken1121 = [1] of {int};
	chan child_ExchangeToken1120 = [1] of {int};
	Mutexdef ms_mutex;
	Mutexdef ms_t_context_mu;
	Mutexdef ms_t_context_match_mu;
	Mutexdef ms_server_mu;
	Mutexdef ms_server_nextProtoOnce_m;
	Mutexdef ms_server_ErrorLog_mu;
	Mutexdef ms_server_TLSConfig_mutex;
	Mutexdef tmPlugin_mutex;
	Mutexdef tmPlugin_tokens_mu;
	run mutexMonitor(tmPlugin_tokens_mu);
	run mutexMonitor(tmPlugin_mutex);
	run mutexMonitor(ms_server_TLSConfig_mutex);
	run mutexMonitor(ms_server_ErrorLog_mu);
	run mutexMonitor(ms_server_nextProtoOnce_m);
	run mutexMonitor(ms_server_mu);
	run mutexMonitor(ms_t_context_match_mu);
	run mutexMonitor(ms_t_context_mu);
	run mutexMonitor(ms_mutex);
	run ExchangeToken112(tmPlugin_tokens_mu,tmPlugin_mutex,child_ExchangeToken1120);
	child_ExchangeToken1120?0;
	run ExchangeToken112(tmPlugin_tokens_mu,tmPlugin_mutex,child_ExchangeToken1121);
	child_ExchangeToken1121?0;
	run ClearCache532(tmPlugin_tokens_mu,tmPlugin_mutex,child_ClearCache5322);
	child_ClearCache5322?0;
	run ExchangeToken112(tmPlugin_tokens_mu,tmPlugin_mutex,child_ExchangeToken1123);
	child_ExchangeToken1123?0;
	run ExchangeToken112(tmPlugin_tokens_mu,tmPlugin_mutex,child_ExchangeToken1124);
	child_ExchangeToken1124?0;
	stop_process: skip;
	child!0
}
proctype ExchangeToken112(Mutexdef p_tokens_mu;Mutexdef p_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_generateSTSResp4583 = [1] of {int};
	chan child_fetchAccessToken3922 = [1] of {int};
	chan child_fetchFederatedToken2561 = [1] of {int};
	chan child_useCachedToken1300 = [1] of {int};
	run useCachedToken130(p_tokens_mu,p_mutex,child_useCachedToken1300);
	child_useCachedToken1300?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run fetchFederatedToken256(p_tokens_mu,p_mutex,child_fetchFederatedToken2561);
	child_fetchFederatedToken2561?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run fetchAccessToken392(p_tokens_mu,p_mutex,child_fetchAccessToken3922);
	child_fetchAccessToken3922?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run generateSTSResp458(p_tokens_mu,p_mutex,child_generateSTSResp4583);
	child_generateSTSResp4583?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype useCachedToken130(Mutexdef p_tokens_mu;Mutexdef p_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_generateSTSRespInner4710 = [1] of {int};
	

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
	p_mutex.Lock!false;
	p_mutex.Unlock!false;
	

	if
	:: true -> 
		run generateSTSRespInner471(p_tokens_mu,p_mutex,child_generateSTSRespInner4710);
		child_generateSTSRespInner4710?0;
		

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
proctype generateSTSRespInner471(Mutexdef p_tokens_mu;Mutexdef p_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype fetchFederatedToken256(Mutexdef p_tokens_mu;Mutexdef p_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_sendRequestWithRetry3112 = [1] of {int};
	chan child_constructFederatedTokenRequest2081 = [1] of {int};
	run constructFederatedTokenRequest208(p_tokens_mu,p_mutex,child_constructFederatedTokenRequest2081);
	child_constructFederatedTokenRequest2081?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sendRequestWithRetry311(p_tokens_mu,p_mutex,child_sendRequestWithRetry3112);
	child_sendRequestWithRetry3112?0;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype constructFederatedTokenRequest208(Mutexdef p_tokens_mu;Mutexdef p_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_constructAudience1641 = [1] of {int};
	run constructAudience164(p_tokens_mu,p_mutex,child_constructAudience1641);
	child_constructAudience1641?0;
	

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
proctype constructAudience164(Mutexdef p_tokens_mu;Mutexdef p_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype sendRequestWithRetry311(Mutexdef p_tokens_mu;Mutexdef p_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype fetchAccessToken392(Mutexdef p_tokens_mu;Mutexdef p_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_sendRequestWithRetry3113 = [1] of {int};
	chan child_constructGenerateAccessTokenRequest3652 = [1] of {int};
	run constructGenerateAccessTokenRequest365(p_tokens_mu,p_mutex,child_constructGenerateAccessTokenRequest3652);
	child_constructGenerateAccessTokenRequest3652?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sendRequestWithRetry311(p_tokens_mu,p_mutex,child_sendRequestWithRetry3113);
	child_sendRequestWithRetry3113?0;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	p_mutex.Lock!false;
	p_mutex.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype constructGenerateAccessTokenRequest365(Mutexdef p_tokens_mu;Mutexdef p_mutex;chan child) {
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
proctype generateSTSResp458(Mutexdef p_tokens_mu;Mutexdef p_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_generateSTSRespInner4713 = [1] of {int};
	run generateSTSRespInner471(p_tokens_mu,p_mutex,child_generateSTSRespInner4713);
	child_generateSTSRespInner4713?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ClearCache532(Mutexdef p_tokens_mu;Mutexdef p_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

