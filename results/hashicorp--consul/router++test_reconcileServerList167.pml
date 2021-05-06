#define maxServers167  -2

// https://github.com/hashicorp/consul/blob/master/agent/router/manager_internal_test.go#L167
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_test_reconcileServerList1670 = [1] of {int};
	run test_reconcileServerList167(maxServers167,child_test_reconcileServerList1670)
stop_process:skip
}

proctype test_reconcileServerList167(int maxServers;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_reconcileServerList3836 = [1] of {int};
	chan child_saveServerList2335 = [1] of {int};
	chan child_getServerList2244 = [1] of {int};
	chan child_FindServer1903 = [1] of {int};
	chan child_RebalanceServers3272 = [1] of {int};
	chan child_AddServer871 = [1] of {int};
	chan child_AddServer870 = [1] of {int};
	Mutexdef m_listLock;
	run mutexMonitor(m_listLock);
	

	if
	:: 0 != -2 && maxServers-1 != -3 -> 
				for(i : 0.. maxServers-1) {
			for13: skip;
			

			if
			:: true -> 
				run AddServer87(m_listLock,child_AddServer871);
				child_AddServer871?0
			fi;
			for13_end: skip
		};
		for13_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: true -> 
				run AddServer87(m_listLock,child_AddServer870);
				child_AddServer870?0
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run RebalanceServers327(m_listLock,child_RebalanceServers3272);
	child_RebalanceServers3272?0;
	run FindServer190(m_listLock,child_FindServer1903);
	child_FindServer1903?0;
	run getServerList224(m_listLock,child_getServerList2244);
	child_getServerList2244?0;
	run saveServerList233(m_listLock,child_saveServerList2335);
	child_saveServerList2335?0;
	run reconcileServerList383(m_listLock,child_reconcileServerList3836);
	child_reconcileServerList3836?0;
	

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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AddServer87(Mutexdef m_listLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_saveServerList2331 = [1] of {int};
	chan child_getServerList2240 = [1] of {int};
	m_listLock.Lock!false;
	run getServerList224(m_listLock,child_getServerList2240);
	child_getServerList2240?0;
	run saveServerList233(m_listLock,child_saveServerList2331);
	child_saveServerList2331?0;
	stop_process: skip;
		m_listLock.Unlock!false;
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
proctype saveServerList233(Mutexdef m_listLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype RebalanceServers327(Mutexdef m_listLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_reconcileServerList3835 = [1] of {int};
	chan child_healthyServer2964 = [1] of {int};
	chan child_healthyServer2963 = [1] of {int};
	chan child_getServerList2242 = [1] of {int};
	int l_servers = -2;
	run getServerList224(m_listLock,child_getServerList2242);
	child_getServerList2242?0;
	

	if
	:: 0 != -2 && l_servers-1 != -3 -> 
				for(i : 0.. l_servers-1) {
			for21: skip;
			run healthyServer296(m_listLock,child_healthyServer2964);
			child_healthyServer2964?0;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run healthyServer296(m_listLock,child_healthyServer2963);
			child_healthyServer2963?0;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	fi;
	run reconcileServerList383(m_listLock,child_reconcileServerList3835);
	child_reconcileServerList3835?0;
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
	chan child_saveServerList2336 = [1] of {int};
	chan child_getServerList2245 = [1] of {int};
	m_listLock.Lock!false;
	run getServerList224(m_listLock,child_getServerList2245);
	child_getServerList2245?0;
	

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
	run saveServerList233(m_listLock,child_saveServerList2336);
	child_saveServerList2336?0;
	goto stop_process;
	stop_process: skip;
		m_listLock.Unlock!false;
	child!0
}
proctype FindServer190(Mutexdef m_listLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getServerList2243 = [1] of {int};
	run getServerList224(m_listLock,child_getServerList2243);
	child_getServerList2243?0;
	

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

