// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/rclone/rclone/blob/6ef7178ee4465f2361b6e2cf483cef5bbfd9c95c/fs/rc/jobs/job_test.go#L25
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestJobsKickExpire250 = [1] of {int};
	run TestJobsKickExpire25(child_TestJobsKickExpire250);
	run receiver(child_TestJobsKickExpire250)
stop_process:skip
}

proctype TestJobsKickExpire25(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_kickExpire1310 = [1] of {int};
	Mutexdef jobs_mu;
	run mutexMonitor(jobs_mu);
	run kickExpire131(jobs_mu,child_kickExpire1310);
	child_kickExpire1310?0;
	jobs_mu.Lock!false;
	jobs_mu.Unlock!false;
	jobs_mu.Lock!false;
	jobs_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype kickExpire131(Mutexdef jobs_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	jobs_mu.Lock!false;
		defer1: skip;
	jobs_mu.Unlock!false;
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

