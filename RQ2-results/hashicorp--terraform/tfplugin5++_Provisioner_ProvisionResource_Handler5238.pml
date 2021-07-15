
// https://github.com/hashicorp/terraform/blob/master/internal/tfplugin5/tfplugin5.pb.go#L5238
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child__Provisioner_ProvisionResource_Handler52380 = [1] of {int};
	run _Provisioner_ProvisionResource_Handler5238(child__Provisioner_ProvisionResource_Handler52380)
stop_process:skip
}

proctype _Provisioner_ProvisionResource_Handler5238(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef m_Connection_state_atomicMessageInfo_initMu;
	Mutexdef m_Config_state_atomicMessageInfo_initMu;
	Mutexdef m_state_atomicMessageInfo_initMu;
	run mutexMonitor(m_state_atomicMessageInfo_initMu);
	run mutexMonitor(m_Config_state_atomicMessageInfo_initMu);
	run mutexMonitor(m_Connection_state_atomicMessageInfo_initMu);
	

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

