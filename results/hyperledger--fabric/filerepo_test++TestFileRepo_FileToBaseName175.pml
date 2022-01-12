// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//orderer/common/filerepo/filerepo_test.go#L175
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFileRepo_FileToBaseName1750 = [1] of {int};
	run TestFileRepo_FileToBaseName175(child_TestFileRepo_FileToBaseName1750);
	run receiver(child_TestFileRepo_FileToBaseName1750)
stop_process:skip
}

proctype TestFileRepo_FileToBaseName175(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_FileToBaseName1530 = [1] of {int};
	Mutexdef r_mu;
	run mutexMonitor(r_mu);
	run FileToBaseName153(r_mu,child_FileToBaseName1530);
	child_FileToBaseName1530?0;
	stop_process: skip;
	child!0
}
proctype FileToBaseName153(Mutexdef r_mu;chan child) {
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

