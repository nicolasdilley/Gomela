// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/kubelet/util/manager/cache_based_manager_test.go#L150
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSecretStoreGetAlwaysRefresh1500 = [1] of {int};
	run TestSecretStoreGetAlwaysRefresh150(child_TestSecretStoreGetAlwaysRefresh1500);
	run receiver(child_TestSecretStoreGetAlwaysRefresh1500)
stop_process:skip
}

proctype TestSecretStoreGetAlwaysRefresh150(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestSecretStoreGetAlwaysRefresh1631632 = [1] of {int};
	Wgdef wg;
	chan child_AddReference931 = [1] of {int};
	chan child_AddReference930 = [1] of {int};
	Mutexdef store_lock;
	int var_actionsactions = -2; // opt var_actionsactions
	run mutexMonitor(store_lock);
	

	if
	:: 0 != -2 && 10-1 != -3 -> 
				for(i : 0.. 10-1) {
			for11: skip;
			run AddReference93(store_lock,child_AddReference931);
			child_AddReference931?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run AddReference93(store_lock,child_AddReference930);
			child_AddReference930?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run wgMonitor(wg);
	wg.update!100;
		for(i : 0.. 100-1) {
		for20: skip;
		run AnonymousTestSecretStoreGetAlwaysRefresh163163(wg,store_lock,child_AnonymousTestSecretStoreGetAlwaysRefresh1631632);
		run receiver(child_AnonymousTestSecretStoreGetAlwaysRefresh1631632);
		for20_end: skip
	};
	for20_exit: skip;
	wg.wait?0;
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
proctype AnonymousTestSecretStoreGetAlwaysRefresh163163(Wgdef wg;Mutexdef store_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get1552 = [1] of {int};
	run Get155(store_lock,child_Get1552);
	child_Get1552?0;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype Get155(Mutexdef s_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_isObjectFresh1472 = [1] of {int};
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
	run isObjectFresh147(s_lock,child_isObjectFresh1472);
	child_isObjectFresh1472?0;
	

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
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

