// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/valyala/fasthttp/blob/19fcd408632d6dae8425ae95c6c62a25c823ff81/fs_example_test.go#L9
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ExampleFS90 = [1] of {int};
	run ExampleFS9(child_ExampleFS90);
	run receiver(child_ExampleFS90)
stop_process:skip
}

proctype ExampleFS9(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewRequestHandler3550 = [1] of {int};
	Mutexdef fs_once_m;
	run mutexMonitor(fs_once_m);
	run NewRequestHandler355(fs_once_m,child_NewRequestHandler3550);
	child_NewRequestHandler3550?0;
	stop_process: skip;
	child!0
}
proctype NewRequestHandler355(Mutexdef fs_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

