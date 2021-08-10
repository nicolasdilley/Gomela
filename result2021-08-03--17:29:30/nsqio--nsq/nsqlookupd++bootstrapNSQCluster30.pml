// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/nsqio/nsq/blob/a1da1173d3bfa0ea41b73a3b75ec447a32287c52/nsqlookupd/http_test.go#L30
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_bootstrapNSQCluster300 = [1] of {int};
	run bootstrapNSQCluster30(child_bootstrapNSQCluster300);
	run receiver(child_bootstrapNSQCluster300)
stop_process:skip
}

proctype bootstrapNSQCluster30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousbootstrapNSQCluster66620 = [1] of {int};
	Mutexdef nsqd1_tlsConfig_mutex;
	run mutexMonitor(nsqd1_tlsConfig_mutex);
	run AnonymousbootstrapNSQCluster6662(nsqd1_tlsConfig_mutex,child_AnonymousbootstrapNSQCluster66620);
	run receiver(child_AnonymousbootstrapNSQCluster66620);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousbootstrapNSQCluster6662(Mutexdef nsqd1_tlsConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

