
// https://github.com/ethereum/go-ethereum/blob/master/core/rawdb/freezer_table_test.go#L46
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFreezerBasics460 = [1] of {int};
	run TestFreezerBasics46(child_TestFreezerBasics460)
stop_process:skip
}

proctype TestFreezerBasics46(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close3970 = [1] of {int};
	chan child_Retrieve5645 = [1] of {int};
	chan child_Retrieve5644 = [1] of {int};
	chan child_Retrieve5643 = [1] of {int};
	chan child_Append4672 = [1] of {int};
	chan child_Append4671 = [1] of {int};
	Mutexdef f_lock;
	run mutexMonitor(f_lock);
	

	if
	:: 0 != -2 && 255-1 != -3 -> 
				for(i : 0.. 255-1) {
			for21: skip;
			run Append467(f_lock,child_Append4672);
			child_Append4672?0;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run Append467(f_lock,child_Append4671);
			child_Append4671?0;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	

	if
	:: 0 != -2 && 255-1 != -3 -> 
				for(i : 0.. 255-1) {
			for31: skip;
			run Retrieve564(f_lock,child_Retrieve5644);
			child_Retrieve5644?0;
			for31_end: skip
		};
		for31_exit: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			run Retrieve564(f_lock,child_Retrieve5643);
			child_Retrieve5643?0;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	run Retrieve564(f_lock,child_Retrieve5645);
	child_Retrieve5645?0;
	stop_process: skip;
		run Close397(f_lock,child_Close3970);
	child_Close3970?0;
	child!0
}
proctype Close397(Mutexdef t_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	t_lock.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		t_lock.Unlock!false;
	child!0
}
proctype Append467(Mutexdef t_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_openFile4213 = [1] of {int};
	chan child_releaseFile4412 = [1] of {int};
	chan child_openFile4211 = [1] of {int};
	t_lock.RLock!false;
	

	if
	:: true -> 
		t_lock.RUnlock!false;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		t_lock.RUnlock!false;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		t_lock.RUnlock!false;
		t_lock.Lock!false;
		run openFile421(t_lock,child_openFile4211);
		child_openFile4211?0;
		

		if
		:: true -> 
			t_lock.Unlock!false;
			goto stop_process
		:: true;
		fi;
		run releaseFile441(t_lock,child_releaseFile4412);
		child_releaseFile4412?0;
		run openFile421(t_lock,child_openFile4213);
		child_openFile4213?0;
		t_lock.Unlock!false;
		t_lock.RLock!false
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		t_lock.RUnlock!false;
	child!0
}
proctype openFile421(Mutexdef t_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
proctype releaseFile441(Mutexdef t_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Retrieve564(Mutexdef t_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getBounds5313 = [1] of {int};
	t_lock.RLock!false;
	

	if
	:: true -> 
		t_lock.RUnlock!false;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		t_lock.RUnlock!false;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		t_lock.RUnlock!false;
		goto stop_process
	:: true;
	fi;
	run getBounds531(t_lock,child_getBounds5313);
	child_getBounds5313?0;
	

	if
	:: true -> 
		t_lock.RUnlock!false;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		t_lock.RUnlock!false;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		t_lock.RUnlock!false;
		goto stop_process
	:: true;
	fi;
	t_lock.RUnlock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getBounds531(Mutexdef t_lock;chan child) {
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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		goto stop_process
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

