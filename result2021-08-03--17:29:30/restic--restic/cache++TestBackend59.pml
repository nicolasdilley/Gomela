// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/restic/restic/blob/be6fc02c044f144f54779d9b0ed02f73df45a5eb/internal/cache/backend_test.go#L59
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBackend590 = [1] of {int};
	run TestBackend59(child_TestBackend590);
	run receiver(child_TestBackend590)
stop_process:skip
}

proctype TestBackend59(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_loadAndCompare193 = [1] of {int};
	chan child_loadAndCompare192 = [1] of {int};
	chan child_save341 = [1] of {int};
	chan child_Wrap2550 = [1] of {int};
	Mutexdef be_m;
	run mutexMonitor(be_m);
	run Wrap255(be_m,child_Wrap2550);
	child_Wrap2550?0;
	run save34(be_m,child_save341);
	child_save341?0;
	run loadAndCompare19(be_m,child_loadAndCompare192);
	child_loadAndCompare192?0;
	run loadAndCompare19(be_m,child_loadAndCompare193);
	child_loadAndCompare193?0;
	stop_process: skip;
	child!0
}
proctype Wrap255(Mutexdef be_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newBackend270 = [1] of {int};
	run newBackend27(be_m,child_newBackend270);
	child_newBackend270?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newBackend27(Mutexdef be_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype save34(Mutexdef be_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype loadAndCompare19(Mutexdef be_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_LoadAll142 = [1] of {int};
	run LoadAll14(be_m,child_LoadAll142);
	child_LoadAll142?0;
	stop_process: skip;
	child!0
}
proctype LoadAll14(Mutexdef be_m;chan child) {
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

