
// https://github.com/hashicorp/terraform/blob/master/states/statemgr/filesystem_test.go#L185
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFilesystem_backupAndReadPath1850 = [1] of {int};
	run TestFilesystem_backupAndReadPath185(child_TestFilesystem_backupAndReadPath1850)
stop_process:skip
}

proctype TestFilesystem_backupAndReadPath185(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WriteState1221 = [1] of {int};
	chan child_SetBackupPath990 = [1] of {int};
	Mutexdef ls_mu;
	run mutexMonitor(ls_mu);
	run SetBackupPath99(ls_mu,child_SetBackupPath990);
	child_SetBackupPath990?0;
	run WriteState122(ls_mu,child_WriteState1221);
	child_WriteState1221?0;
	stop_process: skip;
	child!0
}
proctype SetBackupPath99(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype WriteState122(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_writeState1392 = [1] of {int};
	chan child_refreshState2361 = [1] of {int};
	

	if
	:: true -> 
		run refreshState236(s_mu,child_refreshState2361);
		child_refreshState2361?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run writeState139(s_mu,child_writeState1392);
	child_writeState1392?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype refreshState236(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		

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
proctype writeState139(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_createStateFiles4332 = [1] of {int};
	

	if
	:: true -> 
		run createStateFiles433(s_mu,child_createStateFiles4332);
		child_createStateFiles4332?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	:: true -> 
		

		if
		:: true;
		:: true;
		:: true;
		:: true;
		fi
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
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype createStateFiles433(Mutexdef s_mu;chan child) {
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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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

