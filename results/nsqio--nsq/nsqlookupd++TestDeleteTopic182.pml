
// https://github.com/nsqio/nsq/blob/master/nsqlookupd/http_test.go#L182
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDeleteTopic1820 = [1] of {int};
	run TestDeleteTopic182(child_TestDeleteTopic1820)
stop_process:skip
}

proctype TestDeleteTopic182(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Exit860 = [1] of {int};
	chan child_RealHTTPAddr825 = [1] of {int};
	chan child_makeChannel834 = [1] of {int};
	chan child_RealHTTPAddr823 = [1] of {int};
	chan child_makeTopic782 = [1] of {int};
	chan child_RealHTTPAddr821 = [1] of {int};
	Mutexdef nsqlookupd1_tcpServer_conns_mu;
	run mutexMonitor(nsqlookupd1_tcpServer_conns_mu);
	run RealHTTPAddr82(nsqlookupd1_tcpServer_conns_mu,child_RealHTTPAddr821);
	child_RealHTTPAddr821?0;
	run makeTopic78(nsqlookupd1_tcpServer_conns_mu,child_makeTopic782);
	child_makeTopic782?0;
	run RealHTTPAddr82(nsqlookupd1_tcpServer_conns_mu,child_RealHTTPAddr823);
	child_RealHTTPAddr823?0;
	run makeChannel83(nsqlookupd1_tcpServer_conns_mu,child_makeChannel834);
	child_makeChannel834?0;
	run RealHTTPAddr82(nsqlookupd1_tcpServer_conns_mu,child_RealHTTPAddr825);
	child_RealHTTPAddr825?0;
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
proctype makeTopic78(Mutexdef nsqlookupd_tcpServer_conns_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype makeChannel83(Mutexdef nsqlookupd_tcpServer_conns_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_makeTopic784 = [1] of {int};
	run makeTopic78(nsqlookupd_tcpServer_conns_mu,child_makeTopic784);
	child_makeTopic784?0;
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

