
// https://github.com/kubernetes/kubernetes/blob/master/pkg/credentialprovider/azure/azure_credentials_test.go#L42
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test420 = [1] of {int};
	run Test42(child_Test420)
stop_process:skip
}

proctype Test42(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Provide2461 = [1] of {int};
	chan child_loadConfig1650 = [1] of {int};
	Mutexdef provider_servicePrincipalToken_refreshLock;
	run mutexMonitor(provider_servicePrincipalToken_refreshLock);
	run loadConfig165(provider_servicePrincipalToken_refreshLock,child_loadConfig1650);
	child_loadConfig1650?0;
	run Provide246(provider_servicePrincipalToken_refreshLock,child_Provide2461);
	child_Provide2461?0;
	stop_process: skip;
	child!0
}
proctype loadConfig165(Mutexdef a_servicePrincipalToken_refreshLock;chan child) {
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
proctype Provide246(Mutexdef a_servicePrincipalToken_refreshLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getFromACR2273 = [1] of {int};
	chan child_getFromCache2102 = [1] of {int};
	chan child_parseACRLoginServerFromImage3491 = [1] of {int};
	run parseACRLoginServerFromImage349(a_servicePrincipalToken_refreshLock,child_parseACRLoginServerFromImage3491);
	child_parseACRLoginServerFromImage3491?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run getFromCache210(a_servicePrincipalToken_refreshLock,child_getFromCache2102);
		child_getFromCache2102?0;
		

		if
		:: true -> 
			run getFromACR227(a_servicePrincipalToken_refreshLock,child_getFromACR2273);
			child_getFromACR2273?0
		fi
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype parseACRLoginServerFromImage349(Mutexdef a_servicePrincipalToken_refreshLock;chan child) {
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
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getFromCache210(Mutexdef a_servicePrincipalToken_refreshLock;chan child) {
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
proctype getFromACR227(Mutexdef a_servicePrincipalToken_refreshLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getACRDockerEntryFromARMToken3153 = [1] of {int};
	run getACRDockerEntryFromARMToken315(a_servicePrincipalToken_refreshLock,child_getACRDockerEntryFromARMToken3153);
	child_getACRDockerEntryFromARMToken3153?0;
	

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
proctype getACRDockerEntryFromARMToken315(Mutexdef a_servicePrincipalToken_refreshLock;chan child) {
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

