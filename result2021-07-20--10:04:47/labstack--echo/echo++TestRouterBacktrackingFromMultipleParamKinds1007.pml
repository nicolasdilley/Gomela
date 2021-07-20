// num_comm_params=6
// num_mand_comm_params=0
// num_opt_comm_params=6

// git_link=https://github.com/labstack/echo/blob/643066594d00891e3151c7ed87244bfeddcd57b9/router_test.go#L1007
#define not_found_1011  -2 // opt path line 83
#define not_found_1012  -2 // opt path line 83
#define not_found_1013  -2 // opt path line 83
#define not_found_1014  -2 // opt path line 83
#define not_found_1015  -2 // opt path line 83
#define not_found_1016  -2 // opt path line 83
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRouterBacktrackingFromMultipleParamKinds10070 = [1] of {int};
	run TestRouterBacktrackingFromMultipleParamKinds1007(child_TestRouterBacktrackingFromMultipleParamKinds10070);
	run receiver(child_TestRouterBacktrackingFromMultipleParamKinds10070)
stop_process:skip
}

proctype TestRouterBacktrackingFromMultipleParamKinds1007(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewContext3296 = [1] of {int};
	Mutexdef c_lock;
	Mutexdef c_echo_startupMutex;
	chan child_Add835 = [1] of {int};
	chan child_Add834 = [1] of {int};
	chan child_Add833 = [1] of {int};
	chan child_Add832 = [1] of {int};
	chan child_Add831 = [1] of {int};
	chan child_Add830 = [1] of {int};
	Mutexdef r_echo_startupMutex;
	Mutexdef e_AutoTLSManager_challengeMu;
	Mutexdef e_AutoTLSManager_renewalMu;
	Mutexdef e_AutoTLSManager_stateMu;
	Mutexdef e_AutoTLSManager_clientMu;
	Mutexdef e_TLSServer_mu;
	Mutexdef e_Server_mu;
	Mutexdef e_StdLogger_mu;
	Mutexdef e_startupMutex;
	int var_tc_expectParamtc_expectParam = -2; // opt var_tc_expectParamtc_expectParam
	int var_testCasestestCases = -2; // opt var_testCasestestCases
	run mutexMonitor(e_startupMutex);
	run mutexMonitor(e_StdLogger_mu);
	run mutexMonitor(e_Server_mu);
	run mutexMonitor(e_TLSServer_mu);
	run mutexMonitor(e_AutoTLSManager_clientMu);
	run mutexMonitor(e_AutoTLSManager_stateMu);
	run mutexMonitor(e_AutoTLSManager_renewalMu);
	run mutexMonitor(e_AutoTLSManager_challengeMu);
	run mutexMonitor(r_echo_startupMutex);
	run Add83(r_echo_startupMutex,not_found_1011,child_Add830);
	child_Add830?0;
	run Add83(r_echo_startupMutex,not_found_1012,child_Add831);
	child_Add831?0;
	run Add83(r_echo_startupMutex,not_found_1013,child_Add832);
	child_Add832?0;
	run Add83(r_echo_startupMutex,not_found_1014,child_Add833);
	child_Add833?0;
	run Add83(r_echo_startupMutex,not_found_1015,child_Add834);
	child_Add834?0;
	run Add83(r_echo_startupMutex,not_found_1016,child_Add835);
	child_Add835?0;
	run mutexMonitor(c_echo_startupMutex);
	run mutexMonitor(c_lock);
	run NewContext329(e_AutoTLSManager_challengeMu,e_AutoTLSManager_clientMu,e_AutoTLSManager_renewalMu,e_AutoTLSManager_stateMu,e_Server_mu,e_StdLogger_mu,e_startupMutex,e_TLSServer_mu,child_NewContext3296);
	child_NewContext3296?0;
	stop_process: skip;
	child!0
}
proctype Add83(Mutexdef r_echo_startupMutex;int path;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_insert12710 = [1] of {int};
	chan child_insert1276 = [1] of {int};
	chan child_insert1277 = [1] of {int};
	chan child_insert1275 = [1] of {int};
	chan child_insert1279 = [1] of {int};
	chan child_insert1278 = [1] of {int};
	chan child_insert1271 = [1] of {int};
	chan child_insert1272 = [1] of {int};
	chan child_insert1270 = [1] of {int};
	chan child_insert1274 = [1] of {int};
	chan child_insert1273 = [1] of {int};
	int var_lcpIndexlcpIndex = -2; // opt var_lcpIndexlcpIndex
	

	if
	:: 0 != -2 && var_lcpIndex-1 != -3 -> 
				for(i : 0.. var_lcpIndex-1) {
			for113: skip;
			

			if
			:: true -> 
				run insert127(r_echo_startupMutex,child_insert1275);
				child_insert1275?0;
				

				if
				:: true -> 
					run insert127(r_echo_startupMutex,child_insert1276);
					child_insert1276?0
				:: true -> 
					run insert127(r_echo_startupMutex,child_insert1277);
					child_insert1277?0
				fi
			:: true -> 
				

				if
				:: true -> 
					run insert127(r_echo_startupMutex,child_insert1278);
					child_insert1278?0;
					run insert127(r_echo_startupMutex,child_insert1279);
					child_insert1279?0
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
				run insert127(r_echo_startupMutex,child_insert1270);
				child_insert1270?0;
				

				if
				:: true -> 
					run insert127(r_echo_startupMutex,child_insert1271);
					child_insert1271?0
				:: true -> 
					run insert127(r_echo_startupMutex,child_insert1272);
					child_insert1272?0
				fi
			:: true -> 
				

				if
				:: true -> 
					run insert127(r_echo_startupMutex,child_insert1273);
					child_insert1273?0;
					run insert127(r_echo_startupMutex,child_insert1274);
					child_insert1274?0
				:: true;
				fi
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run insert127(r_echo_startupMutex,child_insert12710);
	child_insert12710?0;
	stop_process: skip;
	child!0
}
proctype insert127(Mutexdef r_echo_startupMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_currentNode_staticChildrencurrentNode_staticChildren = -2; // opt var_currentNode_staticChildrencurrentNode_staticChildren
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

