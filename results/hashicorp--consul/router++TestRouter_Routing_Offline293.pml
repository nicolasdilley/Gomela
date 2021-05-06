
// https://github.com/hashicorp/consul/blob/master/agent/router/router_test.go#L293
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRouter_Routing_Offline2930 = [1] of {int};
	run TestRouter_Routing_Offline293(child_TestRouter_Routing_Offline2930)
stop_process:skip
}

proctype TestRouter_Routing_Offline293(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RebalanceServers3270 = [1] of {int};
	Mutexdef info_manager_listLock;
	Mutexdef __listLock;
	run mutexMonitor(__listLock);
	run mutexMonitor(info_manager_listLock);
	run RebalanceServers327(info_manager_listLock,child_RebalanceServers3270);
	child_RebalanceServers3270?0;
	stop_process: skip;
	child!0
}
proctype RebalanceServers327(Mutexdef m_listLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_reconcileServerList3833 = [1] of {int};
	chan child_healthyServer2962 = [1] of {int};
	chan child_healthyServer2961 = [1] of {int};
	chan child_getServerList2240 = [1] of {int};
	int l_servers = -2;
	run getServerList224(m_listLock,child_getServerList2240);
	child_getServerList2240?0;
	

	if
	:: 0 != -2 && l_servers-1 != -3 -> 
				for(i : 0.. l_servers-1) {
			for11: skip;
			run healthyServer296(m_listLock,child_healthyServer2962);
			child_healthyServer2962?0;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run healthyServer296(m_listLock,child_healthyServer2961);
			child_healthyServer2961?0;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	fi;
	run reconcileServerList383(m_listLock,child_reconcileServerList3833);
	child_reconcileServerList3833?0;
	stop_process: skip;
	child!0
}
proctype getServerList224(Mutexdef m_listLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype healthyServer296(Mutexdef m_listLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype reconcileServerList383(Mutexdef m_listLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_saveServerList2334 = [1] of {int};
	chan child_getServerList2243 = [1] of {int};
	m_listLock.Lock!false;
	run getServerList224(m_listLock,child_getServerList2243);
	child_getServerList2243?0;
	

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
	run saveServerList233(m_listLock,child_saveServerList2334);
	child_saveServerList2334?0;
	goto stop_process;
	stop_process: skip;
		m_listLock.Unlock!false;
	child!0
}
proctype saveServerList233(Mutexdef m_listLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

