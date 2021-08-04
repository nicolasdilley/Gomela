// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/consul/blob/8d6cbe72813779f60ac24d119cc311c21003f4ce/agent/router/manager_test.go#L81
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestServers_AddServer810 = [1] of {int};
	run TestServers_AddServer81(child_TestServers_AddServer810);
	run receiver(child_TestServers_AddServer810)
stop_process:skip
}

proctype TestServers_AddServer81(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NumServers2916 = [1] of {int};
	chan child_AddServer875 = [1] of {int};
	chan child_NumServers2914 = [1] of {int};
	chan child_AddServer873 = [1] of {int};
	chan child_NumServers2912 = [1] of {int};
	chan child_AddServer871 = [1] of {int};
	chan child_NumServers2910 = [1] of {int};
	Mutexdef m_listLock;
	run mutexMonitor(m_listLock);
	run NumServers291(m_listLock,child_NumServers2910);
	child_NumServers2910?0;
	run AddServer87(m_listLock,child_AddServer871);
	child_AddServer871?0;
	run NumServers291(m_listLock,child_NumServers2912);
	child_NumServers2912?0;
	run AddServer87(m_listLock,child_AddServer873);
	child_AddServer873?0;
	run NumServers291(m_listLock,child_NumServers2914);
	child_NumServers2914?0;
	run AddServer87(m_listLock,child_AddServer875);
	child_AddServer875?0;
	run NumServers291(m_listLock,child_NumServers2916);
	child_NumServers2916?0;
	stop_process: skip;
	child!0
}
proctype NumServers291(Mutexdef m_listLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getServerList2240 = [1] of {int};
	run getServerList224(m_listLock,child_getServerList2240);
	child_getServerList2240?0;
	goto stop_process;
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
proctype AddServer87(Mutexdef m_listLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_saveServerList2332 = [1] of {int};
	chan child_getServerList2241 = [1] of {int};
	int var_l_servers = -2; // opt var_l_servers
	m_listLock.Lock!false;
	run getServerList224(m_listLock,child_getServerList2241);
	child_getServerList2241?0;
	run saveServerList233(m_listLock,child_saveServerList2332);
	child_saveServerList2332?0;
		defer1: skip;
	m_listLock.Unlock!false;
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

