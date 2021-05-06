
// https://github.com/hashicorp/terraform/blob/master/states/remote/remote_test.go#L9
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRemoteClient_noPayload90 = [1] of {int};
	run TestRemoteClient_noPayload9(child_TestRemoteClient_noPayload90)
stop_process:skip
}

proctype TestRemoteClient_noPayload9(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RefreshState1010 = [1] of {int};
	Mutexdef s_mu;
	run mutexMonitor(s_mu);
	run RefreshState101(s_mu,child_RefreshState1010);
	child_RefreshState1010?0;
	stop_process: skip;
	child!0
}
proctype RefreshState101(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_refreshState1100 = [1] of {int};
	s_mu.Lock!false;
	run refreshState110(s_mu,child_refreshState1100);
	child_refreshState1100?0;
	goto stop_process;
	stop_process: skip;
		s_mu.Unlock!false;
	child!0
}
proctype refreshState110(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

