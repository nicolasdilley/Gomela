
// https://github.com/hashicorp/vault/blob/master/serviceregistration/consul/consul_service_registration_test.go#L358
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConsul_serviceTags3580 = [1] of {int};
	run TestConsul_serviceTags358(child_TestConsul_serviceTags3580)
stop_process:skip
}

proctype TestConsul_serviceTags358(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fetchServiceTags5210 = [1] of {int};
	chan child_fetchServiceTags5211 = [1] of {int};
	Mutexdef c_serviceLock;
	Mutexdef c_Client_config_Transport_nextProtoOnce_m;
	Mutexdef c_Client_config_Transport_TLSClientConfig_mutex;
	Mutexdef c_Client_config_Transport_connsPerHostMu;
	Mutexdef c_Client_config_Transport_altMu;
	Mutexdef c_Client_config_Transport_reqMu;
	Mutexdef c_Client_config_Transport_idleMu;
	int tests = -2;
	run mutexMonitor(c_Client_config_Transport_idleMu);
	run mutexMonitor(c_Client_config_Transport_reqMu);
	run mutexMonitor(c_Client_config_Transport_altMu);
	run mutexMonitor(c_Client_config_Transport_connsPerHostMu);
	run mutexMonitor(c_Client_config_Transport_TLSClientConfig_mutex);
	run mutexMonitor(c_Client_config_Transport_nextProtoOnce_m);
	run mutexMonitor(c_serviceLock);
	

	if
	:: tests-1 != -3 -> 
				for(i : 0.. tests-1) {
			for10: skip;
			run fetchServiceTags521(c_Client_config_Transport_idleMu,c_Client_config_Transport_reqMu,c_Client_config_Transport_altMu,c_Client_config_Transport_connsPerHostMu,c_Client_config_Transport_TLSClientConfig_mutex,c_Client_config_Transport_nextProtoOnce_m,c_serviceLock,child_fetchServiceTags5210);
			child_fetchServiceTags5210?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run fetchServiceTags521(c_Client_config_Transport_idleMu,c_Client_config_Transport_reqMu,c_Client_config_Transport_altMu,c_Client_config_Transport_connsPerHostMu,c_Client_config_Transport_TLSClientConfig_mutex,c_Client_config_Transport_nextProtoOnce_m,c_serviceLock,child_fetchServiceTags5211);
			child_fetchServiceTags5211?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype fetchServiceTags521(Mutexdef c_Client_config_Transport_idleMu;Mutexdef c_Client_config_Transport_reqMu;Mutexdef c_Client_config_Transport_altMu;Mutexdef c_Client_config_Transport_connsPerHostMu;Mutexdef c_Client_config_Transport_TLSClientConfig_mutex;Mutexdef c_Client_config_Transport_nextProtoOnce_m;Mutexdef c_serviceLock;chan child) {
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

