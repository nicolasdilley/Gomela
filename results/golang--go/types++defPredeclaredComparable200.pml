// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//go/types/universe.go#L200
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_defPredeclaredComparable2000 = [1] of {int};
	run defPredeclaredComparable200(child_defPredeclaredComparable2000);
	run receiver(child_defPredeclaredComparable2000)
stop_process:skip
}

proctype defPredeclaredComparable200(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewVar2670 = [1] of {int};
	Mutexdef named_check_fset_last_mutex;
	Mutexdef named_check_fset_mutex;
	run mutexMonitor(named_check_fset_mutex);
	run mutexMonitor(named_check_fset_last_mutex);
	run NewVar267(named_check_fset_last_mutex,named_check_fset_mutex,child_NewVar2670);
	child_NewVar2670?0;
	stop_process: skip;
	child!0
}
proctype NewVar267(Mutexdef typ_check_fset_last_mutex;Mutexdef typ_check_fset_mutex;chan child) {
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

