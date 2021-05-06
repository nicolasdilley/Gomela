
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/cri/streaming/portforward/httpstream_test.go#L209
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRequestID2090 = [1] of {int};
	run TestRequestID209(child_TestRequestID2090)
stop_process:skip
}

proctype TestRequestID209(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_requestID1742 = [1] of {int};
	chan child_requestID1741 = [1] of {int};
	chan child_requestID1740 = [1] of {int};
	Mutexdef h_streamPairsLock;
	run mutexMonitor(h_streamPairsLock);
	run requestID174(h_streamPairsLock,child_requestID1740);
	child_requestID1740?0;
	run requestID174(h_streamPairsLock,child_requestID1741);
	child_requestID1741?0;
	run requestID174(h_streamPairsLock,child_requestID1742);
	child_requestID1742?0;
	stop_process: skip;
	child!0
}
proctype requestID174(Mutexdef h_streamPairsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true;
		:: true;
		fi
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

