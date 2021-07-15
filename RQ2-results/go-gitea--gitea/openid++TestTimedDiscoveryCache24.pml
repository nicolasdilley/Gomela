
// https://github.com/go-gitea/gitea/blob/master/modules/auth/openid/discovery_cache_test.go#L24
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTimedDiscoveryCache240 = [1] of {int};
	run TestTimedDiscoveryCache24(child_TestTimedDiscoveryCache240)
stop_process:skip
}

proctype TestTimedDiscoveryCache24(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get473 = [1] of {int};
	chan child_Get472 = [1] of {int};
	chan child_Get471 = [1] of {int};
	chan child_Put290 = [1] of {int};
	Mutexdef dc_mutex;
	run mutexMonitor(dc_mutex);
	run Put29(dc_mutex,child_Put290);
	child_Put290?0;
	run Get47(dc_mutex,child_Get471);
	child_Get471?0;
	run Get47(dc_mutex,child_Get472);
	child_Get472?0;
	run Get47(dc_mutex,child_Get473);
	child_Get473?0;
	stop_process: skip;
	child!0
}
proctype Put29(Mutexdef s_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mutex.Lock!false;
	stop_process: skip;
		s_mutex.Unlock!false;
	child!0
}
proctype Get47(Mutexdef s_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_cleanTimedOut371 = [1] of {int};
	s_mutex.Lock!false;
	run cleanTimedOut37(s_mutex,child_cleanTimedOut371);
	child_cleanTimedOut371?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		s_mutex.Unlock!false;
	child!0
}
proctype cleanTimedOut37(Mutexdef s_mutex;chan child) {
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

