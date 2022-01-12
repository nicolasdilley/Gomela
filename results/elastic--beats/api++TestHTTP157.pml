// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//libbeat/api/server_test.go#L157
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHTTP1570 = [1] of {int};
	run TestHTTP157(child_TestHTTP1570);
	run receiver(child_TestHTTP1570)
stop_process:skip
}

proctype TestHTTP157(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stop711 = [1] of {int};
	chan child_Start610 = [1] of {int};
	Mutexdef s_mux_mu;
	run mutexMonitor(s_mux_mu);
	run Start61(s_mux_mu,child_Start610);
	run receiver(child_Start610);
		defer1: skip;
	run Stop71(s_mux_mu,child_Stop711);
	child_Stop711?0;
	stop_process: skip;
	child!0
}
proctype Start61(Mutexdef s_mux_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousStart63630 = [1] of {int};
	run AnonymousStart6363(s_mux_mu,child_AnonymousStart63630);
	run receiver(child_AnonymousStart63630);
	stop_process: skip;
	child!0
}
proctype AnonymousStart6363(Mutexdef s_mux_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Stop71(Mutexdef s_mux_mu;chan child) {
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

