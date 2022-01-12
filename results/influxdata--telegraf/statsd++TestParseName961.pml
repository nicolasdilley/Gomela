// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/statsd/statsd_test.go#L961
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
	chan child_TestParseName9610 = [1] of {int};
	run TestParseName961(child_TestParseName9610);
	run receiver(child_TestParseName9610)
stop_process:skip
}

proctype TestParseName961(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_parseName7482 = [1] of {int};
	chan child_parseName7483 = [1] of {int};
	chan child_parseName7480 = [1] of {int};
	chan child_parseName7481 = [1] of {int};
	Wgdef s_wg;
	Mutexdef s_cleanup;
	int var_tests = -2; // opt var_tests
	run mutexMonitor(s_cleanup);
	run wgMonitor(s_wg);
	

	if
	:: var_tests-1 != -3 -> 
				for(i : 0.. var_tests-1) {
			for10: skip;
			run parseName748(s_wg,s_cleanup,child_parseName7480);
			child_parseName7480?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			run parseName748(s_wg,s_cleanup,child_parseName7481);
			child_parseName7481?0;
			for13_end: skip
		:: true -> 
			break
		od;
		for13_exit: skip
	fi;
	

	if
	:: var_tests-1 != -3 -> 
				for(i : 0.. var_tests-1) {
			for20: skip;
			run parseName748(s_wg,s_cleanup,child_parseName7482);
			child_parseName7482?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			run parseName748(s_wg,s_cleanup,child_parseName7483);
			child_parseName7483?0;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype parseName748(Wgdef s_wg;Mutexdef s_cleanup;chan child) {
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

