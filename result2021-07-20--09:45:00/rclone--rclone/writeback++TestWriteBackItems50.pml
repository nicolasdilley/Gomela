// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/rclone/rclone/blob/6ef7178ee4465f2361b6e2cf483cef5bbfd9c95c/vfs/vfscache/writeback/writeback_test.go#L50
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestWriteBackItems500 = [1] of {int};
	run TestWriteBackItems50(child_TestWriteBackItems500);
	run receiver(child_TestWriteBackItems500)
stop_process:skip
}

proctype TestWriteBackItems50(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_string276 = [1] of {int};
	chan child_string275 = [1] of {int};
	chan child_string274 = [1] of {int};
	chan child_string273 = [1] of {int};
	chan child_string272 = [1] of {int};
	chan child_string271 = [1] of {int};
	chan child_string270 = [1] of {int};
	Mutexdef wb_mu;
	run mutexMonitor(wb_mu);
	run string27(wb_mu,child_string270);
	child_string270?0;
	run string27(wb_mu,child_string271);
	child_string271?0;
	run string27(wb_mu,child_string272);
	child_string272?0;
	run string27(wb_mu,child_string273);
	child_string273?0;
	run string27(wb_mu,child_string274);
	child_string274?0;
	run string27(wb_mu,child_string275);
	child_string275?0;
	run string27(wb_mu,child_string276);
	child_string276?0;
	stop_process: skip;
	child!0
}
proctype string27(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_wsCopywsCopy = -2; // opt var_wsCopywsCopy
	int var_wsws = -2; // opt var_wsws
	wb_mu.Lock!false;
	goto defer1;
		defer1: skip;
	wb_mu.Unlock!false;
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

