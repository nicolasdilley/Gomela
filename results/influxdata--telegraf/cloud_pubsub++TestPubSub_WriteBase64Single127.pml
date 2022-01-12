// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/outputs/cloud_pubsub/pubsub_test.go#L127
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPubSub_WriteBase64Single1270 = [1] of {int};
	run TestPubSub_WriteBase64Single127(child_TestPubSub_WriteBase64Single1270);
	run receiver(child_TestPubSub_WriteBase64Single1270)
stop_process:skip
}

proctype TestPubSub_WriteBase64Single127(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef topic_bLock;
	Wgdef topic_bundler_curFlush;
	Wgdef topic_bundler_tail_flush;
	Wgdef topic_bundler_head_flush;
	Wgdef topic_bundler_curBundle_flush;
	Mutexdef topic_bundler_semOnce_m;
	Mutexdef topic_bundler_sem_mu;
	Mutexdef topic_bundler_mu;
	Mutexdef topic_pLock;
	int var_testMetrics = -2; // opt var_testMetrics
	run mutexMonitor(topic_pLock);
	run mutexMonitor(topic_bundler_mu);
	run mutexMonitor(topic_bundler_sem_mu);
	run mutexMonitor(topic_bundler_semOnce_m);
	run wgMonitor(topic_bundler_curBundle_flush);
	run wgMonitor(topic_bundler_head_flush);
	run wgMonitor(topic_bundler_tail_flush);
	run wgMonitor(topic_bundler_curFlush);
	run mutexMonitor(topic_bLock);
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

