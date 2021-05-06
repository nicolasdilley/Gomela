
// https://github.com/rancher/rancher/blob/master/pkg/auth/providers/azure/azure_provider.go#L164
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_GetPrincipal1640 = [1] of {int};
	run GetPrincipal164(child_GetPrincipal1640)
stop_process:skip
}

proctype GetPrincipal164(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_updateToken4972 = [1] of {int};
	chan child_getUser2900 = [1] of {int};
	chan child_getGroup3021 = [1] of {int};
	Mutexdef client_servicePrincipal_refreshLock;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(client_servicePrincipal_refreshLock);
	

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
		run getUser290(client_servicePrincipal_refreshLock,child_getUser2900);
		child_getUser2900?0
	:: true -> 
		run getGroup302(client_servicePrincipal_refreshLock,child_getGroup3021);
		child_getGroup3021?0
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run updateToken497(client_servicePrincipal_refreshLock,child_updateToken4972);
	child_updateToken4972?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getUser290(Mutexdef client_servicePrincipal_refreshLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getGroup302(Mutexdef client_servicePrincipal_refreshLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype updateToken497(Mutexdef client_servicePrincipal_refreshLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_marshalTokenJSON1312 = [1] of {int};
	run marshalTokenJSON131(client_servicePrincipal_refreshLock,child_marshalTokenJSON1312);
	child_marshalTokenJSON1312?0;
	

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
		fi;
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
proctype marshalTokenJSON131(Mutexdef ac_servicePrincipal_refreshLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

