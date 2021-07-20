// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/minio/minio/blob/e948e7cdf65028f7a8545d1a05c2baea75198bd0/pkg/lock/lock_test.go#L67
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRWLockedFile670 = [1] of {int};
	run TestRWLockedFile67(child_TestRWLockedFile670);
	run receiver(child_TestRWLockedFile670)
stop_process:skip
}

proctype TestRWLockedFile67(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close597 = [1] of {int};
	chan child_IsClosed436 = [1] of {int};
	chan child_Close595 = [1] of {int};
	chan child_IsClosed434 = [1] of {int};
	chan child_Close593 = [1] of {int};
	chan child_IsClosed432 = [1] of {int};
	chan child_IncLockRef501 = [1] of {int};
	chan child_IsClosed430 = [1] of {int};
	Mutexdef rlk_mutex;
	run mutexMonitor(rlk_mutex);
	run IsClosed43(rlk_mutex,child_IsClosed430);
	child_IsClosed430?0;
	run IncLockRef50(rlk_mutex,child_IncLockRef501);
	child_IncLockRef501?0;
	run IsClosed43(rlk_mutex,child_IsClosed432);
	child_IsClosed432?0;
	run Close59(rlk_mutex,child_Close593);
	child_Close593?0;
	run IsClosed43(rlk_mutex,child_IsClosed434);
	child_IsClosed434?0;
	run Close59(rlk_mutex,child_Close595);
	child_Close595?0;
	run IsClosed43(rlk_mutex,child_IsClosed436);
	child_IsClosed436?0;
	run Close59(rlk_mutex,child_Close597);
	child_Close597?0;
	stop_process: skip;
	child!0
}
proctype IsClosed43(Mutexdef r_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_mutex.Lock!false;
	goto defer1;
		defer1: skip;
	r_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype IncLockRef50(Mutexdef r_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_mutex.Lock!false;
	r_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Close59(Mutexdef r_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_mutex.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	r_mutex.Unlock!false;
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

