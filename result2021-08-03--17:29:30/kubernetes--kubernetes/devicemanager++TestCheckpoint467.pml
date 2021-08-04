// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/kubelet/cm/devicemanager/manager_test.go#L467
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCheckpoint4670 = [1] of {int};
	run TestCheckpoint467(child_TestCheckpoint4670);
	run receiver(child_TestCheckpoint4670)
stop_process:skip
}

proctype TestCheckpoint467(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_readCheckpoint5931 = [1] of {int};
	chan child_writeCheckpoint5730 = [1] of {int};
	Wgdef testManager_wg;
	Wgdef testManager_server_serveWG;
	Mutexdef testManager_server_mu;
	Mutexdef testManager_mutex;
	int var_resources = -2; // opt var_resources
	int var_containerDevices = -2; // opt var_containerDevices
	int var_expectedPodDevices_devs = -2; // opt var_expectedPodDevices_devs
	run mutexMonitor(testManager_mutex);
	run mutexMonitor(testManager_server_mu);
	run wgMonitor(testManager_server_serveWG);
	run wgMonitor(testManager_wg);
	run writeCheckpoint573(testManager_server_serveWG,testManager_wg,testManager_mutex,testManager_server_mu,child_writeCheckpoint5730);
	child_writeCheckpoint5730?0;
	run readCheckpoint593(testManager_server_serveWG,testManager_wg,testManager_mutex,testManager_server_mu,child_readCheckpoint5931);
	child_readCheckpoint5931?0;
	stop_process: skip;
	child!0
}
proctype writeCheckpoint573(Wgdef m_server_serveWG;Wgdef m_wg;Mutexdef m_mutex;Mutexdef m_server_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_m_healthyDevices = -2; // opt var_m_healthyDevices
	m_mutex.Lock!false;
	m_mutex.Unlock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype readCheckpoint593(Wgdef m_server_serveWG;Wgdef m_wg;Mutexdef m_mutex;Mutexdef m_server_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_registeredDevs = -2; // opt var_registeredDevs
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	m_mutex.Lock!false;
	goto defer1;
		defer1: skip;
	m_mutex.Unlock!false;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

