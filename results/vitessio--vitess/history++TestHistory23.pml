// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/history/history_test.go#L23
#define ub_for27_2  -2
#define ub_for41_2  -2
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHistory230 = [1] of {int};
	run TestHistory23(child_TestHistory230);
	run receiver(child_TestHistory230)
stop_process:skip
}

proctype TestHistory23(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Records765 = [1] of {int};
	chan child_Add524 = [1] of {int};
	chan child_Add523 = [1] of {int};
	chan child_Records762 = [1] of {int};
	chan child_Add521 = [1] of {int};
	chan child_Add520 = [1] of {int};
	Mutexdef q_mu;
	int var_records = -2; // opt var_records
	run mutexMonitor(q_mu);
	

	if
	:: 0 != -2 && ub_for27_2 != -2 -> 
				for(i : 0.. ub_for27_2) {
			for11: skip;
			run Add52(q_mu,child_Add521);
			child_Add521?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Add52(q_mu,child_Add520);
			child_Add520?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run Records76(q_mu,child_Records762);
	child_Records762?0;
	

	if
	:: 0 != -2 && ub_for41_2 != -2 -> 
				for(i : 0.. ub_for41_2) {
			for41: skip;
			run Add52(q_mu,child_Add524);
			child_Add524?0;
			for41_end: skip
		};
		for41_exit: skip
	:: else -> 
		do
		:: true -> 
			for40: skip;
			run Add52(q_mu,child_Add523);
			child_Add523?0;
			for40_end: skip
		:: true -> 
			break
		od;
		for40_exit: skip
	fi;
	run Records76(q_mu,child_Records765);
	child_Records765?0;
	stop_process: skip;
	child!0
}
proctype Add52(Mutexdef history_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	history_mu.Lock!false;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	:: true;
	fi;
		defer1: skip;
	history_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Records76(Mutexdef history_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_history_length = -2; // opt var_history_length
	history_mu.Lock!false;
	goto defer1;
		defer1: skip;
	history_mu.Unlock!false;
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

