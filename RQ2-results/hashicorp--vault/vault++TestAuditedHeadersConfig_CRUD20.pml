
// https://github.com/hashicorp/vault/blob/master/vault/audited_headers_test.go#L20
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAuditedHeadersConfig_CRUD200 = [1] of {int};
	run TestAuditedHeadersConfig_CRUD20(child_TestAuditedHeadersConfig_CRUD200)
stop_process:skip
}

proctype TestAuditedHeadersConfig_CRUD20(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_testAuditedHeadersConfig_Remove971 = [1] of {int};
	chan child_testAuditedHeadersConfig_Add270 = [1] of {int};
	Mutexdef conf_view_readOnlyErrLock;
	run mutexMonitor(conf_view_readOnlyErrLock);
	run testAuditedHeadersConfig_Add27(conf_view_readOnlyErrLock,child_testAuditedHeadersConfig_Add270);
	child_testAuditedHeadersConfig_Add270?0;
	run testAuditedHeadersConfig_Remove97(conf_view_readOnlyErrLock,child_testAuditedHeadersConfig_Remove971);
	child_testAuditedHeadersConfig_Remove971?0;
	stop_process: skip;
	child!0
}
proctype testAuditedHeadersConfig_Add27(Mutexdef conf_view_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get573 = [1] of {int};
	chan child_add372 = [1] of {int};
	chan child_Get571 = [1] of {int};
	chan child_add370 = [1] of {int};
	run add37(conf_view_readOnlyErrLock,child_add370);
	child_add370?0;
	run Get57(conf_view_readOnlyErrLock,child_Get571);
	child_Get571?0;
	run add37(conf_view_readOnlyErrLock,child_add372);
	child_add372?0;
	run Get57(conf_view_readOnlyErrLock,child_Get573);
	child_Get573?0;
	stop_process: skip;
	child!0
}
proctype add37(Mutexdef a_view_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Put620 = [1] of {int};
	

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
	run Put62(a_view_readOnlyErrLock,child_Put620);
	child_Put620?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Put62(Mutexdef v_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runICheck51 = [1] of {int};
	chan child_getReadOnlyErr430 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getReadOnlyErr43(v_readOnlyErrLock,child_getReadOnlyErr430);
	child_getReadOnlyErr430?0;
	

	if
	:: true -> 
		run runICheck5(v_readOnlyErrLock,child_runICheck51);
		child_runICheck51?0;
		

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
proctype getReadOnlyErr43(Mutexdef v_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	v_readOnlyErrLock.RLock!false;
	goto stop_process;
	stop_process: skip;
		v_readOnlyErrLock.RUnlock!false;
	child!0
}
proctype runICheck5(Mutexdef v_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Get57(Mutexdef v_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testAuditedHeadersConfig_Remove97(Mutexdef conf_view_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get574 = [1] of {int};
	chan child_remove643 = [1] of {int};
	chan child_Get572 = [1] of {int};
	chan child_remove641 = [1] of {int};
	run remove64(conf_view_readOnlyErrLock,child_remove641);
	child_remove641?0;
	run Get57(conf_view_readOnlyErrLock,child_Get572);
	child_Get572?0;
	run remove64(conf_view_readOnlyErrLock,child_remove643);
	child_remove643?0;
	run Get57(conf_view_readOnlyErrLock,child_Get574);
	child_Get574?0;
	stop_process: skip;
	child!0
}
proctype remove64(Mutexdef a_view_readOnlyErrLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Put621 = [1] of {int};
	

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
	run Put62(a_view_readOnlyErrLock,child_Put621);
	child_Put621?0;
	

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

