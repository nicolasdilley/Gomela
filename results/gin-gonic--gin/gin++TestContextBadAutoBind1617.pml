
// https://github.com/gin-gonic/gin/blob/master/context_test.go#L1617
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextBadAutoBind16170 = [1] of {int};
	run TestContextBadAutoBind1617(child_TestContextBadAutoBind16170)
stop_process:skip
}

proctype TestContextBadAutoBind1617(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IsAborted1712 = [1] of {int};
	chan child_Bind6021 = [1] of {int};
	chan child_IsAborted1710 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run IsAborted171(c_mu,child_IsAborted1710);
	child_IsAborted1710?0;
	run Bind602(c_mu,child_Bind6021);
	child_Bind6021?0;
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
proctype Bind602(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MustBindWith6452 = [1] of {int};
	chan child_ContentType8051 = [1] of {int};
	run ContentType805(c_mu,child_ContentType8051);
	child_ContentType8051?0;
	run MustBindWith645(c_mu,child_MustBindWith6452);
	child_MustBindWith6452?0;
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
proctype MustBindWith645(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ShouldBindWith7022 = [1] of {int};
	run ShouldBindWith702(c_mu,child_ShouldBindWith7022);
	child_ShouldBindWith7022?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

