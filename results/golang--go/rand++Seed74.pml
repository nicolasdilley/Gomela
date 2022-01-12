// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//math/rand/rand.go#L74
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Seed740 = [1] of {int};
	run Seed74(child_Seed740);
	run receiver(child_Seed740)
stop_process:skip
}

proctype Seed74(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_seedPos4080 = [1] of {int};
	Mutexdef lk_lk;
	run mutexMonitor(lk_lk);
	

	if
	:: true -> 
		run seedPos408(lk_lk,child_seedPos4080);
		child_seedPos4080?0;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype seedPos408(Mutexdef r_lk;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_lk.Lock!false;
	r_lk.Unlock!false;
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

