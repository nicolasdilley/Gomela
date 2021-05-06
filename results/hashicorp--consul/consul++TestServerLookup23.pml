
// https://github.com/hashicorp/consul/blob/master/agent/consul/server_lookup_test.go#L23
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestServerLookup230 = [1] of {int};
	run TestServerLookup23(child_TestServerLookup230)
stop_process:skip
}

proctype TestServerLookup23(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RemoveServer325 = [1] of {int};
	chan child_ServerAddr404 = [1] of {int};
	chan child_RemoveServer323 = [1] of {int};
	chan child_Server512 = [1] of {int};
	chan child_ServerAddr401 = [1] of {int};
	chan child_AddServer250 = [1] of {int};
	Mutexdef lookup_lock;
	run mutexMonitor(lookup_lock);
	run AddServer25(lookup_lock,child_AddServer250);
	child_AddServer250?0;
	run ServerAddr40(lookup_lock,child_ServerAddr401);
	child_ServerAddr401?0;
	run Server51(lookup_lock,child_Server512);
	child_Server512?0;
	run RemoveServer32(lookup_lock,child_RemoveServer323);
	child_RemoveServer323?0;
	run ServerAddr40(lookup_lock,child_ServerAddr404);
	child_ServerAddr404?0;
	run RemoveServer32(lookup_lock,child_RemoveServer325);
	child_RemoveServer325?0;
	stop_process: skip;
	child!0
}
proctype AddServer25(Mutexdef sl_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	sl_lock.Lock!false;
	stop_process: skip;
		sl_lock.Unlock!false;
	child!0
}
proctype ServerAddr40(Mutexdef sl_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	sl_lock.RLock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		sl_lock.RUnlock!false;
	child!0
}
proctype Server51(Mutexdef sl_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	sl_lock.RLock!false;
	goto stop_process;
	stop_process: skip;
		sl_lock.RUnlock!false;
	child!0
}
proctype RemoveServer32(Mutexdef sl_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	sl_lock.Lock!false;
	stop_process: skip;
		sl_lock.Unlock!false;
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

