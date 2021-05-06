
// https://github.com/dgraph-io/dgraph/blob/master/upgrade/change_v20.07.0.go#L94
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_upgradeAclTypeNames940 = [1] of {int};
	run upgradeAclTypeNames94(child_upgradeAclTypeNames940)
stop_process:skip
}

proctype upgradeAclTypeNames94(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_updateTypeSchema1841 = [1] of {int};
	chan child_updateTypeName1520 = [1] of {int};
	chan child_updateTypeSchema1843 = [1] of {int};
	chan child_updateTypeName1522 = [1] of {int};
	Mutexdef dg_jwtMutex;
	int aclTypeNameInfo = -2;
	run mutexMonitor(dg_jwtMutex);
	

	if
	:: aclTypeNameInfo-1 != -3 -> 
				for(i : 0.. aclTypeNameInfo-1) {
			for10: skip;
			run updateTypeName152(dg_jwtMutex,child_updateTypeName1520);
			child_updateTypeName1520?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			run updateTypeSchema184(dg_jwtMutex,child_updateTypeSchema1841);
			child_updateTypeSchema1841?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for19: skip;
			run updateTypeName152(dg_jwtMutex,child_updateTypeName1522);
			child_updateTypeName1522?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			run updateTypeSchema184(dg_jwtMutex,child_updateTypeSchema1843);
			child_updateTypeSchema1843?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for19_end: skip
		:: true -> 
			break
		od;
		for19_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype updateTypeName152(Mutexdef dg_jwtMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_mutateWithClient1991 = [1] of {int};
	chan child_getQueryResult1760 = [1] of {int};
	

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
	

	if
	:: true -> 
		run mutateWithClient199(dg_jwtMutex,child_mutateWithClient1991);
		child_mutateWithClient1991?0;
		

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
proctype mutateWithClient199(Mutexdef dg_jwtMutex;chan child) {
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
proctype updateTypeSchema184(Mutexdef dg_jwtMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_alterWithClient2252 = [1] of {int};
	chan child_alterWithClient2254 = [1] of {int};
	chan child_getQueryResult1763 = [1] of {int};
	chan child_getQueryResult1761 = [1] of {int};
	

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
	

	if
	:: true -> 
		run alterWithClient225(dg_jwtMutex,child_alterWithClient2252);
		child_alterWithClient2252?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			run getQueryResult176(dg_jwtMutex,child_getQueryResult1763);
			child_getQueryResult1763?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			run alterWithClient225(dg_jwtMutex,child_alterWithClient2254);
			child_alterWithClient2254?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
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

