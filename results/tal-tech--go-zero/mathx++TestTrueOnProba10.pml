// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/mathx/proba_test.go#L10
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTrueOnProba100 = [1] of {int};
	run TestTrueOnProba10(child_TestTrueOnProba100);
	run receiver(child_TestTrueOnProba100)
stop_process:skip
}

proctype TestTrueOnProba10(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TrueOnProba241 = [1] of {int};
	chan child_TrueOnProba240 = [1] of {int};
	Mutexdef p_lock;
	run mutexMonitor(p_lock);
	

	if
	:: 0 != -2 && 100000-1 != -3 -> 
				for(i : 0.. 100000-1) {
			for11: skip;
			run TrueOnProba24(p_lock,child_TrueOnProba241);
			child_TrueOnProba241?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run TrueOnProba24(p_lock,child_TrueOnProba240);
			child_TrueOnProba240?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype TrueOnProba24(Mutexdef p_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	p_lock.Lock!false;
	p_lock.Unlock!false;
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

