// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/restic/restic/blob/be6fc02c044f144f54779d9b0ed02f73df45a5eb/internal/repository/index_test.go#L256
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestIndexUnserialize2560 = [1] of {int};
	run TestIndexUnserialize256(child_TestIndexUnserialize2560);
	run receiver(child_TestIndexUnserialize2560)
stop_process:skip
}

proctype TestIndexUnserialize256(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ListPack1923 = [1] of {int};
	chan child_Supersedes2312 = [1] of {int};
	chan child_Lookup1800 = [1] of {int};
	chan child_Lookup1801 = [1] of {int};
	Mutexdef idx_m;
	int var_blobs = -2; // opt var_blobs
	int var_exampleTests = -2; // opt var_exampleTests
	run mutexMonitor(idx_m);
	

	if
	:: var_exampleTests-1 != -3 -> 
				for(i : 0.. var_exampleTests-1) {
			for10: skip;
			run Lookup180(idx_m,child_Lookup1800);
			child_Lookup1800?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run Lookup180(idx_m,child_Lookup1801);
			child_Lookup1801?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	run Supersedes231(idx_m,child_Supersedes2312);
	child_Supersedes2312?0;
	run ListPack192(idx_m,child_ListPack1923);
	child_ListPack1923?0;
	stop_process: skip;
	child!0
}
proctype Lookup180(Mutexdef idx_m;chan child) {
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
proctype Supersedes231(Mutexdef idx_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ListPack192(Mutexdef idx_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_idx_byType = -2; // opt var_idx_byType
	idx_m.Lock!false;
	goto defer1;
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

