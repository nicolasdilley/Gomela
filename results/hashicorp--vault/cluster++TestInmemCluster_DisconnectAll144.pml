
// https://github.com/hashicorp/vault/blob/master/vault/cluster/inmem_layer_test.go#L144
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInmemCluster_DisconnectAll1440 = [1] of {int};
	run TestInmemCluster_DisconnectAll144(child_TestInmemCluster_DisconnectAll1440)
stop_process:skip
}

proctype TestInmemCluster_DisconnectAll144(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef conn_config_mutex;
	Mutexdef conn_handshakeMutex;
	chan child_DisconnectAll2380 = [1] of {int};
	Mutexdef server_l;
	run mutexMonitor(server_l);
	run DisconnectAll238(server_l,child_DisconnectAll2380);
	child_DisconnectAll2380?0;
	run mutexMonitor(conn_handshakeMutex);
	run mutexMonitor(conn_config_mutex);
	stop_process: skip;
	child!0
}
proctype DisconnectAll238(Mutexdef l_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	l_l.Lock!false;
	stop_process: skip;
		l_l.Unlock!false;
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

