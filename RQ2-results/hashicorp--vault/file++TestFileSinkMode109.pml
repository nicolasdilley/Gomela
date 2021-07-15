
// https://github.com/hashicorp/vault/blob/master/command/agent/sink/file/file_sink_test.go#L109
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFileSinkMode1090 = [1] of {int};
	run TestFileSinkMode109(child_TestFileSinkMode1090)
stop_process:skip
}

proctype TestFileSinkMode109(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WriteToken760 = [1] of {int};
	Mutexdef fs_Client_config_Limiter_mu;
	Mutexdef fs_Client_config_modifyLock;
	Mutexdef fs_Client_modifyLock;
	run mutexMonitor(fs_Client_modifyLock);
	run mutexMonitor(fs_Client_config_modifyLock);
	run mutexMonitor(fs_Client_config_Limiter_mu);
	run WriteToken76(fs_Client_modifyLock,fs_Client_config_modifyLock,fs_Client_config_Limiter_mu,child_WriteToken760);
	child_WriteToken760?0;
	stop_process: skip;
	child!0
}
proctype WriteToken76(Mutexdef f_Client_modifyLock;Mutexdef f_Client_config_modifyLock;Mutexdef f_Client_config_Limiter_mu;chan child) {
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
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

