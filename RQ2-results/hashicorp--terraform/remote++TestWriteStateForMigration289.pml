
// https://github.com/hashicorp/terraform/blob/master/states/remote/state_test.go#L289
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestWriteStateForMigration2890 = [1] of {int};
	run TestWriteStateForMigration289(child_TestWriteStateForMigration2890)
stop_process:skip
}

proctype TestWriteStateForMigration289(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PersistState1424 = [1] of {int};
	chan child_WriteState583 = [1] of {int};
	chan child_WriteStateForMigration712 = [1] of {int};
	chan child_PersistState1427 = [1] of {int};
	chan child_WriteState586 = [1] of {int};
	chan child_WriteStateForMigration715 = [1] of {int};
	chan child_WriteState581 = [1] of {int};
	chan child_RefreshState1010 = [1] of {int};
	Mutexdef mgr_mu;
	int testCases = -2;
	run mutexMonitor(mgr_mu);
	run RefreshState101(mgr_mu,child_RefreshState1010);
	child_RefreshState1010?0;
	run WriteState58(mgr_mu,child_WriteState581);
	child_WriteState581?0;
	

	if
	:: testCases-1 != -3 -> 
				for(i : 0.. testCases-1) {
			for10: skip;
			run WriteStateForMigration71(mgr_mu,child_WriteStateForMigration712);
			child_WriteStateForMigration712?0;
			

			if
			:: true -> 
				goto for10_end
			:: true;
			fi;
			run WriteState58(mgr_mu,child_WriteState583);
			child_WriteState583?0;
			run PersistState142(mgr_mu,child_PersistState1424);
			child_PersistState1424?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run WriteStateForMigration71(mgr_mu,child_WriteStateForMigration715);
			child_WriteStateForMigration715?0;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			run WriteState58(mgr_mu,child_WriteState586);
			child_WriteState586?0;
			run PersistState142(mgr_mu,child_PersistState1427);
			child_PersistState1427?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype RefreshState101(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_refreshState1100 = [1] of {int};
	s_mu.Lock!false;
	run refreshState110(s_mu,child_refreshState1100);
	child_refreshState1100?0;
	goto stop_process;
	stop_process: skip;
		s_mu.Unlock!false;
	child!0
}
proctype refreshState110(Mutexdef s_mu;chan child) {
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
proctype WriteState58(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.Lock!false;
	goto stop_process;
	stop_process: skip;
		s_mu.Unlock!false;
	child!0
}
proctype WriteStateForMigration71(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.Lock!false;
	

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
		s_mu.Unlock!false;
	child!0
}
proctype PersistState142(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_refreshState1104 = [1] of {int};
	s_mu.Lock!false;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		run refreshState110(s_mu,child_refreshState1104);
		child_refreshState1104?0;
		

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
	goto stop_process;
	stop_process: skip;
		s_mu.Unlock!false;
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

