// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kops/blob/e3fbc2ad043e58cfdcf934e015ef8d5d9e42273e/util/pkg/vfs/vaultfs_test.go#L45
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test_newVaultPath450 = [1] of {int};
	run Test_newVaultPath45(child_Test_newVaultPath450);
	run receiver(child_Test_newVaultPath450)
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
	Mutexdef vaultPath_vaultClient_modifyLock;
	Mutexdef client_config_modifyLock;
	Mutexdef client_modifyLock;
	run mutexMonitor(client_modifyLock);
	run mutexMonitor(client_config_modifyLock);
	run mutexMonitor(vaultPath_vaultClient_modifyLock);
	run newVaultPath42(client_config_modifyLock,client_modifyLock,child_newVaultPath420);
	child_newVaultPath420?0;
	run metadataPath225(vaultPath_vaultClient_modifyLock,child_metadataPath2251);
	child_metadataPath2251?0;
	run dataPath221(vaultPath_vaultClient_modifyLock,child_dataPath2212);
	child_dataPath2212?0;
	run Path137(vaultPath_vaultClient_modifyLock,child_Path1373);
	child_Path1373?0;
	stop_process: skip;
	child!0
}
proctype newVaultPath42(Mutexdef client_config_modifyLock;Mutexdef client_modifyLock;chan child) {
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
proctype metadataPath225(Mutexdef p_vaultClient_modifyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype dataPath221(Mutexdef p_vaultClient_modifyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Path137(Mutexdef p_vaultClient_modifyLock;chan child) {
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
