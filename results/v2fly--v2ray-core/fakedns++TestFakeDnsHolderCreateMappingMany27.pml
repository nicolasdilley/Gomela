// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/v2fly/v2ray-core/blob//app/dns/fakedns/fakedns_test.go#L27
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFakeDnsHolderCreateMappingMany270 = [1] of {int};
	run TestFakeDnsHolderCreateMappingMany27(child_TestFakeDnsHolderCreateMappingMany270);
	run receiver(child_TestFakeDnsHolderCreateMappingMany270)
stop_process:skip
}

proctype TestFakeDnsHolderCreateMappingMany27(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetFakeIPForDomain1091 = [1] of {int};
	chan child_GetFakeIPForDomain1090 = [1] of {int};
	Mutexdef fkdns_config_state_atomicMessageInfo_initMu;
	run mutexMonitor(fkdns_config_state_atomicMessageInfo_initMu);
	run GetFakeIPForDomain109(fkdns_config_state_atomicMessageInfo_initMu,child_GetFakeIPForDomain1090);
	child_GetFakeIPForDomain1090?0;
	run GetFakeIPForDomain109(fkdns_config_state_atomicMessageInfo_initMu,child_GetFakeIPForDomain1091);
	child_GetFakeIPForDomain1091?0;
	stop_process: skip;
	child!0
}
proctype GetFakeIPForDomain109(Mutexdef fkdns_config_state_atomicMessageInfo_initMu;chan child) {
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

