// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/kubernetes/minikube/blob/ce01c06fef829245cf1b940ca59cc55f4fc9c658/pkg/minikube/command/fake_runner_test.go#L26
#define not_found_31  -2 // opt cmdToOutput line 159
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFakeRunnerFile260 = [1] of {int};
	run TestFakeRunnerFile26(child_TestFakeRunnerFile260);
	run receiver(child_TestFakeRunnerFile260)
stop_process:skip
}

proctype TestFakeRunnerFile26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetCommandToOutput1590 = [1] of {int};
	Mutexdef fakeCommandRunner_fileMap_mu;
	Mutexdef fakeCommandRunner_cmdMap_mu;
	run mutexMonitor(fakeCommandRunner_cmdMap_mu);
	run mutexMonitor(fakeCommandRunner_fileMap_mu);
	run SetCommandToOutput159(fakeCommandRunner_cmdMap_mu,fakeCommandRunner_fileMap_mu,not_found_31,child_SetCommandToOutput1590);
	child_SetCommandToOutput1590?0;
	stop_process: skip;
	child!0
}
proctype SetCommandToOutput159(Mutexdef f_cmdMap_mu;Mutexdef f_fileMap_mu;int cmdToOutput;chan child) {
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

