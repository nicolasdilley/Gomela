// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//orderer/common/channelparticipation/restapi_test.go#L202
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHTTPHandler_ServeHTTP_ListSingle2020 = [1] of {int};
	run TestHTTPHandler_ServeHTTP_ListSingle202(child_TestHTTPHandler_ServeHTTP_ListSingle2020);
	run receiver(child_TestHTTPHandler_ServeHTTP_ListSingle2020)
stop_process:skip
}

proctype TestHTTPHandler_ServeHTTP_ListSingle202(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef fakeManager_invocationsMutex;
	Mutexdef fakeManager_removeChannelMutex;
	Mutexdef fakeManager_joinChannelMutex;
	Mutexdef fakeManager_channelListMutex;
	Mutexdef fakeManager_channelInfoMutex;
	run mutexMonitor(fakeManager_channelInfoMutex);
	run mutexMonitor(fakeManager_channelListMutex);
	run mutexMonitor(fakeManager_joinChannelMutex);
	run mutexMonitor(fakeManager_removeChannelMutex);
	run mutexMonitor(fakeManager_invocationsMutex);
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

