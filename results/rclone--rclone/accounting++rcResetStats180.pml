// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/rclone/rclone/blob//fs/accounting/stats_groups.go#L180
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_rcResetStats1800 = [1] of {int};
	run rcResetStats180(child_rcResetStats1800);
	run receiver(child_rcResetStats1800)
stop_process:skip
}

proctype rcResetStats180(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ResetCounters4891 = [1] of {int};
	chan child_ResetErrors5080 = [1] of {int};
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
		run ResetErrors508(stats_checking_mu,stats_inProgress_mu,stats_mu,stats_transferring_mu,child_ResetErrors5080);
		child_ResetErrors5080?0;
		run ResetCounters489(stats_checking_mu,stats_inProgress_mu,stats_mu,stats_transferring_mu,child_ResetCounters4891);
		child_ResetCounters4891?0
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ResetErrors508(Mutexdef s_checking_mu;Mutexdef s_inProgress_mu;Mutexdef s_mu;Mutexdef s_transferring_mu;chan child) {
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
proctype ResetCounters489(Mutexdef s_checking_mu;Mutexdef s_inProgress_mu;Mutexdef s_mu;Mutexdef s_transferring_mu;chan child) {
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

