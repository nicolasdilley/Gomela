// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//orderer/common/cluster/util_test.go#L1192
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestComparisonMemoizer11920 = [1] of {int};
	run TestComparisonMemoizer1192(child_TestComparisonMemoizer11920);
	run receiver(child_TestComparisonMemoizer11920)
stop_process:skip
}

proctype TestComparisonMemoizer1192(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Size7358 = [1] of {int};
	chan child_Compare7447 = [1] of {int};
	chan child_Size7356 = [1] of {int};
	chan child_Compare7445 = [1] of {int};
	chan child_Compare7444 = [1] of {int};
	chan child_Compare7443 = [1] of {int};
	chan child_Compare7442 = [1] of {int};
	chan child_Compare7441 = [1] of {int};
	chan child_Compare7440 = [1] of {int};
	Mutexdef m_once_m;
	Mutexdef m_lock;
	run mutexMonitor(m_lock);
	run mutexMonitor(m_once_m);
	

	if
	:: 0 != -2 && 5-1 != -3 -> 
				for(i : 0.. 5-1) {
			for15: skip;
			run Compare744(m_lock,m_once_m,child_Compare7441);
			child_Compare7441?0;
			for15_end: skip
		};
		for15_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Compare744(m_lock,m_once_m,child_Compare7440);
			child_Compare7440?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: 0 != -2 && 5-1 != -3 -> 
				for(i : 0.. 5-1) {
			for21: skip;
			run Compare744(m_lock,m_once_m,child_Compare7443);
			child_Compare7443?0;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run Compare744(m_lock,m_once_m,child_Compare7442);
			child_Compare7442?0;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	run Compare744(m_lock,m_once_m,child_Compare7444);
	child_Compare7444?0;
	

	if
	:: 0 != -2 && 20-1 != -3 -> 
				for(i : 0.. 20-1) {
			for31: skip;
			run Compare744(m_lock,m_once_m,child_Compare7447);
			child_Compare7447?0;
			run Size735(m_lock,m_once_m,child_Size7358);
			child_Size7358?0;
			for31_end: skip
		};
		for31_exit: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			run Compare744(m_lock,m_once_m,child_Compare7445);
			child_Compare7445?0;
			run Size735(m_lock,m_once_m,child_Size7356);
			child_Size7356?0;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype Compare744(Mutexdef cm_lock;Mutexdef cm_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_shrinkIfNeeded7700 = [1] of {int};
	cm_lock.RLock!false;
	cm_lock.RUnlock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	cm_lock.Lock!false;
	run shrinkIfNeeded770(cm_lock,cm_once_m,child_shrinkIfNeeded7700);
	child_shrinkIfNeeded7700?0;
	goto defer1;
		defer1: skip;
	cm_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype shrinkIfNeeded770(Mutexdef cm_lock;Mutexdef cm_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_shrink7800 = [1] of {int};
	do
	:: true -> 
		for11: skip;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run shrink780(cm_lock,cm_once_m,child_shrink7800);
		child_shrink7800?0;
		for11_end: skip
	od;
	for11_exit: skip;
	stop_process: skip;
	child!0
}
proctype shrink780(Mutexdef cm_lock;Mutexdef cm_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_cm_cache = -2; // opt var_cm_cache
	stop_process: skip;
	child!0
}
proctype Size735(Mutexdef cm_lock;Mutexdef cm_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	cm_lock.RLock!false;
	goto defer1;
		defer1: skip;
	cm_lock.RUnlock!false;
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

