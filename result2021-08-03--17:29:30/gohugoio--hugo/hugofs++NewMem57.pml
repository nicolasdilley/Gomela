// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gohugoio/hugo/blob/64f88f3011de5a510d8e6d6bad8ac4a091b11c0c/hugofs/fs.go#L57
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewMem570 = [1] of {int};
	run NewMem57(child_NewMem570);
	run receiver(child_NewMem570)
stop_process:skip
}

proctype NewMem57(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newFs690 = [1] of {int};
	Mutexdef fs_init_m;
	Mutexdef fs_mu;
	run mutexMonitor(fs_mu);
	run mutexMonitor(fs_init_m);
	run newFs69(fs_init_m,fs_mu,child_newFs690);
	child_newFs690?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newFs69(Mutexdef base_init_m;Mutexdef base_mu;chan child) {
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

