
// https://github.com/cayleygraph/cayley/blob/master/query/gizmo/gizmo_test.go#L787
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestIssue1607870 = [1] of {int};
	run TestIssue160787(child_TestIssue1607870)
stop_process:skip
}

proctype TestIssue160787(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Execute2820 = [1] of {int};
	Mutexdef ses_sch_rulesForTypeMu;
	Mutexdef ses_ns_mu;
	Mutexdef ses_vm_vm_interruptLock;
	run mutexMonitor(ses_vm_vm_interruptLock);
	run mutexMonitor(ses_ns_mu);
	run mutexMonitor(ses_sch_rulesForTypeMu);
	run Execute282(ses_vm_vm_interruptLock,ses_ns_mu,ses_sch_rulesForTypeMu,child_Execute2820);
	child_Execute2820?0;
	stop_process: skip;
	child!0
}
proctype Execute282(Mutexdef s_vm_vm_interruptLock;Mutexdef s_ns_mu;Mutexdef s_sch_rulesForTypeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_compile2580 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	fi;
	run compile258(s_vm_vm_interruptLock,s_ns_mu,s_sch_rulesForTypeMu,child_compile2580);
	child_compile2580?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype compile258(Mutexdef s_vm_vm_interruptLock;Mutexdef s_ns_mu;Mutexdef s_sch_rulesForTypeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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

