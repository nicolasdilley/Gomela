// num_comm_params=2
// num_mand_comm_params=1
// num_opt_comm_params=1

// git_link=https://github.com/elastic/beats/blob//libbeat/cfgfile/list_test.go#L197
#define not_found_201  -2 // opt configs line 54
#define def_var_r_copyRunnerList132  ?? // mand r.copyRunnerList() line 132
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStopAll1970 = [1] of {int};
	run TestStopAll197(child_TestStopAll1970);
	run receiver(child_TestStopAll1970)
stop_process:skip
}

proctype TestStopAll197(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_copyRunnerList1663 = [1] of {int};
	chan child_Stop1212 = [1] of {int};
	chan child_copyRunnerList1661 = [1] of {int};
	chan child_Reload540 = [1] of {int};
	Mutexdef list_mutex;
	int var_list_runners = -2; // opt var_list_runners
	run mutexMonitor(list_mutex);
	run Reload54(list_mutex,not_found_201,child_Reload540);
	child_Reload540?0;
	run copyRunnerList166(list_mutex,child_copyRunnerList1661);
	child_copyRunnerList1661?0;
	run Stop121(list_mutex,child_Stop1212);
	child_Stop1212?0;
	run copyRunnerList166(list_mutex,child_copyRunnerList1663);
	child_copyRunnerList1663?0;
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
proctype Stop121(Mutexdef r_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousStop1381382 = [1] of {int};
	Wgdef wg;
	int var_r_copyRunnerList = def_var_r_copyRunnerList132; // mand var_r_copyRunnerList
	r_mutex.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. var_r_copyRunnerList-1) {
		for50: skip;
		wg.update!1;
		run AnonymousStop138138(wg,r_mutex,child_AnonymousStop1381382);
		run receiver(child_AnonymousStop1381382);
		for50_end: skip
	};
	for50_exit: skip;
	wg.wait?0;
		defer1: skip;
	r_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype AnonymousStop138138(Wgdef wg;Mutexdef r_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

