// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pilot/pkg/networking/core/v1alpha3/listener.go#L931
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_buildSidecarOutboundListenerForPortOrUDS9310 = [1] of {int};
	run buildSidecarOutboundListenerForPortOrUDS931(child_buildSidecarOutboundListenerForPortOrUDS9310);
	run receiver(child_buildSidecarOutboundListenerForPortOrUDS9310)
stop_process:skip
}

proctype buildSidecarOutboundListenerForPortOrUDS931(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef pluginParams_Push_initializeMutex;
	Mutexdef pluginParams_Push_networksMu;
	Mutexdef pluginParams_Push_proxyStatusMutex;
	int var_configgen_Plugins = -2; // opt var_configgen_Plugins
	int var_opts = -2; // opt var_opts
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true -> 
					

					if
					:: true -> 
						goto stop_process
					fi
				fi
			:: true;
			fi
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			

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
				

				if
				:: true -> 
					

					if
					:: true -> 
						goto stop_process
					fi
				fi
			:: true;
			fi
		:: true -> 
			goto stop_process
		fi
	fi;
	run mutexMonitor(pluginParams_Push_proxyStatusMutex);
	run mutexMonitor(pluginParams_Push_networksMu);
	run mutexMonitor(pluginParams_Push_initializeMutex);
	

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
	:: true;
	:: true;
	:: true;
	:: true;
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

