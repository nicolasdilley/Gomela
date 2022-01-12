// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-redis/redis/blob//example_test.go#L577
#define ub_for579_2  -2
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ExampleScanCmd_Iterator5770 = [1] of {int};
	run ExampleScanCmd_Iterator577(child_ExampleScanCmd_Iterator5770);
	run receiver(child_ExampleScanCmd_Iterator5770)
stop_process:skip
}

proctype ExampleScanCmd_Iterator577(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Err173 = [1] of {int};
	chan child_Val692 = [1] of {int};
	chan child_Val691 = [1] of {int};
	chan child_Next250 = [1] of {int};
	Mutexdef iter_mu;
	run mutexMonitor(iter_mu);
	run Next25(iter_mu,child_Next250);
	child_Next250?0;
	

	if
	:: 0 != -2 && ub_for579_2 != -2 -> 
				for(i : 0.. ub_for579_2) {
			for21: skip;
			run Val69(iter_mu,child_Val692);
			child_Val692?0;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run Val69(iter_mu,child_Val691);
			child_Val691?0;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	run Err17(iter_mu,child_Err173);
	child_Err173?0;
	stop_process: skip;
	child!0
}
proctype Next25(Mutexdef it_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	it_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
		defer1: skip;
	it_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Val69(Mutexdef it_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	it_mu.Lock!false;
	it_mu.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Err17(Mutexdef it_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	it_mu.Lock!false;
	it_mu.Unlock!false;
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

