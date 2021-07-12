// num_comm_params=3
// num_mand_comm_params=0
// num_opt_comm_params=3

// git_link=https://github.com/dgraph-io/dgraph/blob/6b188f254202f9c38b16c4769b672dd0e9d596ac/raftwal/storage_test.go#L351
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTruncateStorage3510 = [1] of {int};
	run TestTruncateStorage351(child_TestTruncateStorage3510);
	run receiver(child_TestTruncateStorage3510)
stop_process:skip
}

proctype TestTruncateStorage351(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_addEntries3384 = [1] of {int};
	chan child_addEntries3383 = [1] of {int};
	chan child_TruncateEntriesUntil3662 = [1] of {int};
	chan child_addEntries3381 = [1] of {int};
	chan child_addEntries3380 = [1] of {int};
	Mutexdef ds_lock;
	int var_numEntriesNewnumEntriesNew = -2; // opt var_numEntriesNewnumEntriesNew
	int var_uint64_0_uint64_0_ = -2; // opt var_uint64_0_uint64_0_
	int var_numEntriesnumEntries = -2; // opt var_numEntriesnumEntries
	run mutexMonitor(ds_lock);
	

	if
	:: 0 != -2 && var_numEntries-1 != -3 -> 
				for(i : 0.. var_numEntries-1) {
			for11: skip;
			run addEntries338(ds_lock,child_addEntries3381);
			child_addEntries3381?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run addEntries338(ds_lock,child_addEntries3380);
			child_addEntries3380?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run TruncateEntriesUntil366(ds_lock,child_TruncateEntriesUntil3662);
	child_TruncateEntriesUntil3662?0;
	

	if
	:: 0 != -2 && var_numEntriesNew-1 != -3 -> 
				for(i : 0.. var_numEntriesNew-1) {
			for41: skip;
			run addEntries338(ds_lock,child_addEntries3384);
			child_addEntries3384?0;
			for41_end: skip
		};
		for41_exit: skip
	:: else -> 
		do
		:: true -> 
			for40: skip;
			run addEntries338(ds_lock,child_addEntries3383);
			child_addEntries3383?0;
			for40_end: skip
		:: true -> 
			break
		od;
		for40_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype addEntries338(Mutexdef w_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_FirstIndex2640 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run FirstIndex264(w_lock,child_FirstIndex2640);
	child_FirstIndex2640?0;
	

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
proctype FirstIndex264(Mutexdef w_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_firstIndex2560 = [1] of {int};
	w_lock.Lock!false;
	run firstIndex256(w_lock,child_firstIndex2560);
	child_firstIndex2560?0;
	goto defer1;
		defer1: skip;
	w_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype firstIndex256(Mutexdef w_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Uint1310 = [1] of {int};
	run Uint131(w_lock,child_Uint1310);
	child_Uint1310?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Uint131(Mutexdef w_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype TruncateEntriesUntil366(Mutexdef w_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

