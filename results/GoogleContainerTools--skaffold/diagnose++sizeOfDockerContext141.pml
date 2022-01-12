// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/GoogleContainerTools/skaffold/blob//pkg/skaffold/diagnose/diagnose.go#L141
#define def_var_p  -2 // opt paths line 51
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_sizeOfDockerContext1410 = [1] of {int};
	run sizeOfDockerContext141(child_sizeOfDockerContext1410);
	run receiver(child_sizeOfDockerContext1410)
stop_process:skip
}

proctype sizeOfDockerContext141(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymoussizeOfDockerContext1431420 = [1] of {int};
	Mutexdef buildCtxWriter_p_once_m;
	Mutexdef buildCtxWriter_p_wrMu;
	Mutexdef buildCtx_p_once_m;
	Mutexdef buildCtx_p_wrMu;
	run mutexMonitor(buildCtx_p_wrMu);
	run mutexMonitor(buildCtx_p_once_m);
	run mutexMonitor(buildCtxWriter_p_wrMu);
	run mutexMonitor(buildCtxWriter_p_once_m);
	run AnonymoussizeOfDockerContext143142(buildCtx_p_wrMu,buildCtx_p_once_m,buildCtxWriter_p_wrMu,buildCtxWriter_p_once_m,child_AnonymoussizeOfDockerContext1431420);
	run receiver(child_AnonymoussizeOfDockerContext1431420);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymoussizeOfDockerContext143142(Mutexdef buildCtx_p_wrMu;Mutexdef buildCtx_p_once_m;Mutexdef buildCtxWriter_p_wrMu;Mutexdef buildCtxWriter_p_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CreateDockerTarContext280 = [1] of {int};
	run CreateDockerTarContext28(buildCtxWriter_p_once_m,buildCtxWriter_p_wrMu,child_CreateDockerTarContext280);
	child_CreateDockerTarContext280?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype CreateDockerTarContext28(Mutexdef w_p_once_m;Mutexdef w_p_wrMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CreateTar510 = [1] of {int};
	int var_p = def_var_p;
	int var_paths = -2; // opt var_paths
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run CreateTar51(w_p_once_m,w_p_wrMu,var_p,child_CreateTar510);
	child_CreateTar510?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype CreateTar51(Mutexdef w_p_once_m;Mutexdef w_p_wrMu;int var_paths;chan child) {
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

