
// https://github.com/minio/minio/blob/master/pkg/lock/lock_test.go#L66
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRWLockedFile660 = [1] of {int};
	run TestRWLockedFile66(child_TestRWLockedFile660)
stop_process:skip
}

proctype TestRWLockedFile66(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close587 = [1] of {int};
	chan child_IsClosed426 = [1] of {int};
	chan child_Close585 = [1] of {int};
	chan child_IsClosed424 = [1] of {int};
	chan child_Close583 = [1] of {int};
	chan child_IsClosed422 = [1] of {int};
	chan child_IncLockRef491 = [1] of {int};
	chan child_IsClosed420 = [1] of {int};
	Mutexdef rlk_mutex;
	run mutexMonitor(rlk_mutex);
	run IsClosed42(rlk_mutex,child_IsClosed420);
	child_IsClosed420?0;
	run IncLockRef49(rlk_mutex,child_IncLockRef491);
	child_IncLockRef491?0;
	run IsClosed42(rlk_mutex,child_IsClosed422);
	child_IsClosed422?0;
	run Close58(rlk_mutex,child_Close583);
	child_Close583?0;
	run IsClosed42(rlk_mutex,child_IsClosed424);
	child_IsClosed424?0;
	run Close58(rlk_mutex,child_Close585);
	child_Close585?0;
	run IsClosed42(rlk_mutex,child_IsClosed426);
	child_IsClosed426?0;
	run Close58(rlk_mutex,child_Close587);
	child_Close587?0;
	stop_process: skip;
	child!0
}
proctype IsClosed42(Mutexdef r_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_mutex.Lock!false;
	goto stop_process;
	stop_process: skip;
		r_mutex.Unlock!false;
	child!0
}
proctype IncLockRef49(Mutexdef r_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_mutex.Lock!false;
	r_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Close58(Mutexdef r_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_mutex.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		r_mutex.Unlock!false;
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

