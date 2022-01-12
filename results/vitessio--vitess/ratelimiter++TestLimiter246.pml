// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/ratelimiter/ratelimiter_test.go#L46
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLimiter2460 = [1] of {int};
	run TestLimiter246(child_TestLimiter2460);
	run receiver(child_TestLimiter2460)
stop_process:skip
}

proctype TestLimiter246(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Allow535 = [1] of {int};
	chan child_Allow534 = [1] of {int};
	chan child_Allow533 = [1] of {int};
	chan child_Allow532 = [1] of {int};
	chan child_Allow531 = [1] of {int};
	chan child_Allow530 = [1] of {int};
	Mutexdef rl_mu;
	run mutexMonitor(rl_mu);
	

	if
	:: 0 != -2 && 2-1 != -3 -> 
				for(i : 0.. 2-1) {
			for11: skip;
			run Allow53(rl_mu,child_Allow531);
			child_Allow531?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Allow53(rl_mu,child_Allow530);
			child_Allow530?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run Allow53(rl_mu,child_Allow532);
	child_Allow532?0;
	

	if
	:: 0 != -2 && 2-1 != -3 -> 
				for(i : 0.. 2-1) {
			for21: skip;
			run Allow53(rl_mu,child_Allow534);
			child_Allow534?0;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run Allow53(rl_mu,child_Allow533);
			child_Allow533?0;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	run Allow53(rl_mu,child_Allow535);
	child_Allow535?0;
	stop_process: skip;
	child!0
}
proctype Allow53(Mutexdef rl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	rl_mu.Lock!false;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi;
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	rl_mu.Unlock!false;
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

