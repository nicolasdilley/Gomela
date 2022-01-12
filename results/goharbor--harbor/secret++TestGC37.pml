// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/goharbor/harbor/blob//src/pkg/proxy/secret/manager_test.go#L37
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGC370 = [1] of {int};
	run TestGC37(child_TestGC370);
	run receiver(child_TestGC370)
stop_process:skip
}

proctype TestGC37(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Generate613 = [1] of {int};
	chan child_Generate612 = [1] of {int};
	chan child_Generate611 = [1] of {int};
	chan child_Generate610 = [1] of {int};
	Mutexdef manager_lock;
	Mutexdef manager_m_mu;
	run mutexMonitor(manager_m_mu);
	run mutexMonitor(manager_lock);
	

	if
	:: 0 != -2 && 10-1 != -3 -> 
				for(i : 0.. 10-1) {
			for11: skip;
			run Generate61(manager_lock,manager_m_mu,child_Generate611);
			child_Generate611?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Generate61(manager_lock,manager_m_mu,child_Generate610);
			child_Generate610?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: 0 != -2 && 1000-1 != -3 -> 
				for(i : 0.. 1000-1) {
			for21: skip;
			run Generate61(manager_lock,manager_m_mu,child_Generate613);
			child_Generate613?0;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run Generate61(manager_lock,manager_m_mu,child_Generate612);
			child_Generate612?0;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype Generate61(Mutexdef man_lock;Mutexdef man_m_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_gc980 = [1] of {int};
	

	if
	:: true -> 
		run gc98(man_lock,man_m_mu,child_gc980);
		child_gc980?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype gc98(Mutexdef man_lock;Mutexdef man_m_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Anonymousgc10600 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
		defer1: skip;
	

	if
	:: true -> 
		run Anonymousgc1060(man_lock,man_m_mu,child_Anonymousgc10600);
		run receiver(child_Anonymousgc10600)
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype Anonymousgc1060(Mutexdef man_lock;Mutexdef man_m_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_gc980 = [1] of {int};
	run gc98(man_lock,man_m_mu,child_gc980);
	child_gc980?0;
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

