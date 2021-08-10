// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/restic/restic/blob/be6fc02c044f144f54779d9b0ed02f73df45a5eb/internal/restic/hardlinks_index_test.go#L11
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHardLinks110 = [1] of {int};
	run TestHardLinks11(child_TestHardLinks110);
	run receiver(child_TestHardLinks110)
stop_process:skip
}

proctype TestHardLinks11(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Has267 = [1] of {int};
	chan child_Remove536 = [1] of {int};
	chan child_Has265 = [1] of {int};
	chan child_Has264 = [1] of {int};
	chan child_GetFilename463 = [1] of {int};
	chan child_GetFilename462 = [1] of {int};
	chan child_Add351 = [1] of {int};
	chan child_Add350 = [1] of {int};
	Mutexdef idx_m;
	run mutexMonitor(idx_m);
	run Add35(idx_m,child_Add350);
	child_Add350?0;
	run Add35(idx_m,child_Add351);
	child_Add351?0;
	run GetFilename46(idx_m,child_GetFilename462);
	child_GetFilename462?0;
	run GetFilename46(idx_m,child_GetFilename463);
	child_GetFilename463?0;
	run Has26(idx_m,child_Has264);
	child_Has264?0;
	run Has26(idx_m,child_Has265);
	child_Has265?0;
	run Remove53(idx_m,child_Remove536);
	child_Remove536?0;
	run Has26(idx_m,child_Has267);
	child_Has267?0;
	stop_process: skip;
	child!0
}
proctype Add35(Mutexdef idx_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	idx_m.Lock!false;
		defer1: skip;
	idx_m.Unlock!false;
	stop_process: skip;
	child!0
}
proctype GetFilename46(Mutexdef idx_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	idx_m.Lock!false;
	goto defer1;
		defer1: skip;
	idx_m.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Has26(Mutexdef idx_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	idx_m.Lock!false;
	goto defer1;
		defer1: skip;
	idx_m.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Remove53(Mutexdef idx_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	idx_m.Lock!false;
		defer1: skip;
	idx_m.Unlock!false;
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

