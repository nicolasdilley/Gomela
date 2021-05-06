
// https://github.com/kubernetes/kops/blob/master/util/pkg/vfs/vaultfs_test.go#L133
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test_CreateFile1330 = [1] of {int};
	run Test_CreateFile133(child_Test_CreateFile1330)
stop_process:skip
}

proctype Test_CreateFile133(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CreateFile842 = [1] of {int};
	chan child_CreateFile841 = [1] of {int};
	chan child_newVaultPath420 = [1] of {int};
	Mutexdef p_vaultClient_config_Limiter_mu;
	Mutexdef p_vaultClient_config_modifyLock;
	Mutexdef p_vaultClient_modifyLock;
	Mutexdef client_config_Limiter_mu;
	Mutexdef client_config_modifyLock;
	Mutexdef client_modifyLock;
	run mutexMonitor(client_modifyLock);
	run mutexMonitor(client_config_modifyLock);
	run mutexMonitor(client_config_Limiter_mu);
	run mutexMonitor(p_vaultClient_modifyLock);
	run mutexMonitor(p_vaultClient_config_modifyLock);
	run mutexMonitor(p_vaultClient_config_Limiter_mu);
	run newVaultPath42(client_modifyLock,client_config_modifyLock,client_config_Limiter_mu,child_newVaultPath420);
	child_newVaultPath420?0;
	run CreateFile84(p_vaultClient_modifyLock,p_vaultClient_config_modifyLock,p_vaultClient_config_Limiter_mu,child_CreateFile841);
	child_CreateFile841?0;
	run CreateFile84(p_vaultClient_modifyLock,p_vaultClient_config_modifyLock,p_vaultClient_config_Limiter_mu,child_CreateFile842);
	child_CreateFile842?0;
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
proctype CreateFile84(Mutexdef p_vaultClient_modifyLock;Mutexdef p_vaultClient_config_modifyLock;Mutexdef p_vaultClient_config_Limiter_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WriteFile662 = [1] of {int};
	chan child_ReadFile931 = [1] of {int};
	run ReadFile93(p_vaultClient_modifyLock,p_vaultClient_config_modifyLock,p_vaultClient_config_Limiter_mu,child_ReadFile931);
	child_ReadFile931?0;
	

	if
	:: true -> 
		run WriteFile66(p_vaultClient_modifyLock,p_vaultClient_config_modifyLock,p_vaultClient_config_Limiter_mu,child_WriteFile662);
		child_WriteFile662?0;
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	stop_process: skip;
	child!0
}
proctype ReadFile93(Mutexdef p_vaultClient_modifyLock;Mutexdef p_vaultClient_config_modifyLock;Mutexdef p_vaultClient_config_Limiter_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_dataPath2211 = [1] of {int};
	run dataPath221(p_vaultClient_modifyLock,p_vaultClient_config_modifyLock,p_vaultClient_config_Limiter_mu,child_dataPath2211);
	child_dataPath2211?0;
	

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
proctype dataPath221(Mutexdef p_vaultClient_modifyLock;Mutexdef p_vaultClient_config_modifyLock;Mutexdef p_vaultClient_config_Limiter_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype WriteFile66(Mutexdef p_vaultClient_modifyLock;Mutexdef p_vaultClient_config_modifyLock;Mutexdef p_vaultClient_config_Limiter_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_dataPath2212 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run dataPath221(p_vaultClient_modifyLock,p_vaultClient_config_modifyLock,p_vaultClient_config_Limiter_mu,child_dataPath2212);
	child_dataPath2212?0;
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

