
// https://github.com/nsqio/nsq/blob/master/nsqlookupd/http_test.go#L107
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInfo1070 = [1] of {int};
	run TestInfo107(child_TestInfo1070)
stop_process:skip
}

proctype TestInfo107(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Exit860 = [1] of {int};
	chan child_RealHTTPAddr821 = [1] of {int};
	Mutexdef nsqlookupd1_tcpServer_conns_mu;
	run mutexMonitor(nsqlookupd1_tcpServer_conns_mu);
	run RealHTTPAddr82(nsqlookupd1_tcpServer_conns_mu,child_RealHTTPAddr821);
	child_RealHTTPAddr821?0;
	stop_process: skip;
		run Exit86(nsqlookupd1_tcpServer_conns_mu,child_Exit860);
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
proctype RealHTTPAddr82(Mutexdef l_tcpServer_conns_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

