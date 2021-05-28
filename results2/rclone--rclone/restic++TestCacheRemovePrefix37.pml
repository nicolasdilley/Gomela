// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/rclone/rclone/blob/6ef7178ee4465f2361b6e2cf483cef5bbfd9c95c/cmd/serve/restic/cache_test.go#L37
#define not_found_{"a""b""b/1""b/2/3""b/2/4""b/2""c"}3925  -2
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCacheRemovePrefix370 = [1] of {int};
	run TestCacheRemovePrefix37(child_TestCacheRemovePrefix370);
	run receiver(child_TestCacheRemovePrefix370)
stop_process:skip
}

proctype TestCacheRemovePrefix37(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_String126 = [1] of {int};
	chan child_removePrefix555 = [1] of {int};
	chan child_String124 = [1] of {int};
	chan child_removePrefix553 = [1] of {int};
	chan child_String122 = [1] of {int};
	chan child_add350 = [1] of {int};
	chan child_add351 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	

	if
	:: not_found_{"a""b""b/1""b/2/3""b/2/4""b/2""c"}3925-1 != -3 -> 
				for(i : 0.. not_found_{"a""b""b/1""b/2/3""b/2/4""b/2""c"}3925-1) {
			for10: skip;
			run add35(c_mu,child_add350);
			child_add350?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run add35(c_mu,child_add351);
			child_add351?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	run String12(c_mu,child_String122);
	child_String122?0;
	run removePrefix55(c_mu,child_removePrefix553);
	child_removePrefix553?0;
	run String12(c_mu,child_String124);
	child_String124?0;
	run removePrefix55(c_mu,child_removePrefix555);
	child_removePrefix555?0;
	run String12(c_mu,child_String126);
	child_String126?0;
	stop_process: skip;
	child!0
}
proctype add35(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	c_mu.Lock!false;
	c_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype String12(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int c_items = -2; // opt c_items
	c_mu.Lock!false;
	c_mu.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype removePrefix55(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int c_items = -2; // opt c_items
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	c_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
		defer1: skip;
	c_mu.Unlock!false;
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

