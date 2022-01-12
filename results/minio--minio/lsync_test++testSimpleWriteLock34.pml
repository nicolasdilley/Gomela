// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/minio/minio/blob//pkg/lsync/lrwmutex_test.go#L34
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testSimpleWriteLock340 = [1] of {int};
	run testSimpleWriteLock34(child_testSimpleWriteLock340);
	run receiver(child_testSimpleWriteLock340)
stop_process:skip
}

proctype testSimpleWriteLock34(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Unlock1295 = [1] of {int};
	chan child_GetLock524 = [1] of {int};
	chan child_AnonymoustestSimpleWriteLock55373 = [1] of {int};
	chan child_AnonymoustestSimpleWriteLock49372 = [1] of {int};
	chan child_GetRLock691 = [1] of {int};
	chan child_GetRLock690 = [1] of {int};
	Mutexdef lrwm_mu;
	run mutexMonitor(lrwm_mu);
	run GetRLock69(lrwm_mu,child_GetRLock690);
	child_GetRLock690?0;
	run GetRLock69(lrwm_mu,child_GetRLock691);
	child_GetRLock691?0;
	run AnonymoustestSimpleWriteLock4937(lrwm_mu,child_AnonymoustestSimpleWriteLock49372);
	run receiver(child_AnonymoustestSimpleWriteLock49372);
	run AnonymoustestSimpleWriteLock5537(lrwm_mu,child_AnonymoustestSimpleWriteLock55373);
	run receiver(child_AnonymoustestSimpleWriteLock55373);
	run GetLock52(lrwm_mu,child_GetLock524);
	child_GetLock524?0;
	

	if
	:: true -> 
		run Unlock129(lrwm_mu,child_Unlock1295);
		child_Unlock1295?0
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetRLock69(Mutexdef lm_mu;chan child) {
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
proctype AnonymoustestSimpleWriteLock4937(Mutexdef lrwm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RUnlock1412 = [1] of {int};
	run RUnlock141(lrwm_mu,child_RUnlock1412);
	child_RUnlock1412?0;
	stop_process: skip;
	child!0
}
proctype RUnlock141(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_unlock1502 = [1] of {int};
	run unlock150(lm_mu,child_unlock1502);
	child_unlock1502?0;
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
proctype AnonymoustestSimpleWriteLock5537(Mutexdef lrwm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RUnlock1413 = [1] of {int};
	run RUnlock141(lrwm_mu,child_RUnlock1413);
	child_RUnlock1413?0;
	stop_process: skip;
	child!0
}
proctype GetLock52(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_lockLoop1054 = [1] of {int};
	run lockLoop105(lm_mu,child_lockLoop1054);
	child_lockLoop1054?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Unlock129(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_unlock1505 = [1] of {int};
	run unlock150(lm_mu,child_unlock1505);
	child_unlock1505?0;
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

