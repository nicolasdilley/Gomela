// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/drone/drone/blob/0d95c459da587bf8f5778b1f631fc8fe26af20dc/service/netrc/netrc_test.go#L164
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNetrc_StaticLogin1640 = [1] of {int};
	run TestNetrc_StaticLogin164(child_TestNetrc_StaticLogin1640);
	run receiver(child_TestNetrc_StaticLogin1640)
stop_process:skip
}

proctype TestNetrc_StaticLogin164(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Create530 = [1] of {int};
	Mutexdef s_client_mu;
	run mutexMonitor(s_client_mu);
	run Create53(s_client_mu,child_Create530);
	child_Create530?0;
	stop_process: skip;
	child!0
}
proctype Create53(Mutexdef s_client_mu;chan child) {
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true;
	:: true;
	:: true;
	fi;
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
