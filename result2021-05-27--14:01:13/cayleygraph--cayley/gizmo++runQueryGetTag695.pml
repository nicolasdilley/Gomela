// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/cayleygraph/cayley/blob/2d53d0ab1147d1464f6a83509a0ac21750f02bd4/query/gizmo/gizmo_test.go#L695
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_runQueryGetTag6950 = [1] of {int};
	run runQueryGetTag695(child_runQueryGetTag6950);
	run receiver(child_runQueryGetTag6950)
stop_process:skip
}

proctype runQueryGetTag695(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Execute2820 = [1] of {int};
	Mutexdef js_sch_rulesForTypeMu;
	Mutexdef js_ns_mu;
	run mutexMonitor(js_ns_mu);
	run mutexMonitor(js_sch_rulesForTypeMu);
	run Execute282(js_ns_mu,js_sch_rulesForTypeMu,child_Execute2820);
	child_Execute2820?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
		stop_process: skip;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype Execute282(Mutexdef s_ns_mu;Mutexdef s_sch_rulesForTypeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_compile2580 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	fi;
	run compile258(s_ns_mu,s_sch_rulesForTypeMu,child_compile2580);
	child_compile2580?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype compile258(Mutexdef s_ns_mu;Mutexdef s_sch_rulesForTypeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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

