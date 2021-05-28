// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/backend/remote-state/swift/client_test.go#L16
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRemoteClient160 = [1] of {int};
	run TestRemoteClient16(child_TestRemoteClient160);
	run receiver(child_TestRemoteClient160)
stop_process:skip
}

proctype TestRemoteClient16(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_deleteContainer3060 = [1] of {int};
	Mutexdef client_mu;
	run mutexMonitor(client_mu);
		defer1: skip;
	run deleteContainer306(client_mu,child_deleteContainer3060);
	child_deleteContainer3060?0;
	stop_process: skip;
	child!0
}
proctype deleteContainer306(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_cleanObjects3540 = [1] of {int};
	do
	:: true -> 
		for10: skip;
		

		if
		:: true -> 
			run cleanObjects354(c_mu,child_cleanObjects3540);
			child_cleanObjects3540?0;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				

				if
				:: true -> 
					goto for12_end
				:: true;
				fi;
				goto stop_process
			:: true;
			fi;
			goto stop_process
		:: true;
		fi;
		goto stop_process;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype cleanObjects354(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_objectNames5210 = [1] of {int};
	int objectNames = -2; // opt objectNames
	run objectNames521(c_mu,child_objectNames5210);
	child_objectNames5210?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype objectNames521(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int names = -2; // opt names
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

