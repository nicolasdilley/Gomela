
// https://github.com/hashicorp/vault/blob/master/builtin/logical/transit/path_export_test.go#L328
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTransit_Export_EncryptionKey_DoesNotExportHMACKey3280 = [1] of {int};
	run TestTransit_Export_EncryptionKey_DoesNotExportHMACKey328(child_TestTransit_Export_EncryptionKey_DoesNotExportHMACKey3280)
stop_process:skip
}

proctype TestTransit_Export_EncryptionKey_DoesNotExportHMACKey328(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef hmacKeyRsp_Auth_Alias_state_atomicMessageInfo_initMu;
	Mutexdef encryptionKeyRsp_Auth_Alias_state_atomicMessageInfo_initMu;
	Mutexdef __Auth_Alias_state_atomicMessageInfo_initMu;
	Mutexdef req_Auth_Alias_state_atomicMessageInfo_initMu;
	run mutexMonitor(req_Auth_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(__Auth_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(encryptionKeyRsp_Auth_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(hmacKeyRsp_Auth_Alias_state_atomicMessageInfo_initMu);
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

