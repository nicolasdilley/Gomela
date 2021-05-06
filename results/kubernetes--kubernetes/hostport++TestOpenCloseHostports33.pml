#define not_found_222  -2

// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/dockershim/network/hostport/hostport_manager_test.go#L33
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestOpenCloseHostports330 = [1] of {int};
	run TestOpenCloseHostports33(child_TestOpenCloseHostports330)
stop_process:skip
}

proctype TestOpenCloseHostports33(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_closeHostports3222 = [1] of {int};
	chan child_closeHostports3223 = [1] of {int};
	chan child_openHostports2820 = [1] of {int};
	chan child_openHostports2821 = [1] of {int};
	Mutexdef manager_mu;
	int openPortCases = -2;
	int closePortCases = -2;
	run mutexMonitor(manager_mu);
	

	if
	:: openPortCases-1 != -3 -> 
				for(i : 0.. openPortCases-1) {
			for10: skip;
			run openHostports282(manager_mu,child_openHostports2820);
			child_openHostports2820?0;
			

			if
			:: true -> 
				goto for16_end
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for19: skip;
			run openHostports282(manager_mu,child_openHostports2821);
			child_openHostports2821?0;
			

			if
			:: true -> 
				goto for111_end
			:: true;
			fi;
			for19_end: skip
		:: true -> 
			break
		od;
		for19_exit: skip
	fi;
	

	if
	:: closePortCases-1 != -3 -> 
				for(i : 0.. closePortCases-1) {
			for20: skip;
			run closeHostports322(manager_mu,not_found_222,child_closeHostports3222);
			child_closeHostports3222?0;
			

			if
			:: true -> 
				goto for22_end
			:: true;
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for23: skip;
			run closeHostports322(manager_mu,not_found_222,child_closeHostports3223);
			child_closeHostports3223?0;
			

			if
			:: true -> 
				goto for23_end
			:: true;
			fi;
			for23_end: skip
		:: true -> 
			break
		od;
		for23_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype openHostports282(Mutexdef hm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getIPFamily3410 = [1] of {int};
	chan child_getIPFamily3411 = [1] of {int};
	int podPortMapping_PortMappings = -2;
	

	if
	:: podPortMapping_PortMappings-1 != -3 -> 
				for(i : 0.. podPortMapping_PortMappings-1) {
			for11: skip;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			run getIPFamily341(hm_mu,child_getIPFamily3410);
			child_getIPFamily3410?0;
			

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
			for12: skip;
			

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
			

			if
			:: true -> 
				goto for12_end
			:: true;
			fi;
			run getIPFamily341(hm_mu,child_getIPFamily3411);
			child_getIPFamily3411?0;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for12_end: skip
		:: true -> 
			break
		od;
		for12_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getIPFamily341(Mutexdef hm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype closeHostports322(Mutexdef hm_mu;int hostportMappings;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getIPFamily3412 = [1] of {int};
	chan child_getIPFamily3413 = [1] of {int};
	

	if
	:: hostportMappings-1 != -3 -> 
				for(i : 0.. hostportMappings-1) {
			for21: skip;
			run getIPFamily341(hm_mu,child_getIPFamily3412);
			child_getIPFamily3412?0;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto for21_end
				:: true;
				fi
			fi;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for22: skip;
			run getIPFamily341(hm_mu,child_getIPFamily3413);
			child_getIPFamily3413?0;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto for22_end
				:: true;
				fi
			fi;
			for22_end: skip
		:: true -> 
			break
		od;
		for22_exit: skip
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

