#define opts256  -2

// https://github.com/asim/go-micro/blob/master/transport/memory.go#L256
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewMemoryTransport2560 = [1] of {int};
	run NewMemoryTransport256(opts256,child_NewMemoryTransport2560)
stop_process:skip
}

proctype NewMemoryTransport256(int opts;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef options_TLSConfig_mutex;
	run mutexMonitor(options_TLSConfig_mutex);
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

