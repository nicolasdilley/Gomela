
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/util/manager/cache_based_manager_test.go#L87
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSecretStore870 = [1] of {int};
	run TestSecretStore87(child_TestSecretStore870)
stop_process:skip
}

proctype TestSecretStore87(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkObject4413 = [1] of {int};
	chan child_checkObject4412 = [1] of {int};
	chan child_checkObject4411 = [1] of {int};
	chan child_checkObject4410 = [1] of {int};
	chan child_Get1559 = [1] of {int};
	chan child_Get1558 = [1] of {int};
	chan child_Get1557 = [1] of {int};
	chan child_AddReference936 = [1] of {int};
	chan child_DeleteReference1155 = [1] of {int};
	chan child_DeleteReference1154 = [1] of {int};
	chan child_AddReference933 = [1] of {int};
	chan child_AddReference932 = [1] of {int};
	chan child_AddReference931 = [1] of {int};
	chan child_AddReference930 = [1] of {int};
	Mutexdef store_lock;
	run mutexMonitor(store_lock);
	run AddReference93(store_lock,child_AddReference930);
	child_AddReference930?0;
	run AddReference93(store_lock,child_AddReference931);
	child_AddReference931?0;
	run AddReference93(store_lock,child_AddReference932);
	child_AddReference932?0;
	run AddReference93(store_lock,child_AddReference933);
	child_AddReference933?0;
	run DeleteReference115(store_lock,child_DeleteReference1154);
	child_DeleteReference1154?0;
	run DeleteReference115(store_lock,child_DeleteReference1155);
	child_DeleteReference1155?0;
	run AddReference93(store_lock,child_AddReference936);
	child_AddReference936?0;
	run Get155(store_lock,child_Get1557);
	child_Get1557?0;
	run Get155(store_lock,child_Get1558);
	child_Get1558?0;
	run Get155(store_lock,child_Get1559);
	child_Get1559?0;
	run checkObject44(store_lock,child_checkObject4410);
	child_checkObject4410?0;
	run checkObject44(store_lock,child_checkObject4411);
	child_checkObject4411?0;
	run checkObject44(store_lock,child_checkObject4412);
	child_checkObject4412?0;
	run checkObject44(store_lock,child_checkObject4413);
	child_checkObject4413?0;
	stop_process: skip;
	child!0
}
proctype AddReference93(Mutexdef s_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_lock.Lock!false;
	stop_process: skip;
		s_lock.Unlock!false;
	child!0
}
proctype DeleteReference115(Mutexdef s_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_lock.Lock!false;
	stop_process: skip;
		s_lock.Unlock!false;
	child!0
}
proctype Get155(Mutexdef s_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_isObjectFresh1477 = [1] of {int};
	s_lock.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
		s_lock.Unlock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run isObjectFresh147(s_lock,child_isObjectFresh1477);
	child_isObjectFresh1477?0;
	

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
proctype isObjectFresh147(Mutexdef s_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype checkObject44(Mutexdef store_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get15510 = [1] of {int};
	run Get155(store_lock,child_Get15510);
	child_Get15510?0;
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

