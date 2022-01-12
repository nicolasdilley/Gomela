// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/chrislusf/seaweedfs/blob//weed/pb/volume_server_pb/volume_server.pb.go#L9220
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child__VolumeServer_Query_Handler92200 = [1] of {int};
	run _VolumeServer_Query_Handler9220(child__VolumeServer_Query_Handler92200);
	run receiver(child__VolumeServer_Query_Handler92200)
stop_process:skip
}

proctype _VolumeServer_Query_Handler9220(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef m_OutputSerialization_state_atomicMessageInfo_initMu;
	Mutexdef m_InputSerialization_state_atomicMessageInfo_initMu;
	Mutexdef m_Filter_state_atomicMessageInfo_initMu;
	Mutexdef m_state_atomicMessageInfo_initMu;
	run mutexMonitor(m_state_atomicMessageInfo_initMu);
	run mutexMonitor(m_Filter_state_atomicMessageInfo_initMu);
	run mutexMonitor(m_InputSerialization_state_atomicMessageInfo_initMu);
	run mutexMonitor(m_OutputSerialization_state_atomicMessageInfo_initMu);
	

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

proctype receiver(chan c) {
c?0
}

