// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//orderer/common/filerepo/filerepo_test.go#L119
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFileRepo_Remove1190 = [1] of {int};
	run TestFileRepo_Remove119(child_TestFileRepo_Remove1190);
	run receiver(child_TestFileRepo_Remove1190)
stop_process:skip
}

proctype TestFileRepo_Remove119(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Remove1050 = [1] of {int};
	Mutexdef r_mu;
	run mutexMonitor(r_mu);
	run Remove105(r_mu,child_Remove1050);
	child_Remove1050?0;
	stop_process: skip;
	child!0
}
proctype Remove105(Mutexdef r_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_baseToFilePath1590 = [1] of {int};
	r_mu.Lock!false;
	run baseToFilePath159(r_mu,child_baseToFilePath1590);
	child_baseToFilePath1590?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	r_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype baseToFilePath159(Mutexdef r_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_baseToFileName1630 = [1] of {int};
	run baseToFileName163(r_mu,child_baseToFileName1630);
	child_baseToFileName1630?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype baseToFileName163(Mutexdef r_mu;chan child) {
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

