// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/rclone/rclone/blob/6ef7178ee4465f2361b6e2cf483cef5bbfd9c95c/fs/accounting/stats_groups.go#L184
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_rcResetStats1840 = [1] of {int};
	run rcResetStats184(child_rcResetStats1840);
	run receiver(child_rcResetStats1840)
stop_process:skip
}

proctype rcResetStats184(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ResetCounters5361 = [1] of {int};
	chan child_ResetErrors5550 = [1] of {int};
	Mutexdef stats_inProgress_mu;
	Mutexdef stats_transferring_mu;
	Mutexdef stats_checking_mu;
	Mutexdef stats_mu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run mutexMonitor(stats_mu);
		run mutexMonitor(stats_checking_mu);
		run mutexMonitor(stats_transferring_mu);
		run mutexMonitor(stats_inProgress_mu);
		run ResetErrors555(stats_checking_mu,stats_inProgress_mu,stats_mu,stats_transferring_mu,child_ResetErrors5550);
		child_ResetErrors5550?0;
		run ResetCounters536(stats_checking_mu,stats_inProgress_mu,stats_mu,stats_transferring_mu,child_ResetCounters5361);
		child_ResetCounters5361?0
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ResetErrors555(Mutexdef s_checking_mu;Mutexdef s_inProgress_mu;Mutexdef s_mu;Mutexdef s_transferring_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.Lock!false;
		defer1: skip;
	s_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype ResetCounters536(Mutexdef s_checking_mu;Mutexdef s_inProgress_mu;Mutexdef s_mu;Mutexdef s_transferring_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.Lock!false;
		defer1: skip;
	s_mu.Unlock!false;
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

