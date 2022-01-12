// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/GoogleContainerTools/skaffold/blob//pkg/skaffold/util/port_test.go#L26
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPortSet260 = [1] of {int};
	run TestPortSet26(child_TestPortSet260);
	run receiver(child_TestPortSet260)
stop_process:skip
}

proctype TestPortSet26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_LoadOrSet533 = [1] of {int};
	chan child_LoadOrSet532 = [1] of {int};
	chan child_LoadOrSet531 = [1] of {int};
	chan child_Set420 = [1] of {int};
	Mutexdef pf_lock;
	run mutexMonitor(pf_lock);
	run Set42(pf_lock,child_Set420);
	child_Set420?0;
	run LoadOrSet53(pf_lock,child_LoadOrSet531);
	child_LoadOrSet531?0;
	run LoadOrSet53(pf_lock,child_LoadOrSet532);
	child_LoadOrSet532?0;
	run LoadOrSet53(pf_lock,child_LoadOrSet533);
	child_LoadOrSet533?0;
	stop_process: skip;
	child!0
}
proctype Set42(Mutexdef f_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	f_lock.Lock!false;
	f_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype LoadOrSet53(Mutexdef f_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	f_lock.Lock!false;
	f_lock.Unlock!false;
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

