
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/util/manager/cache_based_manager_test.go#L177
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
	chan child_TestSecretStoreGetNeverRefresh1770 = [1] of {int};
	run TestSecretStoreGetNeverRefresh177(child_TestSecretStoreGetNeverRefresh1770)
stop_process:skip
}

proctype TestSecretStoreGetNeverRefresh177(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestSecretStoreGetNeverRefresh1901902 = [1] of {int};
	Wgdef wg;
	chan child_AddReference931 = [1] of {int};
	chan child_AddReference930 = [1] of {int};
	Mutexdef store_lock;
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
		run AnonymousTestSecretStoreGetNeverRefresh190190(wg,store_lock,child_AnonymousTestSecretStoreGetNeverRefresh1901902);
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
	stop_process: skip;
		s_lock.Unlock!false;
	child!0
}
proctype AnonymousTestSecretStoreGetNeverRefresh190190(Wgdef wg;Mutexdef store_lock;chan child) {
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
	run isObjectFresh147(s_lock,child_isObjectFresh1472);
	child_isObjectFresh1472?0;
	

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

