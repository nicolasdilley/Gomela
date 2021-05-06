
// https://github.com/hashicorp/terraform/blob/master/states/statemgr/filesystem_test.go#L147
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFilesystem_backup1470 = [1] of {int};
	run TestFilesystem_backup147(child_TestFilesystem_backup1470)
stop_process:skip
}

proctype TestFilesystem_backup147(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TestFull221 = [1] of {int};
	chan child_SetBackupPath990 = [1] of {int};
	Mutexdef ls_mu;
	run mutexMonitor(ls_mu);
	run SetBackupPath99(ls_mu,child_SetBackupPath990);
	child_SetBackupPath990?0;
	run TestFull22(ls_mu,child_TestFull221);
	child_TestFull221?0;
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
proctype TestFull22(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_State11215 = [1] of {int};
	chan child_State11214 = [1] of {int};
	chan child_State11213 = [1] of {int};
	chan child_State11212 = [1] of {int};
	chan child_PersistState22611 = [1] of {int};
	chan child_WriteState12210 = [1] of {int};
	chan child_PersistState2269 = [1] of {int};
	chan child_WriteState1228 = [1] of {int};
	chan child_RefreshState2317 = [1] of {int};
	chan child_PersistState2266 = [1] of {int};
	chan child_State1125 = [1] of {int};
	chan child_WriteState1224 = [1] of {int};
	chan child_State1123 = [1] of {int};
	chan child_State1122 = [1] of {int};
	chan child_RefreshState2311 = [1] of {int};
	run RefreshState231(s_mu,child_RefreshState2311);
	child_RefreshState2311?0;
	run State112(s_mu,child_State1122);
	child_State1122?0;
	run State112(s_mu,child_State1123);
	child_State1123?0;
	run WriteState122(s_mu,child_WriteState1224);
	child_WriteState1224?0;
	run State112(s_mu,child_State1125);
	child_State1125?0;
	run PersistState226(s_mu,child_PersistState2266);
	child_PersistState2266?0;
	run RefreshState231(s_mu,child_RefreshState2317);
	child_RefreshState2317?0;
	run WriteState122(s_mu,child_WriteState1228);
	child_WriteState1228?0;
	run PersistState226(s_mu,child_PersistState2269);
	child_PersistState2269?0;
	run WriteState122(s_mu,child_WriteState12210);
	child_WriteState12210?0;
	run PersistState226(s_mu,child_PersistState22611);
	child_PersistState22611?0;
	run State112(s_mu,child_State11212);
	child_State11212?0;
	run State112(s_mu,child_State11213);
	child_State11213?0;
	run State112(s_mu,child_State11214);
	child_State11214?0;
	

	if
	:: true -> 
		run State112(s_mu,child_State11215);
		child_State11215?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype RefreshState231(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_refreshState2361 = [1] of {int};
	run refreshState236(s_mu,child_refreshState2361);
	child_refreshState2361?0;
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
proctype State112(Mutexdef s_mu;chan child) {
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
proctype WriteState122(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_writeState1395 = [1] of {int};
	chan child_refreshState2364 = [1] of {int};
	

	if
	:: true -> 
		run refreshState236(s_mu,child_refreshState2364);
		child_refreshState2364?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run writeState139(s_mu,child_writeState1395);
	child_writeState1395?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype writeState139(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_createStateFiles4335 = [1] of {int};
	

	if
	:: true -> 
		run createStateFiles433(s_mu,child_createStateFiles4335);
		child_createStateFiles4335?0;
		

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
proctype PersistState226(Mutexdef s_mu;chan child) {
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

