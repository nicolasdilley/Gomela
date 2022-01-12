// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//x-pack/filebeat/input/awss3/semaphore_test.go#L14
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
	chan child_TestSemaphore140 = [1] of {int};
	run TestSemaphore14(child_TestSemaphore140);
	run receiver(child_TestSemaphore140)
stop_process:skip
}

proctype TestSemaphore14(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Release663 = [1] of {int};
	chan child_Available782 = [1] of {int};
	chan child_AnonymousTestSemaphore21191 = [1] of {int};
	Wgdef wg;
	chan child_Acquire440 = [1] of {int};
	Mutexdef s_mutex;
	run mutexMonitor(s_mutex);
	run Acquire44(s_mutex,child_Acquire440);
	child_Acquire440?0;
	run wgMonitor(wg);
	wg.update!1;
	run AnonymousTestSemaphore2119(wg,s_mutex,child_AnonymousTestSemaphore21191);
	run receiver(child_AnonymousTestSemaphore21191);
	run Available78(s_mutex,child_Available782);
	child_Available782?0;
	run Release66(s_mutex,child_Release663);
	child_Release663?0;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype Acquire44(Mutexdef s_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	s_mutex.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	s_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype AnonymousTestSemaphore2119(Wgdef wg;Mutexdef s_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Acquire441 = [1] of {int};
	run Acquire44(s_mutex,child_Acquire441);
	child_Acquire441?0;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype Available78(Mutexdef s_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mutex.Lock!false;
	goto defer1;
		defer1: skip;
	s_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Release66(Mutexdef s_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	s_mutex.Lock!false;
		defer1: skip;
	s_mutex.Unlock!false;
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

