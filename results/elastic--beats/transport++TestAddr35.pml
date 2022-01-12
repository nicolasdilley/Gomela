// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//libbeat/common/transport/pipelistener_test.go#L35
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAddr350 = [1] of {int};
	run TestAddr35(child_TestAddr350);
	run receiver(child_TestAddr350)
stop_process:skip
}

proctype TestAddr35(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close500 = [1] of {int};
	chan child_Addr611 = [1] of {int};
	Mutexdef l_closeOnce_m;
	run mutexMonitor(l_closeOnce_m);
	run Addr61(l_closeOnce_m,child_Addr611);
	child_Addr611?0;
		defer1: skip;
	run Close50(l_closeOnce_m,child_Close500);
	child_Close500?0;
	stop_process: skip;
	child!0
}
proctype Close50(Mutexdef l_closeOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Addr61(Mutexdef l_closeOnce_m;chan child) {
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

