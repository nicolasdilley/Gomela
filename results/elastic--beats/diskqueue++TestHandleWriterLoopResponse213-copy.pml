// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//libbeat/publisher/queue/diskqueue/core_loop_test.go#L213
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
	chan child_TestHandleWriterLoopResponse2130 = [1] of {int};
	run TestHandleWriterLoopResponse213(child_TestHandleWriterLoopResponse2130);
	run receiver(child_TestHandleWriterLoopResponse2130)
stop_process:skip
}

proctype TestHandleWriterLoopResponse213(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_handleWriterLoopResponse1262 = [1] of {int};
	chan child_handleWriterLoopResponse1261 = [1] of {int};
	chan child_handleWriterLoopResponse1260 = [1] of {int};
	Wgdef dq_waitGroup;
	Mutexdef dq_acks_lock;
	run mutexMonitor(dq_acks_lock);
	run wgMonitor(dq_waitGroup);
	run handleWriterLoopResponse126(dq_waitGroup,dq_acks_lock,child_handleWriterLoopResponse1260);
	child_handleWriterLoopResponse1260?0;
	run handleWriterLoopResponse126(dq_waitGroup,dq_acks_lock,child_handleWriterLoopResponse1261);
	child_handleWriterLoopResponse1261?0;
	run handleWriterLoopResponse126(dq_waitGroup,dq_acks_lock,child_handleWriterLoopResponse1262);
	child_handleWriterLoopResponse1262?0;
	stop_process: skip;
	child!0
}
proctype handleWriterLoopResponse126(Wgdef dq_waitGroup;Mutexdef dq_acks_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_response_segments = -2; // opt var_response_segments
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

