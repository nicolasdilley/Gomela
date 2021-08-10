// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-gitea/gitea/blob/ed393779004335a0afcca0dfac48937db41fabd6/modules/log/file_test.go#L152
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCompressFileLogger1520 = [1] of {int};
	run TestCompressFileLogger152(child_TestCompressFileLogger1520);
	run receiver(child_TestCompressFileLogger1520)
stop_process:skip
}

proctype TestCompressFileLogger152(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DoRotate1570 = [1] of {int};
	Mutexdef realFileLogger_startLock;
	Mutexdef realFileLogger_mw_mu;
	run mutexMonitor(realFileLogger_mw_mu);
	run mutexMonitor(realFileLogger_startLock);
	run DoRotate157(realFileLogger_mw_mu,realFileLogger_startLock,child_DoRotate1570);
	child_DoRotate1570?0;
	stop_process: skip;
	child!0
}
proctype DoRotate157(Mutexdef log_mw_mu;Mutexdef log_startLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_deleteOldLog2271 = [1] of {int};
	chan child_StartLogger1170 = [1] of {int};
	

	if
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
		run StartLogger117(log_mw_mu,log_startLock,child_StartLogger1170);
		child_StartLogger1170?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run deleteOldLog227(log_mw_mu,log_startLock,child_deleteOldLog2271);
		run receiver(child_deleteOldLog2271)
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype StartLogger117(Mutexdef log_mw_mu;Mutexdef log_startLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_initFd1442 = [1] of {int};
	chan child_SetFd681 = [1] of {int};
	chan child_createLogFile1390 = [1] of {int};
	run createLogFile139(log_mw_mu,log_startLock,child_createLogFile1390);
	child_createLogFile1390?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run SetFd68(log_mw_mu,child_SetFd681);
	child_SetFd681?0;
	run initFd144(log_mw_mu,log_startLock,child_initFd1442);
	child_initFd1442?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype createLogFile139(Mutexdef log_mw_mu;Mutexdef log_startLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SetFd68(Mutexdef mw_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype initFd144(Mutexdef log_mw_mu;Mutexdef log_startLock;chan child) {
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
proctype deleteOldLog227(Mutexdef log_mw_mu;Mutexdef log_startLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

