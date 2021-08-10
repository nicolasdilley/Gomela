// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/labstack/echo/blob/643066594d00891e3151c7ed87244bfeddcd57b9/context_test.go#L499
#define not_found_502  -2 // opt path line 65
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextGetAndSetParam4990 = [1] of {int};
	run TestContextGetAndSetParam499(child_TestContextGetAndSetParam4990);
	run receiver(child_TestContextGetAndSetParam4990)
stop_process:skip
}

proctype TestContextGetAndSetParam499(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewContext3292 = [1] of {int};
	chan child_Add651 = [1] of {int};
	chan child_Router3410 = [1] of {int};
	Mutexdef r_echo_startupMutex;
	Mutexdef e_AutoTLSManager_challengeMu;
	Mutexdef e_AutoTLSManager_renewalMu;
	Mutexdef e_AutoTLSManager_stateMu;
	Mutexdef e_AutoTLSManager_clientMu;
	Mutexdef e_TLSServer_mu;
	Mutexdef e_Server_mu;
	Mutexdef e_StdLogger_mu;
	Mutexdef e_startupMutex;
	run mutexMonitor(e_startupMutex);
	run mutexMonitor(e_StdLogger_mu);
	run mutexMonitor(e_Server_mu);
	run mutexMonitor(e_TLSServer_mu);
	run mutexMonitor(e_AutoTLSManager_clientMu);
	run mutexMonitor(e_AutoTLSManager_stateMu);
	run mutexMonitor(e_AutoTLSManager_renewalMu);
	run mutexMonitor(e_AutoTLSManager_challengeMu);
	run mutexMonitor(r_echo_startupMutex);
	run Router341(e_AutoTLSManager_challengeMu,e_AutoTLSManager_clientMu,e_AutoTLSManager_renewalMu,e_AutoTLSManager_stateMu,e_Server_mu,e_StdLogger_mu,e_startupMutex,e_TLSServer_mu,child_Router3410);
	child_Router3410?0;
	run Add65(r_echo_startupMutex,not_found_502,child_Add651);
	child_Add651?0;
	run NewContext329(e_AutoTLSManager_challengeMu,e_AutoTLSManager_clientMu,e_AutoTLSManager_renewalMu,e_AutoTLSManager_stateMu,e_Server_mu,e_StdLogger_mu,e_startupMutex,e_TLSServer_mu,child_NewContext3292);
	child_NewContext3292?0;
	stop_process: skip;
	child!0
}
proctype Router341(Mutexdef e_AutoTLSManager_challengeMu;Mutexdef e_AutoTLSManager_clientMu;Mutexdef e_AutoTLSManager_renewalMu;Mutexdef e_AutoTLSManager_stateMu;Mutexdef e_Server_mu;Mutexdef e_StdLogger_mu;Mutexdef e_startupMutex;Mutexdef e_TLSServer_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Add65(Mutexdef r_echo_startupMutex;int var_path;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_insert10311 = [1] of {int};
	chan child_insert1037 = [1] of {int};
	chan child_insert1038 = [1] of {int};
	chan child_insert1036 = [1] of {int};
	chan child_insert10310 = [1] of {int};
	chan child_insert1039 = [1] of {int};
	chan child_insert1032 = [1] of {int};
	chan child_insert1033 = [1] of {int};
	chan child_insert1031 = [1] of {int};
	chan child_insert1035 = [1] of {int};
	chan child_insert1034 = [1] of {int};
	int var_lcpIndex = -2; // opt var_lcpIndex
	

	if
	:: 0 != -2 && var_lcpIndex-1 != -3 -> 
				for(i : 0.. var_lcpIndex-1) {
			for113: skip;
			

			if
			:: true -> 
				run insert103(r_echo_startupMutex,child_insert1036);
				child_insert1036?0;
				

				if
				:: true -> 
					run insert103(r_echo_startupMutex,child_insert1037);
					child_insert1037?0
				:: true -> 
					run insert103(r_echo_startupMutex,child_insert1038);
					child_insert1038?0
				fi
			:: true -> 
				

				if
				:: true -> 
					run insert103(r_echo_startupMutex,child_insert1039);
					child_insert1039?0;
					run insert103(r_echo_startupMutex,child_insert10310);
					child_insert10310?0
				:: true;
				fi
			fi;
			for113_end: skip
		};
		for113_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: true -> 
				run insert103(r_echo_startupMutex,child_insert1031);
				child_insert1031?0;
				

				if
				:: true -> 
					run insert103(r_echo_startupMutex,child_insert1032);
					child_insert1032?0
				:: true -> 
					run insert103(r_echo_startupMutex,child_insert1033);
					child_insert1033?0
				fi
			:: true -> 
				

				if
				:: true -> 
					run insert103(r_echo_startupMutex,child_insert1034);
					child_insert1034?0;
					run insert103(r_echo_startupMutex,child_insert1035);
					child_insert1035?0
				:: true;
				fi
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run insert103(r_echo_startupMutex,child_insert10311);
	child_insert10311?0;
	stop_process: skip;
	child!0
}
proctype insert103(Mutexdef r_echo_startupMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_currentNode_staticChildren = -2; // opt var_currentNode_staticChildren
	stop_process: skip;
	child!0
}
proctype NewContext329(Mutexdef e_AutoTLSManager_challengeMu;Mutexdef e_AutoTLSManager_clientMu;Mutexdef e_AutoTLSManager_renewalMu;Mutexdef e_AutoTLSManager_stateMu;Mutexdef e_Server_mu;Mutexdef e_StdLogger_mu;Mutexdef e_startupMutex;Mutexdef e_TLSServer_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

