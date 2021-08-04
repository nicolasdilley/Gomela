// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/rclone/rclone/blob/a223b78872dc7a8713ca2aa4596ae3e30c173cdd/fs/rc/jobs/job_test.go#L22
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestJobsKickExpire220 = [1] of {int};
	run TestJobsKickExpire22(child_TestJobsKickExpire220);
	run receiver(child_TestJobsKickExpire220)
stop_process:skip
}

proctype TestJobsKickExpire22(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_kickExpire730 = [1] of {int};
	Mutexdef jobs_mu;
	run mutexMonitor(jobs_mu);
	run kickExpire73(jobs_mu,child_kickExpire730);
	child_kickExpire730?0;
	jobs_mu.Lock!false;
	jobs_mu.Unlock!false;
	jobs_mu.Lock!false;
	jobs_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype kickExpire73(Mutexdef jobs_mu;chan child) {
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

