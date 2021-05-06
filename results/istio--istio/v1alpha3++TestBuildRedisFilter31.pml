
// https://github.com/istio/istio/blob/master/pilot/pkg/networking/core/v1alpha3/networkfilter_test.go#L31
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBuildRedisFilter310 = [1] of {int};
	run TestBuildRedisFilter31(child_TestBuildRedisFilter310)
stop_process:skip
}

proctype TestBuildRedisFilter31(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef redisProxy_DownstreamAuthUsername_state_atomicMessageInfo_initMu;
	Mutexdef redisProxy_DownstreamAuthPassword_state_atomicMessageInfo_initMu;
	Mutexdef redisProxy_PrefixRoutes_CatchAllRoute_state_atomicMessageInfo_initMu;
	Mutexdef redisProxy_PrefixRoutes_state_atomicMessageInfo_initMu;
	Mutexdef redisProxy_Settings_MaxUpstreamUnknownConnections_state_atomicMessageInfo_initMu;
	Mutexdef redisProxy_Settings_BufferFlushTimeout_state_atomicMessageInfo_initMu;
	Mutexdef redisProxy_Settings_OpTimeout_state_atomicMessageInfo_initMu;
	Mutexdef redisProxy_Settings_state_atomicMessageInfo_initMu;
	Mutexdef redisProxy_state_atomicMessageInfo_initMu;
	Mutexdef config_TypedConfig_state_atomicMessageInfo_initMu;
	Mutexdef redisFilter_state_atomicMessageInfo_initMu;
	run mutexMonitor(redisFilter_state_atomicMessageInfo_initMu);
	run mutexMonitor(config_TypedConfig_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		run mutexMonitor(redisProxy_state_atomicMessageInfo_initMu);
		run mutexMonitor(redisProxy_Settings_state_atomicMessageInfo_initMu);
		run mutexMonitor(redisProxy_Settings_OpTimeout_state_atomicMessageInfo_initMu);
		run mutexMonitor(redisProxy_Settings_BufferFlushTimeout_state_atomicMessageInfo_initMu);
		run mutexMonitor(redisProxy_Settings_MaxUpstreamUnknownConnections_state_atomicMessageInfo_initMu);
		run mutexMonitor(redisProxy_PrefixRoutes_state_atomicMessageInfo_initMu);
		run mutexMonitor(redisProxy_PrefixRoutes_CatchAllRoute_state_atomicMessageInfo_initMu);
		run mutexMonitor(redisProxy_DownstreamAuthPassword_state_atomicMessageInfo_initMu);
		run mutexMonitor(redisProxy_DownstreamAuthUsername_state_atomicMessageInfo_initMu)
	fi;
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

