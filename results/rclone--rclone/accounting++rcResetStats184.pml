
// https://github.com/rclone/rclone/blob/master/fs/accounting/stats_groups.go#L184
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_rcResetStats1840 = [1] of {int};
	run rcResetStats184(child_rcResetStats1840)
stop_process:skip
}

proctype rcResetStats184(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ResetCounters5351 = [1] of {int};
	chan child_ResetErrors5540 = [1] of {int};
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
		run ResetErrors554(stats_mu,stats_checking_mu,stats_transferring_mu,stats_inProgress_mu,child_ResetErrors5540);
		child_ResetErrors5540?0;
		run ResetCounters535(stats_mu,stats_checking_mu,stats_transferring_mu,stats_inProgress_mu,child_ResetCounters5351);
		child_ResetCounters5351?0
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ResetErrors554(Mutexdef s_mu;Mutexdef s_checking_mu;Mutexdef s_transferring_mu;Mutexdef s_inProgress_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.Lock!false;
	stop_process: skip;
		s_mu.Unlock!false;
	child!0
}
proctype ResetCounters535(Mutexdef s_mu;Mutexdef s_checking_mu;Mutexdef s_transferring_mu;Mutexdef s_inProgress_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.Lock!false;
	stop_process: skip;
		s_mu.Unlock!false;
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

