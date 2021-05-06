
// https://github.com/gin-gonic/gin/blob/master/context_test.go#L1750
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextBadAutoShouldBind17500 = [1] of {int};
	run TestContextBadAutoShouldBind1750(child_TestContextBadAutoShouldBind17500)
stop_process:skip
}

proctype TestContextBadAutoShouldBind1750(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IsAborted1712 = [1] of {int};
	chan child_ShouldBind6611 = [1] of {int};
	chan child_IsAborted1710 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run IsAborted171(c_mu,child_IsAborted1710);
	child_IsAborted1710?0;
	run ShouldBind661(c_mu,child_ShouldBind6611);
	child_ShouldBind6611?0;
	run IsAborted171(c_mu,child_IsAborted1712);
	child_IsAborted1712?0;
	stop_process: skip;
	child!0
}
proctype IsAborted171(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ShouldBind661(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ShouldBindWith7022 = [1] of {int};
	chan child_ContentType8051 = [1] of {int};
	run ContentType805(c_mu,child_ContentType8051);
	child_ContentType8051?0;
	run ShouldBindWith702(c_mu,child_ShouldBindWith7022);
	child_ShouldBindWith7022?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ContentType805(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_requestHeader8191 = [1] of {int};
	run requestHeader819(c_mu,child_requestHeader8191);
	child_requestHeader8191?0;
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
proctype ShouldBindWith702(Mutexdef c_mu;chan child) {
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

