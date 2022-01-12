// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/outputs/cloud_pubsub/pubsub_test.go#L59
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
	chan child_TestPubSub_WriteMultiple590 = [1] of {int};
	run TestPubSub_WriteMultiple59(child_TestPubSub_WriteMultiple590);
	run receiver(child_TestPubSub_WriteMultiple590)
stop_process:skip
}

proctype TestPubSub_WriteMultiple59(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getBundleCount2140 = [1] of {int};
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
	run getBundleCount214(topic_bundler_curBundle_flush,topic_bundler_curFlush,topic_bundler_head_flush,topic_bundler_tail_flush,topic_bLock,topic_bundler_mu,topic_bundler_sem_mu,topic_bundler_semOnce_m,topic_pLock,child_getBundleCount2140);
	child_getBundleCount2140?0;
	stop_process: skip;
	child!0
}
proctype getBundleCount214(Wgdef t_bundler_curBundle_flush;Wgdef t_bundler_curFlush;Wgdef t_bundler_head_flush;Wgdef t_bundler_tail_flush;Mutexdef t_bLock;Mutexdef t_bundler_mu;Mutexdef t_bundler_sem_mu;Mutexdef t_bundler_semOnce_m;Mutexdef t_pLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	t_bLock.Lock!false;
	goto defer1;
		defer1: skip;
	t_bLock.Unlock!false;
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

