// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/syncthing/syncthing/blob/87a0eecc31a0a5eeef1d0da510f4d5832e022e1f/lib/connections/lan_test.go#L17
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestIsLANHost170 = [1] of {int};
	run TestIsLANHost17(child_TestIsLANHost170);
	run receiver(child_TestIsLANHost170)
stop_process:skip
}

proctype TestIsLANHost17(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_isLANHost5850 = [1] of {int};
	chan child_isLANHost5851 = [1] of {int};
	Mutexdef s_listenerSupervisor_m;
	Mutexdef s_listenerSupervisor_ctxMutex;
	Mutexdef s_tlsCfg_mutex;
	int var_casescases = -2; // opt var_casescases
	run mutexMonitor(s_tlsCfg_mutex);
	run mutexMonitor(s_listenerSupervisor_ctxMutex);
	run mutexMonitor(s_listenerSupervisor_m);
	

	if
	:: var_cases-1 != -3 -> 
				for(i : 0.. var_cases-1) {
			for10: skip;
			run isLANHost585(s_listenerSupervisor_ctxMutex,s_listenerSupervisor_m,s_tlsCfg_mutex,child_isLANHost5850);
			child_isLANHost5850?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for15: skip;
			run isLANHost585(s_listenerSupervisor_ctxMutex,s_listenerSupervisor_m,s_tlsCfg_mutex,child_isLANHost5851);
			child_isLANHost5851?0;
			for15_end: skip
		:: true -> 
			break
		od;
		for15_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype isLANHost585(Mutexdef s_listenerSupervisor_ctxMutex;Mutexdef s_listenerSupervisor_m;Mutexdef s_tlsCfg_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_isLAN5991 = [1] of {int};
	chan child_isLAN5990 = [1] of {int};
	

	if
	:: true -> 
		run isLAN599(s_listenerSupervisor_ctxMutex,s_listenerSupervisor_m,s_tlsCfg_mutex,child_isLAN5990);
		child_isLAN5990?0;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run isLAN599(s_listenerSupervisor_ctxMutex,s_listenerSupervisor_m,s_tlsCfg_mutex,child_isLAN5991);
		child_isLAN5991?0;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype isLAN599(Mutexdef s_listenerSupervisor_ctxMutex;Mutexdef s_listenerSupervisor_m;Mutexdef s_tlsCfg_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_lanslans = -2; // opt var_lanslans
	int var_s_cfg_Options_AlwaysLocalNetss_cfg_Options_AlwaysLocalNets = -2; // opt var_s_cfg_Options_AlwaysLocalNetss_cfg_Options_AlwaysLocalNets
	

	if
	:: true;
	:: true;
	:: true;
	:: true -> 
		goto stop_process
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

