// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/asim/go-micro/blob/1b5d372b5be58353cfbc227bd4a65dd4e885b779/transport/http_transport.go#L595
#define var_opts  -2 // opt opts line 595
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewHTTPTransport5950 = [1] of {int};
	run NewHTTPTransport595(var_opts,child_NewHTTPTransport5950);
	run receiver(child_NewHTTPTransport5950)
stop_process:skip
}

proctype NewHTTPTransport595(int opts;chan child) {
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

proctype receiver(chan c) {
c?0
}

