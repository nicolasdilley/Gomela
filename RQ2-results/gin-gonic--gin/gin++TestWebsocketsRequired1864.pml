
// https://github.com/gin-gonic/gin/blob/master/context_test.go#L1864
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestWebsocketsRequired18640 = [1] of {int};
	run TestWebsocketsRequired1864(child_TestWebsocketsRequired18640)
stop_process:skip
}

proctype TestWebsocketsRequired1864(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IsWebsocket8111 = [1] of {int};
	chan child_IsWebsocket8110 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run IsWebsocket811(c_mu,child_IsWebsocket8110);
	child_IsWebsocket8110?0;
	run IsWebsocket811(c_mu,child_IsWebsocket8111);
	child_IsWebsocket8111?0;
	stop_process: skip;
	child!0
}
proctype IsWebsocket811(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_requestHeader8191 = [1] of {int};
	chan child_requestHeader8190 = [1] of {int};
	run requestHeader819(c_mu,child_requestHeader8190);
	child_requestHeader8190?0;
	run requestHeader819(c_mu,child_requestHeader8191);
	child_requestHeader8191?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype requestHeader819(Mutexdef c_mu;chan child) {
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

