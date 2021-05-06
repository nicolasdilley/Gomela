
// https://github.com/gohugoio/hugo/blob/master/hugofs/fs.go#L57
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewMem570 = [1] of {int};
	run NewMem57(child_NewMem570)
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
	run newFs69(fs_mu,fs_init_m,child_newFs690);
	child_newFs690?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newFs69(Mutexdef base_mu;Mutexdef base_init_m;chan child) {
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

