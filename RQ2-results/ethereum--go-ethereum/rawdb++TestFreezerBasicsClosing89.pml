
// https://github.com/ethereum/go-ethereum/blob/master/core/rawdb/freezer_table_test.go#L89
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFreezerBasicsClosing890 = [1] of {int};
	run TestFreezerBasicsClosing89(child_TestFreezerBasicsClosing890)
stop_process:skip
}

proctype TestFreezerBasicsClosing89(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close3974 = [1] of {int};
	chan child_Close3978 = [1] of {int};
	chan child_Retrieve5647 = [1] of {int};
	chan child_Close3976 = [1] of {int};
	chan child_Retrieve5645 = [1] of {int};
	chan child_Close3973 = [1] of {int};
	chan child_Append4672 = [1] of {int};
	chan child_Close3971 = [1] of {int};
	chan child_Append4670 = [1] of {int};
	Mutexdef f_lock;
	run mutexMonitor(f_lock);
	

	if
	:: 0 != -2 && 255-1 != -3 -> 
				for(i : 0.. 255-1) {
			for13: skip;
			run Append467(f_lock,child_Append4672);
			child_Append4672?0;
			run Close397(f_lock,child_Close3973);
			child_Close3973?0;
			for13_end: skip
		};
		for13_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Append467(f_lock,child_Append4670);
			child_Append4670?0;
			run Close397(f_lock,child_Close3971);
			child_Close3971?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: 0 != -2 && 255-1 != -3 -> 
				for(i : 0.. 255-1) {
			for21: skip;
			run Retrieve564(f_lock,child_Retrieve5647);
			child_Retrieve5647?0;
			run Close397(f_lock,child_Close3978);
			child_Close3978?0;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run Retrieve564(f_lock,child_Retrieve5645);
			child_Retrieve5645?0;
			run Close397(f_lock,child_Close3976);
			child_Close3976?0;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	stop_process: skip;
		run Close397(f_lock,child_Close3974);
	child_Close3974?0;
	child!0
}
proctype Append467(Mutexdef t_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_openFile4212 = [1] of {int};
	chan child_releaseFile4411 = [1] of {int};
	chan child_openFile4210 = [1] of {int};
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
		run openFile421(t_lock,child_openFile4210);
		child_openFile4210?0;
		

		if
		:: true -> 
			t_lock.Unlock!false;
			goto stop_process
		:: true;
		fi;
		run releaseFile441(t_lock,child_releaseFile4411);
		child_releaseFile4411?0;
		run openFile421(t_lock,child_openFile4212);
		child_openFile4212?0;
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
proctype Retrieve564(Mutexdef t_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getBounds5315 = [1] of {int};
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
	run getBounds531(t_lock,child_getBounds5315);
	child_getBounds5315?0;
	

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

