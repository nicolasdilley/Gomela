
// https://github.com/hashicorp/consul/blob/master/agent/ae/ae_test.go#L37
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAE_Pause_nestedPauseResume370 = [1] of {int};
	run TestAE_Pause_nestedPauseResume37(child_TestAE_Pause_nestedPauseResume370)
stop_process:skip
}

proctype TestAE_Pause_nestedPauseResume37(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Resume3349 = [1] of {int};
	chan child_Paused3268 = [1] of {int};
	chan child_Resume3347 = [1] of {int};
	chan child_Paused3266 = [1] of {int};
	chan child_Resume3345 = [1] of {int};
	chan child_Paused3264 = [1] of {int};
	chan child_Pause3193 = [1] of {int};
	chan child_Paused3262 = [1] of {int};
	chan child_Pause3191 = [1] of {int};
	chan child_Paused3260 = [1] of {int};
	Mutexdef l_pauseLock;
	run mutexMonitor(l_pauseLock);
	run Paused326(l_pauseLock,child_Paused3260);
	child_Paused3260?0;
	run Pause319(l_pauseLock,child_Pause3191);
	child_Pause3191?0;
	run Paused326(l_pauseLock,child_Paused3262);
	child_Paused3262?0;
	run Pause319(l_pauseLock,child_Pause3193);
	child_Pause3193?0;
	run Paused326(l_pauseLock,child_Paused3264);
	child_Paused3264?0;
	run Resume334(l_pauseLock,child_Resume3345);
	child_Resume3345?0;
	run Paused326(l_pauseLock,child_Paused3266);
	child_Paused3266?0;
	run Resume334(l_pauseLock,child_Resume3347);
	child_Resume3347?0;
	run Paused326(l_pauseLock,child_Paused3268);
	child_Paused3268?0;
	run Resume334(l_pauseLock,child_Resume3349);
	child_Resume3349?0;
	stop_process: skip;
	child!0
}
proctype Paused326(Mutexdef s_pauseLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_pauseLock.Lock!false;
	goto stop_process;
	stop_process: skip;
		s_pauseLock.Unlock!false;
	child!0
}
proctype Pause319(Mutexdef s_pauseLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_pauseLock.Lock!false;
	s_pauseLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Resume334(Mutexdef s_pauseLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_pauseLock.Lock!false;
	s_pauseLock.Unlock!false;
	goto stop_process;
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

