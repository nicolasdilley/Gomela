
// https://github.com/kubernetes/kubernetes/blob/master/pkg/registry/core/componentstatus/rest.go#L124
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Get1240 = [1] of {int};
	run Get124(child_Get1240)
stop_process:skip
}

proctype Get124(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getComponentStatus1450 = [1] of {int};
	Mutexdef server_Once_m;
	Mutexdef server_TLSConfig_mutex;
	run mutexMonitor(server_TLSConfig_mutex);
	run mutexMonitor(server_Once_m);
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		run getComponentStatus145(server_TLSConfig_mutex,server_Once_m,child_getComponentStatus1450);
		child_getComponentStatus1450?0;
		goto stop_process
	fi;
	stop_process: skip;
	child!0
}
proctype getComponentStatus145(Mutexdef server_TLSConfig_mutex;Mutexdef server_Once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DoServerCheck590 = [1] of {int};
	run DoServerCheck59(server_TLSConfig_mutex,server_Once_m,child_DoServerCheck590);
	child_DoServerCheck590?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DoServerCheck59(Mutexdef server_TLSConfig_mutex;Mutexdef server_Once_m;chan child) {
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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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

