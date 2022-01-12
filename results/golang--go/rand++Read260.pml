// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//math/rand/rand.go#L260
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Read2600 = [1] of {int};
	run Read260(child_Read2600);
	run receiver(child_Read2600)
stop_process:skip
}

proctype Read260(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_read4160 = [1] of {int};
	Mutexdef lk_lk;
	run mutexMonitor(lk_lk);
	

	if
	:: true -> 
		run read416(lk_lk,child_read4160);
		child_read4160?0;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype read416(Mutexdef r_lk;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_lk.Lock!false;
	r_lk.Unlock!false;
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

