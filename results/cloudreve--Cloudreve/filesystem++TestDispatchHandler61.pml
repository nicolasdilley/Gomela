// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/cloudreve/Cloudreve/blob//pkg/filesystem/filesystem_test.go#L61
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDispatchHandler610 = [1] of {int};
	run TestDispatchHandler61(child_TestDispatchHandler610);
	run receiver(child_TestDispatchHandler610)
stop_process:skip
}

proctype TestDispatchHandler61(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DispatchHandler1639 = [1] of {int};
	chan child_DispatchHandler1638 = [1] of {int};
	chan child_DispatchHandler1637 = [1] of {int};
	chan child_DispatchHandler1636 = [1] of {int};
	chan child_DispatchHandler1635 = [1] of {int};
	chan child_DispatchHandler1634 = [1] of {int};
	chan child_DispatchHandler1633 = [1] of {int};
	chan child_DispatchHandler1632 = [1] of {int};
	chan child_DispatchHandler1631 = [1] of {int};
	chan child_DispatchHandler1630 = [1] of {int};
	Mutexdef fs_recycleLock;
	Mutexdef fs_Lock;
	run mutexMonitor(fs_Lock);
	run mutexMonitor(fs_recycleLock);
	run DispatchHandler163(fs_Lock,fs_recycleLock,child_DispatchHandler1630);
	child_DispatchHandler1630?0;
	run DispatchHandler163(fs_Lock,fs_recycleLock,child_DispatchHandler1631);
	child_DispatchHandler1631?0;
	run DispatchHandler163(fs_Lock,fs_recycleLock,child_DispatchHandler1632);
	child_DispatchHandler1632?0;
	run DispatchHandler163(fs_Lock,fs_recycleLock,child_DispatchHandler1633);
	child_DispatchHandler1633?0;
	run DispatchHandler163(fs_Lock,fs_recycleLock,child_DispatchHandler1634);
	child_DispatchHandler1634?0;
	run DispatchHandler163(fs_Lock,fs_recycleLock,child_DispatchHandler1635);
	child_DispatchHandler1635?0;
	run DispatchHandler163(fs_Lock,fs_recycleLock,child_DispatchHandler1636);
	child_DispatchHandler1636?0;
	run DispatchHandler163(fs_Lock,fs_recycleLock,child_DispatchHandler1637);
	child_DispatchHandler1637?0;
	run DispatchHandler163(fs_Lock,fs_recycleLock,child_DispatchHandler1638);
	child_DispatchHandler1638?0;
	run DispatchHandler163(fs_Lock,fs_recycleLock,child_DispatchHandler1639);
	child_DispatchHandler1639?0;
	stop_process: skip;
	child!0
}
proctype DispatchHandler163(Mutexdef fs_Lock;Mutexdef fs_recycleLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
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

