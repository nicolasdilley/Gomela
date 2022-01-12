// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/outputs/cloud_pubsub/pubsub_test.go#L148
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
	chan child_TestPubSub_Error1480 = [1] of {int};
	run TestPubSub_Error148(child_TestPubSub_Error1480);
	run receiver(child_TestPubSub_Error1480)
stop_process:skip
}

proctype TestPubSub_Error148(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef __bLock;
	Wgdef __bundler_curFlush;
	Wgdef __bundler_tail_flush;
	Wgdef __bundler_head_flush;
	Wgdef __bundler_curBundle_flush;
	Mutexdef __bundler_semOnce_m;
	Mutexdef __bundler_sem_mu;
	Mutexdef __bundler_mu;
	Mutexdef __pLock;
	run mutexMonitor(__pLock);
	run mutexMonitor(__bundler_mu);
	run mutexMonitor(__bundler_sem_mu);
	run mutexMonitor(__bundler_semOnce_m);
	run wgMonitor(__bundler_curBundle_flush);
	run wgMonitor(__bundler_head_flush);
	run wgMonitor(__bundler_tail_flush);
	run wgMonitor(__bundler_curFlush);
	run mutexMonitor(__bLock);
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

