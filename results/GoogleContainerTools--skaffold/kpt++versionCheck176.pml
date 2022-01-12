// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/GoogleContainerTools/skaffold/blob//pkg/skaffold/deploy/kpt/kpt.go#L176
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_versionCheck1760 = [1] of {int};
	run versionCheck176(child_versionCheck1760);
	run receiver(child_versionCheck1760)
stop_process:skip
}

proctype versionCheck176(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RunCmdOut601 = [1] of {int};
	Mutexdef kustomizeCmd_Process_sigMu;
	chan child_RunCmdOut600 = [1] of {int};
	Mutexdef kptCmd_Process_sigMu;
	run mutexMonitor(kptCmd_Process_sigMu);
	run RunCmdOut60(kptCmd_Process_sigMu,child_RunCmdOut600);
	child_RunCmdOut600?0;
	

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
		run mutexMonitor(kustomizeCmd_Process_sigMu);
		run RunCmdOut60(kustomizeCmd_Process_sigMu,child_RunCmdOut601);
		child_RunCmdOut601?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype RunCmdOut60(Mutexdef cmd_Process_sigMu;chan child) {
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

