
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/cm/devicemanager/manager_test.go#L996
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
	chan child_TestResetExtendedResource9960 = [1] of {int};
	run TestResetExtendedResource996(child_TestResetExtendedResource9960)
stop_process:skip
}

proctype TestResetExtendedResource996(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ShouldResetExtendedResourceCapacity10862 = [1] of {int};
	chan child_ShouldResetExtendedResourceCapacity10861 = [1] of {int};
	chan child_writeCheckpoint5730 = [1] of {int};
	Wgdef testManager_wg;
	Wgdef testManager_server_serveWG;
	Mutexdef testManager_server_channelzRemoveOnce_m;
	Mutexdef testManager_server_done_o_m;
	Mutexdef testManager_server_quit_o_m;
	Mutexdef testManager_server_mu;
	Mutexdef testManager_mutex;
	run mutexMonitor(testManager_mutex);
	run mutexMonitor(testManager_server_mu);
	run mutexMonitor(testManager_server_quit_o_m);
	run mutexMonitor(testManager_server_done_o_m);
	run mutexMonitor(testManager_server_channelzRemoveOnce_m);
	run wgMonitor(testManager_server_serveWG);
	run wgMonitor(testManager_wg);
	run writeCheckpoint573(testManager_server_serveWG,testManager_wg,testManager_mutex,testManager_server_mu,testManager_server_quit_o_m,testManager_server_done_o_m,testManager_server_channelzRemoveOnce_m,child_writeCheckpoint5730);
	child_writeCheckpoint5730?0;
	run ShouldResetExtendedResourceCapacity1086(testManager_server_serveWG,testManager_wg,testManager_mutex,testManager_server_mu,testManager_server_quit_o_m,testManager_server_done_o_m,testManager_server_channelzRemoveOnce_m,child_ShouldResetExtendedResourceCapacity10861);
	child_ShouldResetExtendedResourceCapacity10861?0;
	run ShouldResetExtendedResourceCapacity1086(testManager_server_serveWG,testManager_wg,testManager_mutex,testManager_server_mu,testManager_server_quit_o_m,testManager_server_done_o_m,testManager_server_channelzRemoveOnce_m,child_ShouldResetExtendedResourceCapacity10862);
	child_ShouldResetExtendedResourceCapacity10862?0;
	stop_process: skip;
	child!0
}
proctype writeCheckpoint573(Wgdef m_server_serveWG;Wgdef m_wg;Mutexdef m_mutex;Mutexdef m_server_mu;Mutexdef m_server_quit_o_m;Mutexdef m_server_done_o_m;Mutexdef m_server_channelzRemoveOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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
proctype ShouldResetExtendedResourceCapacity1086(Wgdef m_server_serveWG;Wgdef m_wg;Mutexdef m_mutex;Mutexdef m_server_mu;Mutexdef m_server_quit_o_m;Mutexdef m_server_done_o_m;Mutexdef m_server_channelzRemoveOnce_m;chan child) {
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
		fi;
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

