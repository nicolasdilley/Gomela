// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/consul/blob/8d6cbe72813779f60ac24d119cc311c21003f4ce/logging/gated_writer_test.go#L13
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGatedWriter130 = [1] of {int};
	run TestGatedWriter13(child_TestGatedWriter130);
	run receiver(child_TestGatedWriter130)
stop_process:skip
}

proctype TestGatedWriter13(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Write313 = [1] of {int};
	chan child_Flush202 = [1] of {int};
	chan child_Write311 = [1] of {int};
	chan child_Write310 = [1] of {int};
	Mutexdef w_lock;
	run mutexMonitor(w_lock);
	run Write31(w_lock,child_Write310);
	child_Write310?0;
	run Write31(w_lock,child_Write311);
	child_Write311?0;
	run Flush20(w_lock,child_Flush202);
	child_Flush202?0;
	run Write31(w_lock,child_Write313);
	child_Write313?0;
	stop_process: skip;
	child!0
}
proctype Write31(Mutexdef w_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	w_lock.RLock!false;
	

	if
	:: true -> 
		w_lock.RUnlock!false;
		goto stop_process
	:: true;
	fi;
	w_lock.RUnlock!false;
	w_lock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	w_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Flush20(Mutexdef w_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Write312 = [1] of {int};
	chan child_Write313 = [1] of {int};
	int var_w_buf = -2; // opt var_w_buf
	w_lock.Lock!false;
	w_lock.Unlock!false;
	

	if
	:: var_w_buf-1 != -3 -> 
				for(i : 0.. var_w_buf-1) {
			for10: skip;
			run Write31(w_lock,child_Write312);
			child_Write312?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run Write31(w_lock,child_Write313);
			child_Write313?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
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

