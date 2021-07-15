
// https://github.com/hashicorp/terraform/blob/master/backend/remote-state/oss/client_test.go#L214
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRemoteClient_clientMD52140 = [1] of {int};
	run TestRemoteClient_clientMD5214(child_TestRemoteClient_clientMD52140)
stop_process:skip
}

proctype TestRemoteClient_clientMD5214(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getMD52093 = [1] of {int};
	chan child_deleteMD52962 = [1] of {int};
	chan child_getMD52091 = [1] of {int};
	chan child_putMD52520 = [1] of {int};
	Mutexdef client_mu;
	run mutexMonitor(client_mu);
	run putMD5252(client_mu,child_putMD52520);
	child_putMD52520?0;
	run getMD5209(client_mu,child_getMD52091);
	child_getMD52091?0;
	run deleteMD5296(client_mu,child_deleteMD52962);
	child_deleteMD52962?0;
	run getMD5209(client_mu,child_getMD52093);
	child_getMD52093?0;
	stop_process: skip;
	child!0
}
proctype putMD5252(Mutexdef c_mu;chan child) {
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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getMD5209(Mutexdef c_mu;chan child) {
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
proctype deleteMD5296(Mutexdef c_mu;chan child) {
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

