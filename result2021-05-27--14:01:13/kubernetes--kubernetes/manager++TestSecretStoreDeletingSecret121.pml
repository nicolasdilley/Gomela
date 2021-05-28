// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/kubelet/util/manager/cache_based_manager_test.go#L121
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSecretStoreDeletingSecret1210 = [1] of {int};
	run TestSecretStoreDeletingSecret121(child_TestSecretStoreDeletingSecret1210);
	run receiver(child_TestSecretStoreDeletingSecret1210)
stop_process:skip
}

proctype TestSecretStoreDeletingSecret121(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get1552 = [1] of {int};
	chan child_Get1551 = [1] of {int};
	chan child_AddReference930 = [1] of {int};
	Mutexdef store_lock;
	run mutexMonitor(store_lock);
	run AddReference93(store_lock,child_AddReference930);
	child_AddReference930?0;
	run Get155(store_lock,child_Get1551);
	child_Get1551?0;
	run Get155(store_lock,child_Get1552);
	child_Get1552?0;
	stop_process: skip;
	child!0
}
proctype AddReference93(Mutexdef s_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_lock.Lock!false;
		defer1: skip;
	s_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Get155(Mutexdef s_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_isObjectFresh1471 = [1] of {int};
	s_lock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	s_lock.Unlock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run isObjectFresh147(s_lock,child_isObjectFresh1471);
	child_isObjectFresh1471?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	:: true;
	fi;
	goto defer1;
		defer1: skip;
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

proctype receiver(chan c) {
c?0
}

