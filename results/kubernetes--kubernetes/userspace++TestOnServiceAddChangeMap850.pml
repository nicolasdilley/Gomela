
// https://github.com/kubernetes/kubernetes/blob/master/pkg/proxy/userspace/proxier_test.go#L850
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestOnServiceAddChangeMap8500 = [1] of {int};
	run TestOnServiceAddChangeMap850(child_TestOnServiceAddChangeMap8500)
stop_process:skip
}

proctype TestOnServiceAddChangeMap850(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_serviceChange5960 = [1] of {int};
	chan child_serviceChange5961 = [1] of {int};
	chan child_serviceChange5962 = [1] of {int};
	chan child_serviceChange5963 = [1] of {int};
	Mutexdef p_serviceChangesLock;
	Mutexdef p_portMapMutex;
	Mutexdef p_mu;
	int tests = -2;
	int test_changes = -2;
	run mutexMonitor(p_mu);
	run mutexMonitor(p_portMapMutex);
	run mutexMonitor(p_serviceChangesLock);
	

	if
	:: tests-1 != -3 -> 
				for(i : 0.. tests-1) {
			for10: skip;
			

			if
			:: test_changes-1 != -3 -> 
								for(i : 0.. test_changes-1) {
					for11: skip;
					run serviceChange596(p_mu,p_portMapMutex,p_serviceChangesLock,child_serviceChange5960);
					child_serviceChange5960?0;
					for11_end: skip
				};
				for11_exit: skip
			:: else -> 
				do
				:: true -> 
					for12: skip;
					run serviceChange596(p_mu,p_portMapMutex,p_serviceChangesLock,child_serviceChange5961);
					child_serviceChange5961?0;
					for12_end: skip
				:: true -> 
					break
				od;
				for12_exit: skip
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			

			if
			:: test_changes-1 != -3 -> 
								for(i : 0.. test_changes-1) {
					for14: skip;
					run serviceChange596(p_mu,p_portMapMutex,p_serviceChangesLock,child_serviceChange5962);
					child_serviceChange5962?0;
					for14_end: skip
				};
				for14_exit: skip
			:: else -> 
				do
				:: true -> 
					for15: skip;
					run serviceChange596(p_mu,p_portMapMutex,p_serviceChangesLock,child_serviceChange5963);
					child_serviceChange5963?0;
					for15_end: skip
				:: true -> 
					break
				od;
				for15_exit: skip
			fi;
			for13_end: skip
		:: true -> 
			break
		od;
		for13_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype serviceChange596(Mutexdef proxier_mu;Mutexdef proxier_portMapMutex;Mutexdef proxier_serviceChangesLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_isInitialized3590 = [1] of {int};
	proxier_serviceChangesLock.Lock!false;
	

	if
	:: true -> 
		run isInitialized359(proxier_mu,proxier_portMapMutex,proxier_serviceChangesLock,child_isInitialized3590);
		child_isInitialized3590?0
	fi;
	stop_process: skip;
		proxier_serviceChangesLock.Unlock!false;
	child!0
}
proctype isInitialized359(Mutexdef proxier_mu;Mutexdef proxier_portMapMutex;Mutexdef proxier_serviceChangesLock;chan child) {
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

