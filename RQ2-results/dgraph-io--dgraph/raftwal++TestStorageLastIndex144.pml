
// https://github.com/dgraph-io/dgraph/blob/master/raftwal/storage_test.go#L144
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStorageLastIndex1440 = [1] of {int};
	run TestStorageLastIndex144(child_TestStorageLastIndex1440)
stop_process:skip
}

proctype TestStorageLastIndex144(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_LastIndex2443 = [1] of {int};
	chan child_reset1342 = [1] of {int};
	chan child_LastIndex2441 = [1] of {int};
	chan child_reset1340 = [1] of {int};
	Mutexdef ds_lock;
	run mutexMonitor(ds_lock);
	run reset134(ds_lock,child_reset1340);
	child_reset1340?0;
	run LastIndex244(ds_lock,child_LastIndex2441);
	child_LastIndex2441?0;
	run reset134(ds_lock,child_reset1342);
	child_reset1342?0;
	run LastIndex244(ds_lock,child_LastIndex2443);
	child_LastIndex2443?0;
	stop_process: skip;
	child!0
}
proctype reset134(Mutexdef w_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_addEntries3380 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run addEntries338(w_lock,child_addEntries3380);
	child_addEntries3380?0;
	goto stop_process;
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
	goto stop_process;
	stop_process: skip;
		w_lock.Unlock!false;
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
proctype LastIndex244(Mutexdef w_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	w_lock.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		w_lock.Unlock!false;
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

