// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtadmin/vtsql/config_test.go#L36
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfigParse360 = [1] of {int};
	run TestConfigParse36(child_TestConfigParse360);
	run receiver(child_TestConfigParse360)
stop_process:skip
}

proctype TestConfigParse36(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Parse680 = [1] of {int};
	Mutexdef cfg_Cluster_state_atomicMessageInfo_initMu;
	run mutexMonitor(cfg_Cluster_state_atomicMessageInfo_initMu);
	run Parse68(cfg_Cluster_state_atomicMessageInfo_initMu,child_Parse680);
	child_Parse680?0;
	stop_process: skip;
	child!0
}
proctype Parse68(Mutexdef c_Cluster_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_LoadFromTemplate320 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run LoadFromTemplate32(c_Cluster_state_atomicMessageInfo_initMu,child_LoadFromTemplate320);
		child_LoadFromTemplate320?0;
		

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
proctype LoadFromTemplate32(Mutexdef data_Cluster_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_renderTemplate460 = [1] of {int};
	run renderTemplate46(data_Cluster_state_atomicMessageInfo_initMu,child_renderTemplate460);
	child_renderTemplate460?0;
	

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
proctype renderTemplate46(Mutexdef data_Cluster_state_atomicMessageInfo_initMu;chan child) {
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

