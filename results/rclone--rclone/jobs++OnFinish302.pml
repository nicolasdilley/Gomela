
// https://github.com/rclone/rclone/blob/master/fs/rc/jobs/job.go#L302
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_OnFinish3020 = [1] of {int};
	run OnFinish302(child_OnFinish3020)
stop_process:skip
}

proctype OnFinish302(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_addListener700 = [1] of {int};
	Mutexdef job_mu;
	run mutexMonitor(job_mu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run addListener70(job_mu,child_addListener700);
		child_addListener700?0
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype addListener70(Mutexdef job_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	job_mu.Lock!false;
	stop_process: skip;
		job_mu.Unlock!false;
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

