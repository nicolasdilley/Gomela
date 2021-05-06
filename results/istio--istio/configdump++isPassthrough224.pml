
// https://github.com/istio/istio/blob/master/istioctl/pkg/writer/envoy/configdump/route.go#L224
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_isPassthrough2240 = [1] of {int};
	run isPassthrough224(child_isPassthrough2240)
stop_process:skip
}

proctype isPassthrough224(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef a_Route_HiddenEnvoyDeprecatedRequestMirrorPolicy_TraceSampled_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_HiddenEnvoyDeprecatedRequestMirrorPolicy_RuntimeFraction_DefaultValue_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_HiddenEnvoyDeprecatedRequestMirrorPolicy_RuntimeFraction_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_HiddenEnvoyDeprecatedRequestMirrorPolicy_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_MaxStreamDuration_GrpcTimeoutHeaderOffset_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_MaxStreamDuration_GrpcTimeoutHeaderMax_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_MaxStreamDuration_MaxStreamDuration_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_MaxStreamDuration_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_HedgePolicy_AdditionalRequestChance_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_HedgePolicy_InitialRequests_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_HedgePolicy_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_MaxInternalRedirects_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_InternalRedirectPolicy_MaxInternalRedirects_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_InternalRedirectPolicy_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_GrpcTimeoutOffset_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_MaxGrpcTimeout_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_Cors_ShadowEnabled_DefaultValue_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_Cors_ShadowEnabled_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_Cors_AllowCredentials_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_Cors_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_IncludeVhRateLimits_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_RetryPolicyTypedConfig_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_RetryPolicy_RateLimitedRetryBackOff_MaxInterval_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_RetryPolicy_RateLimitedRetryBackOff_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_RetryPolicy_RetryBackOff_MaxInterval_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_RetryPolicy_RetryBackOff_BaseInterval_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_RetryPolicy_RetryBackOff_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_RetryPolicy_RetryPriority_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_RetryPolicy_PerTryTimeout_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_RetryPolicy_NumRetries_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_RetryPolicy_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_IdleTimeout_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_Timeout_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_RegexRewrite_Pattern_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_RegexRewrite_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_MetadataMatch_state_atomicMessageInfo_initMu;
	Mutexdef a_Route_state_atomicMessageInfo_initMu;
	run mutexMonitor(a_Route_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_MetadataMatch_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_RegexRewrite_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_RegexRewrite_Pattern_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_Timeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_IdleTimeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_RetryPolicy_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_RetryPolicy_NumRetries_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_RetryPolicy_PerTryTimeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_RetryPolicy_RetryPriority_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_RetryPolicy_RetryBackOff_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_RetryPolicy_RetryBackOff_BaseInterval_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_RetryPolicy_RetryBackOff_MaxInterval_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_RetryPolicy_RateLimitedRetryBackOff_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_RetryPolicy_RateLimitedRetryBackOff_MaxInterval_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_RetryPolicyTypedConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_IncludeVhRateLimits_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_Cors_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_Cors_AllowCredentials_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_Cors_ShadowEnabled_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_Cors_ShadowEnabled_DefaultValue_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_MaxGrpcTimeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_GrpcTimeoutOffset_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_InternalRedirectPolicy_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_InternalRedirectPolicy_MaxInternalRedirects_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_MaxInternalRedirects_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_HedgePolicy_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_HedgePolicy_InitialRequests_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_HedgePolicy_AdditionalRequestChance_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_MaxStreamDuration_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_MaxStreamDuration_MaxStreamDuration_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_MaxStreamDuration_GrpcTimeoutHeaderMax_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_MaxStreamDuration_GrpcTimeoutHeaderOffset_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_HiddenEnvoyDeprecatedRequestMirrorPolicy_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_HiddenEnvoyDeprecatedRequestMirrorPolicy_RuntimeFraction_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_HiddenEnvoyDeprecatedRequestMirrorPolicy_RuntimeFraction_DefaultValue_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Route_HiddenEnvoyDeprecatedRequestMirrorPolicy_TraceSampled_state_atomicMessageInfo_initMu);
	

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

