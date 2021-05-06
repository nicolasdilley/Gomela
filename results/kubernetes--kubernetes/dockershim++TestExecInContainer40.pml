#define TestExecInContainer_testcases  3

// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/dockershim/exec_test.go#L40
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestExecInContainer400 = [1] of {int};
	run TestExecInContainer40(child_TestExecInContainer400)
stop_process:skip
}

proctype TestExecInContainer40(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ctrl_mu;
	int testcases = TestExecInContainer_testcases;
	run mutexMonitor(ctrl_mu);
	for10_exit: skip;
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

