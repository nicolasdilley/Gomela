// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc/grpc-go/blob//internal/resolver/dns/dns_resolver_test.go#L1092
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDNSResolverRetry10920 = [1] of {int};
	run TestDNSResolverRetry1092(child_TestDNSResolverRetry10920);
	run receiver(child_TestDNSResolverRetry10920)
stop_process:skip
}

proctype TestDNSResolverRetry1092(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getState695 = [1] of {int};
	chan child_getState694 = [1] of {int};
	chan child_getState693 = [1] of {int};
	chan child_getState692 = [1] of {int};
	chan child_getState691 = [1] of {int};
	chan child_getState690 = [1] of {int};
	Mutexdef cc_m1;
	run mutexMonitor(cc_m1);
	

	if
	:: 0 != -2 && 2000-1 != -3 -> 
				for(i : 0.. 2000-1) {
			for11: skip;
			run getState69(cc_m1,child_getState691);
			child_getState691?0;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run getState69(cc_m1,child_getState690);
			child_getState690?0;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: 0 != -2 && 2000-1 != -3 -> 
				for(i : 0.. 2000-1) {
			for21: skip;
			run getState69(cc_m1,child_getState693);
			child_getState693?0;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run getState69(cc_m1,child_getState692);
			child_getState692?0;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	

	if
	:: 0 != -2 && 2000-1 != -3 -> 
				for(i : 0.. 2000-1) {
			for31: skip;
			run getState69(cc_m1,child_getState695);
			child_getState695?0;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for31_end: skip
		};
		for31_exit: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			run getState69(cc_m1,child_getState694);
			child_getState694?0;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype getState69(Mutexdef t_m1;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	t_m1.Lock!false;
	goto defer1;
		defer1: skip;
	t_m1.Unlock!false;
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

