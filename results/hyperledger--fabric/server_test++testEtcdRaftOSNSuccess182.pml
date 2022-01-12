// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//orderer/common/server/etcdraft_test.go#L182
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testEtcdRaftOSNSuccess1820 = [1] of {int};
	run testEtcdRaftOSNSuccess182(child_testEtcdRaftOSNSuccess1820);
	run receiver(child_testEtcdRaftOSNSuccess1820)
stop_process:skip
}

proctype testEtcdRaftOSNSuccess182(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ordererProcess_lock;
	Mutexdef ordererProcess_Err_lock;
	Mutexdef ordererProcess_Out_lock;
	Mutexdef ordererProcess_Command_Process_sigMu;
	run mutexMonitor(ordererProcess_Command_Process_sigMu);
	run mutexMonitor(ordererProcess_Out_lock);
	run mutexMonitor(ordererProcess_Err_lock);
	run mutexMonitor(ordererProcess_lock);
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

