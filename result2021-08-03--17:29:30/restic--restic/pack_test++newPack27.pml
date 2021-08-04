// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/restic/restic/blob/be6fc02c044f144f54779d9b0ed02f73df45a5eb/internal/pack/pack_test.go#L27
#define def_var_lengths  -2 // opt lengths line 27
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newPack270 = [1] of {int};
	run newPack27(def_var_lengths,child_newPack270);
	run receiver(child_newPack270)
stop_process:skip
}

proctype newPack27(int var_lengths;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Size1253 = [1] of {int};
	chan child_Finalize612 = [1] of {int};
	chan child_Add340 = [1] of {int};
	chan child_Add341 = [1] of {int};
	Mutexdef p_m;
	int var_bufs = -2; // opt var_bufs
	run mutexMonitor(p_m);
	

	if
	:: var_bufs-1 != -3 -> 
				for(i : 0.. var_bufs-1) {
			for20: skip;
			run Add34(p_m,child_Add340);
			child_Add340?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			run Add34(p_m,child_Add341);
			child_Add341?0;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	run Finalize61(p_m,child_Finalize612);
	child_Finalize612?0;
	run Size125(p_m,child_Size1253);
	child_Size1253?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Add34(Mutexdef p_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	p_m.Lock!false;
	goto defer1;
		defer1: skip;
	p_m.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Finalize61(Mutexdef p_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_makeHeader1022 = [1] of {int};
	p_m.Lock!false;
	run makeHeader102(p_m,child_makeHeader1022);
	child_makeHeader1022?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	p_m.Unlock!false;
	stop_process: skip;
	child!0
}
proctype makeHeader102(Mutexdef p_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_p_blobs = -2; // opt var_p_blobs
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Size125(Mutexdef p_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	p_m.Lock!false;
	goto defer1;
		defer1: skip;
	p_m.Unlock!false;
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

