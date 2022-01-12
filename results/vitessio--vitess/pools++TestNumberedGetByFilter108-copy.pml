// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/pools/numbered_test.go#L108
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNumberedGetByFilter1080 = [1] of {int};
	run TestNumberedGetByFilter108(child_TestNumberedGetByFilter1080);
	run receiver(child_TestNumberedGetByFilter1080)
stop_process:skip
}

proctype TestNumberedGetByFilter108(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetByFilter1574 = [1] of {int};
	chan child_Get1123 = [1] of {int};
	chan child_Register652 = [1] of {int};
	chan child_Register651 = [1] of {int};
	chan child_Register650 = [1] of {int};
	Mutexdef p_recentlyUnregistered_mu;
	Mutexdef p_mu;
	run mutexMonitor(p_mu);
	run mutexMonitor(p_recentlyUnregistered_mu);
	run Register65(p_mu,p_recentlyUnregistered_mu,child_Register650);
	child_Register650?0;
	run Register65(p_mu,p_recentlyUnregistered_mu,child_Register651);
	child_Register651?0;
	run Register65(p_mu,p_recentlyUnregistered_mu,child_Register652);
	child_Register652?0;
	run Get112(p_mu,p_recentlyUnregistered_mu,child_Get1123);
	child_Get1123?0;
	run GetByFilter157(p_mu,p_recentlyUnregistered_mu,child_GetByFilter1574);
	child_GetByFilter1574?0;
	stop_process: skip;
	child!0
}
proctype Register65(Mutexdef nu_mu;Mutexdef nu_recentlyUnregistered_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	nu_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	nu_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Get112(Mutexdef nu_mu;Mutexdef nu_recentlyUnregistered_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	nu_mu.Lock!false;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi;
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	nu_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype GetByFilter157(Mutexdef nu_mu;Mutexdef nu_recentlyUnregistered_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_nu_resources = -2; // opt var_nu_resources
	nu_mu.Lock!false;
	goto defer1;
		defer1: skip;
	nu_mu.Unlock!false;
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

