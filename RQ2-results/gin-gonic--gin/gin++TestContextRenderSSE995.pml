
// https://github.com/gin-gonic/gin/blob/master/context_test.go#L995
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextRenderSSE9950 = [1] of {int};
	run TestContextRenderSSE995(child_TestContextRenderSSE9950)
stop_process:skip
}

proctype TestContextRenderSSE995(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SSEvent10432 = [1] of {int};
	chan child_Render9041 = [1] of {int};
	chan child_SSEvent10430 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run SSEvent1043(c_mu,child_SSEvent10430);
	child_SSEvent10430?0;
	run Render904(c_mu,child_Render9041);
	child_Render9041?0;
	run SSEvent1043(c_mu,child_SSEvent10432);
	child_SSEvent10432?0;
	stop_process: skip;
	child!0
}
proctype SSEvent1043(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Render9040 = [1] of {int};
	run Render904(c_mu,child_Render9040);
	child_Render9040?0;
	stop_process: skip;
	child!0
}
proctype Render904(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Status8410 = [1] of {int};
	run Status841(c_mu,child_Status8410);
	child_Status8410?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype Status841(Mutexdef c_mu;chan child) {
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

