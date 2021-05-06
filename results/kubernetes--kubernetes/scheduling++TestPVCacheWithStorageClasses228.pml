
// https://github.com/kubernetes/kubernetes/blob/master/pkg/controller/volume/scheduling/scheduler_assume_cache_test.go#L228
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPVCacheWithStorageClasses2280 = [1] of {int};
	run TestPVCacheWithStorageClasses228(child_TestPVCacheWithStorageClasses2280)
stop_process:skip
}

proctype TestPVCacheWithStorageClasses228(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_delete2045 = [1] of {int};
	chan child_update2004 = [1] of {int};
	chan child_add1573 = [1] of {int};
	chan child_add1572 = [1] of {int};
	chan child_add1571 = [1] of {int};
	chan child_add1570 = [1] of {int};
	Mutexdef internalCache_rwMutex;
	run mutexMonitor(internalCache_rwMutex);
	

	if
	:: 0 != -2 && 10-1 != -3 -> 
				for(i : 0.. 10-1) {
			for11: skip;
			run add157(internalCache_rwMutex,child_add1571);
			child_add1571?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run add157(internalCache_rwMutex,child_add1570);
			child_add1570?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: 0 != -2 && 10-1 != -3 -> 
				for(i : 0.. 10-1) {
			for21: skip;
			run add157(internalCache_rwMutex,child_add1573);
			child_add1573?0;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run add157(internalCache_rwMutex,child_add1572);
			child_add1572?0;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	run update200(internalCache_rwMutex,child_update2004);
	child_update2004?0;
	run delete204(internalCache_rwMutex,child_delete2045);
	child_delete2045?0;
	stop_process: skip;
	child!0
}
proctype add157(Mutexdef c_rwMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getObjVersion2252 = [1] of {int};
	chan child_getObjVersion2251 = [1] of {int};
	chan child_getObjInfo2380 = [1] of {int};
	

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
	c_rwMutex.Lock!false;
	run getObjInfo238(c_rwMutex,child_getObjInfo2380);
	child_getObjInfo2380?0;
	

	if
	:: true -> 
		run getObjVersion225(c_rwMutex,child_getObjVersion2251);
		child_getObjVersion2251?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run getObjVersion225(c_rwMutex,child_getObjVersion2252);
		child_getObjVersion2252?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	stop_process: skip;
		c_rwMutex.Unlock!false;
	child!0
}
proctype getObjInfo238(Mutexdef c_rwMutex;chan child) {
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
proctype getObjVersion225(Mutexdef c_rwMutex;chan child) {
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
proctype update200(Mutexdef c_rwMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_add1574 = [1] of {int};
	run add157(c_rwMutex,child_add1574);
	child_add1574?0;
	stop_process: skip;
	child!0
}
proctype delete204(Mutexdef c_rwMutex;chan child) {
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
	c_rwMutex.Lock!false;
	stop_process: skip;
		c_rwMutex.Unlock!false;
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

