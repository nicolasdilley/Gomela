
// https://github.com/kubernetes/kubernetes/blob/master/pkg/credentialprovider/azure/azure_credentials_test.go#L145
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestParseACRLoginServerFromImage1450 = [1] of {int};
	run TestParseACRLoginServerFromImage145(child_TestParseACRLoginServerFromImage1450)
stop_process:skip
}

proctype TestParseACRLoginServerFromImage145(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_parseACRLoginServerFromImage3491 = [1] of {int};
	chan child_parseACRLoginServerFromImage3492 = [1] of {int};
	chan child_loadConfig1650 = [1] of {int};
	Mutexdef provider_servicePrincipalToken_refreshLock;
	int tests = -2;
	run mutexMonitor(provider_servicePrincipalToken_refreshLock);
	run loadConfig165(provider_servicePrincipalToken_refreshLock,child_loadConfig1650);
	child_loadConfig1650?0;
	

	if
	:: tests-1 != -3 -> 
				for(i : 0.. tests-1) {
			for10: skip;
			run parseACRLoginServerFromImage349(provider_servicePrincipalToken_refreshLock,child_parseACRLoginServerFromImage3491);
			child_parseACRLoginServerFromImage3491?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run parseACRLoginServerFromImage349(provider_servicePrincipalToken_refreshLock,child_parseACRLoginServerFromImage3492);
			child_parseACRLoginServerFromImage3492?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
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

