
// https://github.com/valyala/fasthttp/blob/master/fs.go#L333
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_FSHandler3330 = [1] of {int};
	run FSHandler333(child_FSHandler3330)
stop_process:skip
}

proctype FSHandler333(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewRequestHandler3550 = [1] of {int};
	Mutexdef fs_once_m;
	run mutexMonitor(fs_once_m);
	run NewRequestHandler355(fs_once_m,child_NewRequestHandler3550);
	child_NewRequestHandler3550?0;
	goto stop_process;
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

