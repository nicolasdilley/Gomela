
// https://github.com/rclone/rclone/blob/master/lib/bucket/bucket_test.go#L27
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCache270 = [1] of {int};
	run TestCache27(child_TestCache270)
stop_process:skip
}

proctype TestCache27(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Remove12617 = [1] of {int};
	chan child_Remove12616 = [1] of {int};
	chan child_IsDeleted15715 = [1] of {int};
	chan child_Remove12614 = [1] of {int};
	chan child_Remove12613 = [1] of {int};
	chan child_Create8012 = [1] of {int};
	chan child_Create8011 = [1] of {int};
	chan child_Create8010 = [1] of {int};
	chan child_Create809 = [1] of {int};
	chan child_Create808 = [1] of {int};
	chan child_Create807 = [1] of {int};
	chan child_Create806 = [1] of {int};
	chan child_IsDeleted1575 = [1] of {int};
	chan child_MarkOK484 = [1] of {int};
	chan child_MarkDeleted573 = [1] of {int};
	chan child_MarkOK482 = [1] of {int};
	chan child_MarkOK481 = [1] of {int};
	chan child_IsDeleted1570 = [1] of {int};
	Mutexdef c_removeMu;
	Mutexdef c_createMu;
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run mutexMonitor(c_createMu);
	run mutexMonitor(c_removeMu);
	run IsDeleted157(c_mu,c_createMu,c_removeMu,child_IsDeleted1570);
	child_IsDeleted1570?0;
	run MarkOK48(c_mu,c_createMu,c_removeMu,child_MarkOK481);
	child_MarkOK481?0;
	run MarkOK48(c_mu,c_createMu,c_removeMu,child_MarkOK482);
	child_MarkOK482?0;
	run MarkDeleted57(c_mu,c_createMu,c_removeMu,child_MarkDeleted573);
	child_MarkDeleted573?0;
	run MarkOK48(c_mu,c_createMu,c_removeMu,child_MarkOK484);
	child_MarkOK484?0;
	run IsDeleted157(c_mu,c_createMu,c_removeMu,child_IsDeleted1575);
	child_IsDeleted1575?0;
	run Create80(c_mu,c_createMu,c_removeMu,child_Create806);
	child_Create806?0;
	run Create80(c_mu,c_createMu,c_removeMu,child_Create807);
	child_Create807?0;
	run Create80(c_mu,c_createMu,c_removeMu,child_Create808);
	child_Create808?0;
	run Create80(c_mu,c_createMu,c_removeMu,child_Create809);
	child_Create809?0;
	run Create80(c_mu,c_createMu,c_removeMu,child_Create8010);
	child_Create8010?0;
	run Create80(c_mu,c_createMu,c_removeMu,child_Create8011);
	child_Create8011?0;
	run Create80(c_mu,c_createMu,c_removeMu,child_Create8012);
	child_Create8012?0;
	run Remove126(c_mu,c_createMu,c_removeMu,child_Remove12613);
	child_Remove12613?0;
	run Remove126(c_mu,c_createMu,c_removeMu,child_Remove12614);
	child_Remove12614?0;
	run IsDeleted157(c_mu,c_createMu,c_removeMu,child_IsDeleted15715);
	child_IsDeleted15715?0;
	run Remove126(c_mu,c_createMu,c_removeMu,child_Remove12616);
	child_Remove12616?0;
	run Remove126(c_mu,c_createMu,c_removeMu,child_Remove12617);
	child_Remove12617?0;
	stop_process: skip;
	child!0
}
proctype IsDeleted157(Mutexdef c_mu;Mutexdef c_createMu;Mutexdef c_removeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mu.Lock!false;
	c_mu.Unlock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype MarkOK48(Mutexdef c_mu;Mutexdef c_createMu;Mutexdef c_removeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		c_mu.Lock!false;
		c_mu.Unlock!false
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype MarkDeleted57(Mutexdef c_mu;Mutexdef c_createMu;Mutexdef c_removeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		c_mu.Lock!false;
		c_mu.Unlock!false
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype Create80(Mutexdef c_mu;Mutexdef c_createMu;Mutexdef c_removeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	c_createMu.Lock!false;
	c_mu.Lock!false;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	c_mu.Unlock!false;
	c_mu.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		c_mu.Unlock!false;
		c_createMu.Unlock!false;
	child!0
}
proctype Remove126(Mutexdef c_mu;Mutexdef c_createMu;Mutexdef c_removeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	c_removeMu.Lock!false;
	c_mu.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	c_mu.Unlock!false;
	c_mu.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		c_mu.Unlock!false;
		c_removeMu.Unlock!false;
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

