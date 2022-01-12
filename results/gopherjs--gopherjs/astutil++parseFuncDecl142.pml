// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gopherjs/gopherjs/blob//compiler/astutil/astutil_test.go#L142
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_parseFuncDecl1420 = [1] of {int};
	run parseFuncDecl142(child_parseFuncDecl1420);
	run receiver(child_parseFuncDecl1420)
stop_process:skip
}

proctype parseFuncDecl142(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_parse1330 = [1] of {int};
	Mutexdef fset_last_mutex;
	Mutexdef fset_mutex;
	run mutexMonitor(fset_mutex);
	run mutexMonitor(fset_last_mutex);
	run parse133(fset_last_mutex,fset_mutex,child_parse1330);
	child_parse1330?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype parse133(Mutexdef fset_last_mutex;Mutexdef fset_mutex;chan child) {
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

