
// https://github.com/kubernetes/kops/blob/master/util/pkg/vfs/vaultfs_test.go#L45
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test_newVaultPath450 = [1] of {int};
	run Test_newVaultPath45(child_Test_newVaultPath450)
stop_process:skip
}

proctype Test_newVaultPath45(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Path1373 = [1] of {int};
	chan child_dataPath2212 = [1] of {int};
	chan child_metadataPath2251 = [1] of {int};
	chan child_newVaultPath420 = [1] of {int};
	Mutexdef vaultPath_vaultClient_config_Limiter_mu;
	Mutexdef vaultPath_vaultClient_config_modifyLock;
	Mutexdef vaultPath_vaultClient_modifyLock;
	Mutexdef client_config_Limiter_mu;
	Mutexdef client_config_modifyLock;
	Mutexdef client_modifyLock;
	run mutexMonitor(client_modifyLock);
	run mutexMonitor(client_config_modifyLock);
	run mutexMonitor(client_config_Limiter_mu);
	run mutexMonitor(vaultPath_vaultClient_modifyLock);
	run mutexMonitor(vaultPath_vaultClient_config_modifyLock);
	run mutexMonitor(vaultPath_vaultClient_config_Limiter_mu);
	run newVaultPath42(client_modifyLock,client_config_modifyLock,client_config_Limiter_mu,child_newVaultPath420);
	child_newVaultPath420?0;
	run metadataPath225(vaultPath_vaultClient_modifyLock,vaultPath_vaultClient_config_modifyLock,vaultPath_vaultClient_config_Limiter_mu,child_metadataPath2251);
	child_metadataPath2251?0;
	run dataPath221(vaultPath_vaultClient_modifyLock,vaultPath_vaultClient_config_modifyLock,vaultPath_vaultClient_config_Limiter_mu,child_dataPath2212);
	child_dataPath2212?0;
	run Path137(vaultPath_vaultClient_modifyLock,vaultPath_vaultClient_config_modifyLock,vaultPath_vaultClient_config_Limiter_mu,child_Path1373);
	child_Path1373?0;
	stop_process: skip;
	child!0
}
proctype newVaultPath42(Mutexdef client_modifyLock;Mutexdef client_config_modifyLock;Mutexdef client_config_Limiter_mu;chan child) {
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype metadataPath225(Mutexdef p_vaultClient_modifyLock;Mutexdef p_vaultClient_config_modifyLock;Mutexdef p_vaultClient_config_Limiter_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype dataPath221(Mutexdef p_vaultClient_modifyLock;Mutexdef p_vaultClient_config_modifyLock;Mutexdef p_vaultClient_config_Limiter_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Path137(Mutexdef p_vaultClient_modifyLock;Mutexdef p_vaultClient_config_modifyLock;Mutexdef p_vaultClient_config_Limiter_mu;chan child) {
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

