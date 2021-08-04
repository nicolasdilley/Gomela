// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/minio/minio/blob/e948e7cdf65028f7a8545d1a05c2baea75198bd0/pkg/lsync/lrwmutex_test.go#L92
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testDualWriteLock920 = [1] of {int};
	run testDualWriteLock92(child_testDualWriteLock920);
	run receiver(child_testDualWriteLock920)
stop_process:skip
}

proctype testDualWriteLock92(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Unlock1293 = [1] of {int};
	chan child_GetLock522 = [1] of {int};
	chan child_AnonymoustestDualWriteLock102951 = [1] of {int};
	chan child_GetLock520 = [1] of {int};
	Mutexdef lrwm_mu;
	run mutexMonitor(lrwm_mu);
	run GetLock52(lrwm_mu,child_GetLock520);
	child_GetLock520?0;
	run AnonymoustestDualWriteLock10295(lrwm_mu,child_AnonymoustestDualWriteLock102951);
	run receiver(child_AnonymoustestDualWriteLock102951);
	run GetLock52(lrwm_mu,child_GetLock522);
	child_GetLock522?0;
	

	if
	:: true -> 
		run Unlock129(lrwm_mu,child_Unlock1293);
		child_Unlock1293?0
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetLock52(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_lockLoop1050 = [1] of {int};
	run lockLoop105(lm_mu,child_lockLoop1050);
	child_lockLoop1050?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype lockLoop105(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_lock750 = [1] of {int};
	do
	:: true -> 
		for10: skip;
		do
		:: true -> 
			goto stop_process
		:: true -> 
			run lock75(lm_mu,child_lock750);
			child_lock750?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		od;
		for11_exit: skip;
		for11_end: skip;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype lock75(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	lm_mu.Lock!false;
	goto defer1;
		defer1: skip;
	lm_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype AnonymoustestDualWriteLock10295(Mutexdef lrwm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Unlock1291 = [1] of {int};
	run Unlock129(lrwm_mu,child_Unlock1291);
	child_Unlock1291?0;
	stop_process: skip;
	child!0
}
proctype Unlock129(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_unlock1501 = [1] of {int};
	run unlock150(lm_mu,child_unlock1501);
	child_unlock1501?0;
	stop_process: skip;
	child!0
}
proctype unlock150(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	lm_mu.Lock!false;
	goto defer1;
		defer1: skip;
	lm_mu.Unlock!false;
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

