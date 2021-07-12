// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/encoding/gob/encode.go#L659
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_getEncEngine6590 = [1] of {int};
	run getEncEngine659(child_getEncEngine6590);
	run receiver(child_getEncEngine6590)
stop_process:skip
}

proctype getEncEngine659(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_buildEncEngine6710 = [1] of {int};
	Mutexdef info_encInit;
	run mutexMonitor(info_encInit);
	

	if
	:: true -> 
		run buildEncEngine671(info_encInit,child_buildEncEngine6710);
		child_buildEncEngine6710?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype buildEncEngine671(Mutexdef info_encInit;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	info_encInit.Lock!false;
	goto defer1;
		defer1: skip;
	info_encInit.Unlock!false;
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

