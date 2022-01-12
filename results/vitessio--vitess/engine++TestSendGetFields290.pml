// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtgate/engine/send_test.go#L290
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSendGetFields2900 = [1] of {int};
	run TestSendGetFields290(child_TestSendGetFields2900);
	run receiver(child_TestSendGetFields2900)
stop_process:skip
}

proctype TestSendGetFields290(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ExpectLog5031 = [1] of {int};
	chan child_GetFields1630 = [1] of {int};
	Mutexdef vc_mu;
	run mutexMonitor(vc_mu);
	run GetFields163(vc_mu,child_GetFields1630);
	child_GetFields1630?0;
	run ExpectLog503(vc_mu,child_ExpectLog5031);
	child_ExpectLog5031?0;
	stop_process: skip;
	child!0
}
proctype GetFields163(Mutexdef vcursor_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ExpectLog503(Mutexdef f_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

