
// https://github.com/hashicorp/terraform/blob/master/states/statemgr/filesystem_test.go#L22
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFilesystem220 = [1] of {int};
	run TestFilesystem22(child_TestFilesystem220)
stop_process:skip
}

proctype TestFilesystem22(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TestFull220 = [1] of {int};
	Mutexdef ls_mu;
	run mutexMonitor(ls_mu);
	run TestFull22(ls_mu,child_TestFull220);
	child_TestFull220?0;
	stop_process: skip;
	child!0
}
proctype TestFull22(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_State11214 = [1] of {int};
	chan child_State11213 = [1] of {int};
	chan child_State11212 = [1] of {int};
	chan child_State11211 = [1] of {int};
	chan child_PersistState22610 = [1] of {int};
	chan child_WriteState1229 = [1] of {int};
	chan child_PersistState2268 = [1] of {int};
	chan child_WriteState1227 = [1] of {int};
	chan child_RefreshState2316 = [1] of {int};
	chan child_PersistState2265 = [1] of {int};
	chan child_State1124 = [1] of {int};
	chan child_WriteState1223 = [1] of {int};
	chan child_State1122 = [1] of {int};
	chan child_State1121 = [1] of {int};
	chan child_RefreshState2310 = [1] of {int};
	run RefreshState231(s_mu,child_RefreshState2310);
	child_RefreshState2310?0;
	run State112(s_mu,child_State1121);
	child_State1121?0;
	run State112(s_mu,child_State1122);
	child_State1122?0;
	run WriteState122(s_mu,child_WriteState1223);
	child_WriteState1223?0;
	run State112(s_mu,child_State1124);
	child_State1124?0;
	run PersistState226(s_mu,child_PersistState2265);
	child_PersistState2265?0;
	run RefreshState231(s_mu,child_RefreshState2316);
	child_RefreshState2316?0;
	run WriteState122(s_mu,child_WriteState1227);
	child_WriteState1227?0;
	run PersistState226(s_mu,child_PersistState2268);
	child_PersistState2268?0;
	run WriteState122(s_mu,child_WriteState1229);
	child_WriteState1229?0;
	run PersistState226(s_mu,child_PersistState22610);
	child_PersistState22610?0;
	run State112(s_mu,child_State11211);
	child_State11211?0;
	run State112(s_mu,child_State11212);
	child_State11212?0;
	run State112(s_mu,child_State11213);
	child_State11213?0;
	

	if
	:: true -> 
		run State112(s_mu,child_State11214);
		child_State11214?0
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
	chan child_refreshState2360 = [1] of {int};
	run refreshState236(s_mu,child_refreshState2360);
	child_refreshState2360?0;
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
	chan child_writeState1394 = [1] of {int};
	chan child_refreshState2363 = [1] of {int};
	

	if
	:: true -> 
		run refreshState236(s_mu,child_refreshState2363);
		child_refreshState2363?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run writeState139(s_mu,child_writeState1394);
	child_writeState1394?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype writeState139(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_createStateFiles4334 = [1] of {int};
	

	if
	:: true -> 
		run createStateFiles433(s_mu,child_createStateFiles4334);
		child_createStateFiles4334?0;
		

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

