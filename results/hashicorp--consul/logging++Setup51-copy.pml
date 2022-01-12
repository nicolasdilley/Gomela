// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/consul/blob//logging/logger.go#L51
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Setup510 = [1] of {int};
	run Setup51(child_Setup510);
	run receiver(child_Setup510)
stop_process:skip
}

proctype Setup51(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_openNew591 = [1] of {int};
	chan child_pruneFiles930 = [1] of {int};
	Mutexdef logFile_acquire;
	int var_retries = -2; // opt var_retries
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run mutexMonitor(logFile_acquire);
		run pruneFiles93(logFile_acquire,child_pruneFiles930);
		child_pruneFiles930?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run openNew59(logFile_acquire,child_openNew591);
		child_openNew591?0;
		

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
proctype pruneFiles93(Mutexdef l_acquire;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fileNamePattern480 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run fileNamePattern48(l_acquire,child_fileNamePattern480);
	child_fileNamePattern480?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype fileNamePattern48(Mutexdef l_acquire;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype openNew59(Mutexdef l_acquire;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fileNamePattern481 = [1] of {int};
	run fileNamePattern48(l_acquire,child_fileNamePattern481);
	child_fileNamePattern481?0;
	

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

