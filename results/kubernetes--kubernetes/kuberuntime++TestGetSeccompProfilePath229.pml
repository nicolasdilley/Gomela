
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/kuberuntime/helpers_test.go#L229
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetSeccompProfilePath2290 = [1] of {int};
	run TestGetSeccompProfilePath229(child_TestGetSeccompProfilePath2290)
stop_process:skip
}

proctype TestGetSeccompProfilePath229(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getSeccompProfilePath2310 = [1] of {int};
	chan child_getSeccompProfilePath2311 = [1] of {int};
	Mutexdef m_logReduction_errorMapLock;
	int tests = -2;
	run mutexMonitor(m_logReduction_errorMapLock);
	

	if
	:: tests-1 != -3 -> 
				for(i : 0.. tests-1) {
			for10: skip;
			run getSeccompProfilePath231(m_logReduction_errorMapLock,child_getSeccompProfilePath2310);
			child_getSeccompProfilePath2310?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run getSeccompProfilePath231(m_logReduction_errorMapLock,child_getSeccompProfilePath2311);
			child_getSeccompProfilePath2311?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype getSeccompProfilePath231(Mutexdef m_logReduction_errorMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
		:: true;
		fi
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

