// num_comm_params=4
// num_mand_comm_params=0
// num_opt_comm_params=4

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/kubelet/cm/devicemanager/manager_test.go#L295
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
	chan child_TestUpdateCapacityAllocatable2950 = [1] of {int};
	run TestUpdateCapacityAllocatable295(child_TestUpdateCapacityAllocatable2950);
	run receiver(child_TestUpdateCapacityAllocatable2950)
stop_process:skip
}

proctype TestUpdateCapacityAllocatable295(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_isDevicePluginResource105615 = [1] of {int};
	chan child_GetCapacity52214 = [1] of {int};
	chan child_readCheckpoint59313 = [1] of {int};
	chan child_writeCheckpoint57312 = [1] of {int};
	chan child_GetCapacity52211 = [1] of {int};
	chan child_markResourceUnhealthy49710 = [1] of {int};
	chan child_preStartContainer1719 = [1] of {int};
	chan child_allocate1598 = [1] of {int};
	chan child_stop1827 = [1] of {int};
	chan child_GetCapacity5226 = [1] of {int};
	chan child_setStopTime1365 = [1] of {int};
	chan child_GetCapacity5224 = [1] of {int};
	Mutexdef e2_mutex;
	Mutexdef e2_clientConn_mu;
	chan child_GetCapacity5223 = [1] of {int};
	chan child_GetCapacity5222 = [1] of {int};
	chan child_GetCapacity5221 = [1] of {int};
	chan child_GetCapacity5220 = [1] of {int};
	Mutexdef e1_mutex;
	Mutexdef e1_clientConn_mu;
	Wgdef testManager_wg;
	Wgdef testManager_server_serveWG;
	Mutexdef testManager_server_mu;
	Mutexdef testManager_mutex;
	run mutexMonitor(testManager_mutex);
	run mutexMonitor(testManager_server_mu);
	run wgMonitor(testManager_server_serveWG);
	run wgMonitor(testManager_wg);
	run mutexMonitor(e1_clientConn_mu);
	run mutexMonitor(e1_mutex);
	run GetCapacity522(testManager_server_serveWG,testManager_wg,testManager_mutex,testManager_server_mu,child_GetCapacity5220);
	child_GetCapacity5220?0;
	run GetCapacity522(testManager_server_serveWG,testManager_wg,testManager_mutex,testManager_server_mu,child_GetCapacity5221);
	child_GetCapacity5221?0;
	run GetCapacity522(testManager_server_serveWG,testManager_wg,testManager_mutex,testManager_server_mu,child_GetCapacity5222);
	child_GetCapacity5222?0;
	run GetCapacity522(testManager_server_serveWG,testManager_wg,testManager_mutex,testManager_server_mu,child_GetCapacity5223);
	child_GetCapacity5223?0;
	run mutexMonitor(e2_clientConn_mu);
	run mutexMonitor(e2_mutex);
	run GetCapacity522(testManager_server_serveWG,testManager_wg,testManager_mutex,testManager_server_mu,child_GetCapacity5224);
	child_GetCapacity5224?0;
	run setStopTime136(e1_clientConn_mu,e1_mutex,child_setStopTime1365);
	child_setStopTime1365?0;
	run GetCapacity522(testManager_server_serveWG,testManager_wg,testManager_mutex,testManager_server_mu,child_GetCapacity5226);
	child_GetCapacity5226?0;
	run stop182(e2_clientConn_mu,e2_mutex,child_stop1827);
	child_stop1827?0;
	run allocate159(e2_clientConn_mu,e2_mutex,child_allocate1598);
	child_allocate1598?0;
	run preStartContainer171(e2_clientConn_mu,e2_mutex,child_preStartContainer1719);
	child_preStartContainer1719?0;
	run markResourceUnhealthy497(testManager_server_serveWG,testManager_wg,testManager_mutex,testManager_server_mu,child_markResourceUnhealthy49710);
	child_markResourceUnhealthy49710?0;
	run GetCapacity522(testManager_server_serveWG,testManager_wg,testManager_mutex,testManager_server_mu,child_GetCapacity52211);
	child_GetCapacity52211?0;
	run writeCheckpoint573(testManager_server_serveWG,testManager_wg,testManager_mutex,testManager_server_mu,child_writeCheckpoint57312);
	child_writeCheckpoint57312?0;
	run readCheckpoint593(testManager_server_serveWG,testManager_wg,testManager_mutex,testManager_server_mu,child_readCheckpoint59313);
	child_readCheckpoint59313?0;
	run GetCapacity522(testManager_server_serveWG,testManager_wg,testManager_mutex,testManager_server_mu,child_GetCapacity52214);
	child_GetCapacity52214?0;
	run isDevicePluginResource1056(testManager_server_serveWG,testManager_wg,testManager_mutex,testManager_server_mu,child_isDevicePluginResource105615);
	child_isDevicePluginResource105615?0;
	stop_process: skip;
	child!0
}
proctype GetCapacity522(Wgdef m_server_serveWG;Wgdef m_wg;Mutexdef m_mutex;Mutexdef m_server_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_writeCheckpoint5730 = [1] of {int};
	int var_m_unhealthyDevicesm_unhealthyDevices = -2; // opt var_m_unhealthyDevicesm_unhealthyDevices
	int var_m_healthyDevicesm_healthyDevices = -2; // opt var_m_healthyDevicesm_healthyDevices
	m_mutex.Lock!false;
	m_mutex.Unlock!false;
	

	if
	:: true -> 
		run writeCheckpoint573(m_server_serveWG,m_wg,m_mutex,m_server_mu,child_writeCheckpoint5730);
		child_writeCheckpoint5730?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype writeCheckpoint573(Wgdef m_server_serveWG;Wgdef m_wg;Mutexdef m_mutex;Mutexdef m_server_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_m_healthyDevicesm_healthyDevices = -2; // opt var_m_healthyDevicesm_healthyDevices
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
proctype setStopTime136(Mutexdef e_clientConn_mu;Mutexdef e_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	e_mutex.Lock!false;
		defer1: skip;
	e_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype stop182(Mutexdef e_clientConn_mu;Mutexdef e_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	e_mutex.Lock!false;
		defer1: skip;
	e_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype allocate159(Mutexdef e_clientConn_mu;Mutexdef e_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_isStopped1238 = [1] of {int};
	run isStopped123(e_clientConn_mu,e_mutex,child_isStopped1238);
	child_isStopped1238?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype isStopped123(Mutexdef e_clientConn_mu;Mutexdef e_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	e_mutex.Lock!false;
	goto defer1;
		defer1: skip;
	e_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype preStartContainer171(Mutexdef e_clientConn_mu;Mutexdef e_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_isStopped1239 = [1] of {int};
	run isStopped123(e_clientConn_mu,e_mutex,child_isStopped1239);
	child_isStopped1239?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype markResourceUnhealthy497(Wgdef m_server_serveWG;Wgdef m_wg;Mutexdef m_mutex;Mutexdef m_server_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype readCheckpoint593(Wgdef m_server_serveWG;Wgdef m_wg;Mutexdef m_mutex;Mutexdef m_server_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_registeredDevsregisteredDevs = -2; // opt var_registeredDevsregisteredDevs
	

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
proctype isDevicePluginResource1056(Wgdef m_server_serveWG;Wgdef m_wg;Mutexdef m_mutex;Mutexdef m_server_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	m_mutex.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
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

