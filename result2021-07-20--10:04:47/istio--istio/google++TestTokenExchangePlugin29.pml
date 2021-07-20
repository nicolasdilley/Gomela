// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/security/pkg/stsservice/tokenmanager/google/tokenexchangeplugin_test.go#L29
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTokenExchangePlugin290 = [1] of {int};
	run TestTokenExchangePlugin29(child_TestTokenExchangePlugin290);
	run receiver(child_TestTokenExchangePlugin290)
stop_process:skip
}

proctype TestTokenExchangePlugin29(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DumpPluginStatus4871 = [1] of {int};
	chan child_ExchangeToken1120 = [1] of {int};
	chan child_DumpPluginStatus4873 = [1] of {int};
	chan child_ExchangeToken1122 = [1] of {int};
	Mutexdef ms_mutex;
	Mutexdef ms_server_mu;
	Mutexdef tmPlugin_mutex;
	Mutexdef tmPlugin_tokens_mu;
	int var_testCasestestCases = -2; // opt var_testCasestestCases
	run mutexMonitor(tmPlugin_tokens_mu);
	run mutexMonitor(tmPlugin_mutex);
	run mutexMonitor(ms_server_mu);
	run mutexMonitor(ms_mutex);
	

	if
	:: var_testCases-1 != -3 -> 
				for(i : 0.. var_testCases-1) {
			for10: skip;
			run ExchangeToken112(tmPlugin_mutex,tmPlugin_tokens_mu,child_ExchangeToken1120);
			child_ExchangeToken1120?0;
			run DumpPluginStatus487(tmPlugin_mutex,tmPlugin_tokens_mu,child_DumpPluginStatus4871);
			child_DumpPluginStatus4871?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			run ExchangeToken112(tmPlugin_mutex,tmPlugin_tokens_mu,child_ExchangeToken1122);
			child_ExchangeToken1122?0;
			run DumpPluginStatus487(tmPlugin_mutex,tmPlugin_tokens_mu,child_DumpPluginStatus4873);
			child_DumpPluginStatus4873?0;
			for13_end: skip
		:: true -> 
			break
		od;
		for13_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype ExchangeToken112(Mutexdef p_mutex;Mutexdef p_tokens_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_generateSTSResp4583 = [1] of {int};
	chan child_fetchAccessToken3922 = [1] of {int};
	chan child_fetchFederatedToken2561 = [1] of {int};
	chan child_useCachedToken1300 = [1] of {int};
	run useCachedToken130(p_mutex,p_tokens_mu,child_useCachedToken1300);
	child_useCachedToken1300?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run fetchFederatedToken256(p_mutex,p_tokens_mu,child_fetchFederatedToken2561);
	child_fetchFederatedToken2561?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run fetchAccessToken392(p_mutex,p_tokens_mu,child_fetchAccessToken3922);
	child_fetchAccessToken3922?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run generateSTSResp458(p_mutex,p_tokens_mu,child_generateSTSResp4583);
	child_generateSTSResp4583?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype useCachedToken130(Mutexdef p_mutex;Mutexdef p_tokens_mu;chan child) {
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
		run generateSTSRespInner471(p_mutex,p_tokens_mu,child_generateSTSRespInner4710);
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
proctype generateSTSRespInner471(Mutexdef p_mutex;Mutexdef p_tokens_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype fetchFederatedToken256(Mutexdef p_mutex;Mutexdef p_tokens_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_sendRequestWithRetry3112 = [1] of {int};
	chan child_constructFederatedTokenRequest2081 = [1] of {int};
	run constructFederatedTokenRequest208(p_mutex,p_tokens_mu,child_constructFederatedTokenRequest2081);
	child_constructFederatedTokenRequest2081?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sendRequestWithRetry311(p_mutex,p_tokens_mu,child_sendRequestWithRetry3112);
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
proctype constructFederatedTokenRequest208(Mutexdef p_mutex;Mutexdef p_tokens_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_constructAudience1641 = [1] of {int};
	run constructAudience164(p_mutex,p_tokens_mu,child_constructAudience1641);
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
proctype constructAudience164(Mutexdef p_mutex;Mutexdef p_tokens_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype sendRequestWithRetry311(Mutexdef p_mutex;Mutexdef p_tokens_mu;chan child) {
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
proctype fetchAccessToken392(Mutexdef p_mutex;Mutexdef p_tokens_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_sendRequestWithRetry3113 = [1] of {int};
	chan child_constructGenerateAccessTokenRequest3652 = [1] of {int};
	run constructGenerateAccessTokenRequest365(p_mutex,p_tokens_mu,child_constructGenerateAccessTokenRequest3652);
	child_constructGenerateAccessTokenRequest3652?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sendRequestWithRetry311(p_mutex,p_tokens_mu,child_sendRequestWithRetry3113);
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
proctype constructGenerateAccessTokenRequest365(Mutexdef p_mutex;Mutexdef p_tokens_mu;chan child) {
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
proctype generateSTSResp458(Mutexdef p_mutex;Mutexdef p_tokens_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_generateSTSRespInner4713 = [1] of {int};
	run generateSTSRespInner471(p_mutex,p_tokens_mu,child_generateSTSRespInner4713);
	child_generateSTSRespInner4713?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DumpPluginStatus487(Mutexdef p_mutex;Mutexdef p_tokens_mu;chan child) {
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

proctype receiver(chan c) {
c?0
}

