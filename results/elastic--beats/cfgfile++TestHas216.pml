// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/elastic/beats/blob//libbeat/cfgfile/list_test.go#L216
#define not_found_226  -2 // opt configs line 54
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHas2160 = [1] of {int};
	run TestHas216(child_TestHas2160);
	run receiver(child_TestHas2160)
stop_process:skip
}

proctype TestHas216(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Has1502 = [1] of {int};
	chan child_Has1501 = [1] of {int};
	chan child_Reload540 = [1] of {int};
	Mutexdef list_mutex;
	run mutexMonitor(list_mutex);
	run Reload54(list_mutex,not_found_226,child_Reload540);
	child_Reload540?0;
	run Has150(list_mutex,child_Has1501);
	child_Has1501?0;
	run Has150(list_mutex,child_Has1502);
	child_Has1502?0;
	stop_process: skip;
	child!0
}
proctype Reload54(Mutexdef r_mutex;int var_configs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_copyRunnerList1660 = [1] of {int};
	int var_startList = -2; // opt var_startList
	int var_stopList = -2; // opt var_stopList
	r_mutex.Lock!false;
	run copyRunnerList166(r_mutex,child_copyRunnerList1660);
	child_copyRunnerList1660?0;
	goto defer1;
		defer1: skip;
	r_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype copyRunnerList166(Mutexdef r_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_r_runners = -2; // opt var_r_runners
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Has150(Mutexdef r_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_mutex.RLock!false;
	goto defer1;
		defer1: skip;
	r_mutex.RUnlock!false;
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

