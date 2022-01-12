// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/kubernetes/kubernetes/blob//pkg/kubelet/dockershim/network/hostport/hostport_manager_test.go#L33
#define def_var_tc_portMappings  -2 // opt hostportMappings line 322
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestOpenCloseHostports330 = [1] of {int};
	run TestOpenCloseHostports33(child_TestOpenCloseHostports330);
	run receiver(child_TestOpenCloseHostports330)
stop_process:skip
}

proctype TestOpenCloseHostports33(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_closeHostports3222 = [1] of {int};
	int var_tc_portMappings = def_var_tc_portMappings;
	chan child_closeHostports3223 = [1] of {int};
	int var_tc_portMappings = def_var_tc_portMappings;
	chan child_openHostports2820 = [1] of {int};
	chan child_openHostports2821 = [1] of {int};
	Mutexdef manager_mu;
	int var_closePortCases = -2; // opt var_closePortCases
	int var_tc_podPortMapping_PortMappings = -2; // opt var_tc_podPortMapping_PortMappings
	int var_mapping = -2; // opt var_mapping
	int var_openPortCases = -2; // opt var_openPortCases
	run mutexMonitor(manager_mu);
	

	if
	:: var_openPortCases-1 != -3 -> 
				for(i : 0.. var_openPortCases-1) {
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
	:: var_closePortCases-1 != -3 -> 
				for(i : 0.. var_closePortCases-1) {
			for20: skip;
			run closeHostports322(manager_mu,var_tc_portMappings,child_closeHostports3222);
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
			run closeHostports322(manager_mu,var_tc_portMappings,child_closeHostports3223);
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
	int var_ports = -2; // opt var_ports
	int var_podPortMapping_PortMappings = -2; // opt var_podPortMapping_PortMappings
	

	if
	:: var_podPortMapping_PortMappings-1 != -3 -> 
				for(i : 0.. var_podPortMapping_PortMappings-1) {
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
proctype closeHostports322(Mutexdef hm_mu;int var_hostportMappings;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getIPFamily3412 = [1] of {int};
	chan child_getIPFamily3413 = [1] of {int};
	

	if
	:: var_hostportMappings-1 != -3 -> 
				for(i : 0.. var_hostportMappings-1) {
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

proctype receiver(chan c) {
c?0
}

