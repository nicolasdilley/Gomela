// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/dnsclient_unix_test.go#L1730
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDNSUseTCP17300 = [1] of {int};
	run TestDNSUseTCP1730(child_TestDNSUseTCP17300);
	run receiver(child_TestDNSUseTCP17300)
stop_process:skip
}

proctype TestDNSUseTCP1730(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_exchange1410 = [1] of {int};
	Mutexdef r_lookupGroup_mu;
	run mutexMonitor(r_lookupGroup_mu);
	run exchange141(r_lookupGroup_mu,child_exchange1410);
	child_exchange1410?0;
	stop_process: skip;
	child!0
}
proctype exchange141(Mutexdef r_lookupGroup_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_dial590 = [1] of {int};
	chan child_dial591 = [1] of {int};
	int var_networksnetworks = -2; // opt var_networksnetworks
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: var_networks-1 != -3 -> 
				for(i : 0.. var_networks-1) {
			for10: skip;
			run dial59(r_lookupGroup_mu,child_dial590);
			child_dial590?0;
			

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
				goto for10_end
			:: true;
			fi;
			goto stop_process;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run dial59(r_lookupGroup_mu,child_dial591);
			child_dial591?0;
			

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
				goto for11_end
			:: true;
			fi;
			goto stop_process;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype dial59(Mutexdef r_lookupGroup_mu;chan child) {
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

