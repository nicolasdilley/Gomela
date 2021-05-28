// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-gitea/gitea/blob/ed393779004335a0afcca0dfac48937db41fabd6/modules/queue/queue_redis.go#L33
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewRedisQueue330 = [1] of {int};
	run NewRedisQueue33(child_NewRedisQueue330);
	run receiver(child_NewRedisQueue330)
stop_process:skip
}

proctype NewRedisQueue33(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IsTerminated1950 = [1] of {int};
	Mutexdef byteFIFOQueue_lock;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(byteFIFOQueue_lock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run IsTerminated195(byteFIFOQueue_lock,child_IsTerminated1950);
	child_IsTerminated1950?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype IsTerminated195(Mutexdef q_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

