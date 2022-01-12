// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/collection/fifo_test.go#L27
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTakeTooMany270 = [1] of {int};
	run TestTakeTooMany27(child_TestTakeTooMany270);
	run receiver(child_TestTakeTooMany270)
stop_process:skip
}

proctype TestTakeTooMany27(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Take525 = [1] of {int};
	chan child_Empty244 = [1] of {int};
	chan child_Take522 = [1] of {int};
	chan child_Take523 = [1] of {int};
	chan child_Put330 = [1] of {int};
	chan child_Put331 = [1] of {int};
	Mutexdef queue_lock;
	int var_elements = -2; // opt var_elements
	run mutexMonitor(queue_lock);
	

	if
	:: var_elements-1 != -3 -> 
				for(i : 0.. var_elements-1) {
			for10: skip;
			run Put33(queue_lock,child_Put330);
			child_Put330?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run Put33(queue_lock,child_Put331);
			child_Put331?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	

	if
	:: var_elements-1 != -3 -> 
				for(i : 0.. var_elements-1) {
			for20: skip;
			run Take52(queue_lock,child_Take522);
			child_Take522?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			run Take52(queue_lock,child_Take523);
			child_Take523?0;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	run Empty24(queue_lock,child_Empty244);
	child_Empty244?0;
	run Take52(queue_lock,child_Take525);
	child_Take525?0;
	stop_process: skip;
	child!0
}
proctype Put33(Mutexdef q_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	q_lock.Lock!false;
		defer1: skip;
	q_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Take52(Mutexdef q_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	q_lock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	q_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Empty24(Mutexdef q_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	q_lock.Lock!false;
	q_lock.Unlock!false;
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

