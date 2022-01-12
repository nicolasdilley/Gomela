// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//common/flogging/fabenc/formatter_test.go#L206
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
	chan child_TestSequenceFormatter2060 = [1] of {int};
	run TestSequenceFormatter206(child_TestSequenceFormatter2060);
	run receiver(child_TestSequenceFormatter2060)
stop_process:skip
}

proctype TestSequenceFormatter206(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestSequenceFormatter2182180 = [1] of {int};
	Wgdef finished;
	Wgdef ready;
	Mutexdef mutex;
	run mutexMonitor(mutex);
	run wgMonitor(ready);
	ready.update!100;
	run wgMonitor(finished);
	finished.update!100;
		for(i : 0.. 100) {
		for10: skip;
		run AnonymousTestSequenceFormatter218218(ready,finished,mutex,child_AnonymousTestSequenceFormatter2182180);
		run receiver(child_AnonymousTestSequenceFormatter2182180);
		for10_end: skip
	};
	for10_exit: skip;
	finished.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestSequenceFormatter218218(Wgdef ready;Wgdef finished;Mutexdef mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ready.update!-1;
	ready.wait?0;
	mutex.Lock!false;
	mutex.Unlock!false;
	finished.update!-1;
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

