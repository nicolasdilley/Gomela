
// https://github.com/dgraph-io/dgraph/blob/master/upgrade/change_v21.03.0.go#L207
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_upgradeCORS2070 = [1] of {int};
	run upgradeCORS207(child_upgradeCORS2070)
stop_process:skip
}

proctype upgradeCORS207(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_dropDeprecated1282 = [1] of {int};
	chan child_getQueryResult1761 = [1] of {int};
	chan child_getQueryResult1760 = [1] of {int};
	Mutexdef dg_jwtMutex;
	run mutexMonitor(dg_jwtMutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getQueryResult176(dg_jwtMutex,child_getQueryResult1760);
	child_getQueryResult1760?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getQueryResult176(dg_jwtMutex,child_getQueryResult1761);
	child_getQueryResult1761?0;
	

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
	run dropDeprecated128(dg_jwtMutex,child_dropDeprecated1282);
	child_dropDeprecated1282?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getQueryResult176(Mutexdef dg_jwtMutex;chan child) {
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
proctype dropDeprecated128(Mutexdef dg_jwtMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_alterWithClient2254 = [1] of {int};
	chan child_alterWithClient2255 = [1] of {int};
	chan child_alterWithClient2252 = [1] of {int};
	chan child_alterWithClient2253 = [1] of {int};
	int deprecatedPreds = -2;
	int deprecatedTypes = -2;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: deprecatedPreds-1 != -3 -> 
				for(i : 0.. deprecatedPreds-1) {
			for40: skip;
			run alterWithClient225(dg_jwtMutex,child_alterWithClient2252);
			child_alterWithClient2252?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for40_end: skip
		};
		for40_exit: skip
	:: else -> 
		do
		:: true -> 
			for43: skip;
			run alterWithClient225(dg_jwtMutex,child_alterWithClient2253);
			child_alterWithClient2253?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for43_end: skip
		:: true -> 
			break
		od;
		for43_exit: skip
	fi;
	

	if
	:: deprecatedTypes-1 != -3 -> 
				for(i : 0.. deprecatedTypes-1) {
			for50: skip;
			run alterWithClient225(dg_jwtMutex,child_alterWithClient2254);
			child_alterWithClient2254?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for50_end: skip
		};
		for50_exit: skip
	:: else -> 
		do
		:: true -> 
			for51: skip;
			run alterWithClient225(dg_jwtMutex,child_alterWithClient2255);
			child_alterWithClient2255?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for51_end: skip
		:: true -> 
			break
		od;
		for51_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype alterWithClient225(Mutexdef dg_jwtMutex;chan child) {
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

