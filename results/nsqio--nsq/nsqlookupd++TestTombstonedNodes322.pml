
// https://github.com/nsqio/nsq/blob/master/nsqlookupd/nsqlookupd_test.go#L322
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTombstonedNodes3220 = [1] of {int};
	run TestTombstonedNodes322(child_TestTombstonedNodes3220)
stop_process:skip
}

proctype TestTombstonedNodes322(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Exit860 = [1] of {int};
	Mutexdef nsqlookupd_tcpServer_conns_mu;
	run mutexMonitor(nsqlookupd_tcpServer_conns_mu);
	stop_process: skip;
		run Exit86(nsqlookupd_tcpServer_conns_mu,child_Exit860);
	child_Exit860?0;
	child!0
}
proctype Exit86(Mutexdef l_tcpServer_conns_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close580 = [1] of {int};
	

	if
	:: true -> 
		run Close58(l_tcpServer_conns_mu,child_Close580);
		child_Close580?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype Close58(Mutexdef p_conns_mu;chan child) {
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

