// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/dnsclient_unix_test.go#L115
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSpecialDomainName1150 = [1] of {int};
	run TestSpecialDomainName115(child_TestSpecialDomainName1150);
	run receiver(child_TestSpecialDomainName1150)
stop_process:skip
}

proctype TestSpecialDomainName115(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_exchange1410 = [1] of {int};
	chan child_exchange1411 = [1] of {int};
	Mutexdef r_lookupGroup_mu;
	int var_specialDomainNameTestsspecialDomainNameTests = -2; // opt var_specialDomainNameTestsspecialDomainNameTests
	run mutexMonitor(r_lookupGroup_mu);
	

	if
	:: var_specialDomainNameTests-1 != -3 -> 
				for(i : 0.. var_specialDomainNameTests-1) {
			for10: skip;
			run exchange141(r_lookupGroup_mu,child_exchange1410);
			child_exchange1410?0;
			

			if
			:: true -> 
				goto for12_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for12_end
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			run exchange141(r_lookupGroup_mu,child_exchange1411);
			child_exchange1411?0;
			

			if
			:: true -> 
				goto for13_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for13_end
			:: true;
			fi;
			for13_end: skip
		:: true -> 
			break
		od;
		for13_exit: skip
	fi;
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
			for11: skip;
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
				goto for11_end
			:: true;
			fi;
			goto stop_process;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for12: skip;
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
				goto for12_end
			:: true;
			fi;
			goto stop_process;
			for12_end: skip
		:: true -> 
			break
		od;
		for12_exit: skip
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

