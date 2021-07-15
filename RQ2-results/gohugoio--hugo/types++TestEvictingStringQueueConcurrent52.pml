
// https://github.com/gohugoio/hugo/blob/master/common/types/evictingqueue_test.go#L52
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
	chan child_TestEvictingStringQueueConcurrent520 = [1] of {int};
	run TestEvictingStringQueueConcurrent52(child_TestEvictingStringQueueConcurrent520)
stop_process:skip
}

proctype TestEvictingStringQueueConcurrent52(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestEvictingStringQueueConcurrent60530 = [1] of {int};
	Mutexdef queue_mu;
	Wgdef wg;
	run wgMonitor(wg);
	run mutexMonitor(queue_mu);
		for(i : 0.. 100-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestEvictingStringQueueConcurrent6053(wg,queue_mu,child_AnonymousTestEvictingStringQueueConcurrent60530);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestEvictingStringQueueConcurrent6053(Wgdef wg;Mutexdef queue_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PeekAll762 = [1] of {int};
	chan child_Peek631 = [1] of {int};
	chan child_Add380 = [1] of {int};
	run Add38(queue_mu,child_Add380);
	child_Add380?0;
	run Peek63(queue_mu,child_Peek631);
	child_Peek631?0;
	run PeekAll76(queue_mu,child_PeekAll762);
	child_PeekAll762?0;
	stop_process: skip;
		wg.update!-1;
	child!0
}
proctype Add38(Mutexdef q_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	q_mu.Lock!false;
	

	if
	:: true -> 
		q_mu.Unlock!false;
		goto stop_process
	:: true;
	fi;
	q_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Peek63(Mutexdef q_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	q_mu.Lock!false;
	

	if
	:: true -> 
		q_mu.Unlock!false;
		goto stop_process
	:: true;
	fi;
	q_mu.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype PeekAll76(Mutexdef q_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	q_mu.Lock!false;
	q_mu.Unlock!false;
	goto stop_process;
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

