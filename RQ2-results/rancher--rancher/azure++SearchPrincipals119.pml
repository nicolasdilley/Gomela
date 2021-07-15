
// https://github.com/rancher/rancher/blob/master/pkg/auth/providers/azure/azure_provider.go#L119
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_SearchPrincipals1190 = [1] of {int};
	run SearchPrincipals119(child_SearchPrincipals1190)
stop_process:skip
}

proctype SearchPrincipals119(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_updateToken4974 = [1] of {int};
	chan child_searchUsers3140 = [1] of {int};
	chan child_searchGroups3301 = [1] of {int};
	chan child_searchGroups3303 = [1] of {int};
	chan child_searchUsers3142 = [1] of {int};
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
		run searchUsers314(client_servicePrincipal_refreshLock,child_searchUsers3140);
		child_searchUsers3140?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		run searchGroups330(client_servicePrincipal_refreshLock,child_searchGroups3301);
		child_searchGroups3301?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		run searchUsers314(client_servicePrincipal_refreshLock,child_searchUsers3142);
		child_searchUsers3142?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run searchGroups330(client_servicePrincipal_refreshLock,child_searchGroups3303);
		child_searchGroups3303?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	run updateToken497(client_servicePrincipal_refreshLock,child_updateToken4974);
	child_updateToken4974?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype searchUsers314(Mutexdef client_servicePrincipal_refreshLock;chan child) {
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
proctype searchGroups330(Mutexdef client_servicePrincipal_refreshLock;chan child) {
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
	chan child_marshalTokenJSON1314 = [1] of {int};
	run marshalTokenJSON131(client_servicePrincipal_refreshLock,child_marshalTokenJSON1314);
	child_marshalTokenJSON1314?0;
	

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

