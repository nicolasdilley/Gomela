// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/outputs/cloud_pubsub/pubsub.go#L179
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_refreshTopic1790 = [1] of {int};
	run refreshTopic179(child_refreshTopic1790);
	run receiver(child_refreshTopic1790)
stop_process:skip
}

proctype refreshTopic179(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef t_scheduler_keysMu;
	Mutexdef t_scheduler_outstanding_mu;
	Mutexdef t_scheduler_bundlers_mu;
	Mutexdef t_scheduler_mu;
	Mutexdef t_mu;
	

	if
	:: true -> 
		run mutexMonitor(t_mu);
		run mutexMonitor(t_scheduler_mu);
		run mutexMonitor(t_scheduler_bundlers_mu);
		run mutexMonitor(t_scheduler_outstanding_mu);
		run mutexMonitor(t_scheduler_keysMu)
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

