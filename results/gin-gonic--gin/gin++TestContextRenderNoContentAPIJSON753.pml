
// https://github.com/gin-gonic/gin/blob/master/context_test.go#L753
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextRenderNoContentAPIJSON7530 = [1] of {int};
	run TestContextRenderNoContentAPIJSON753(child_TestContextRenderNoContentAPIJSON7530)
stop_process:skip
}

proctype TestContextRenderNoContentAPIJSON753(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_JSON9551 = [1] of {int};
	chan child_Header8480 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run Header848(c_mu,child_Header8480);
	child_Header8480?0;
	run JSON955(c_mu,child_JSON9551);
	child_JSON9551?0;
	stop_process: skip;
	child!0
}
proctype Header848(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype JSON955(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Render9041 = [1] of {int};
	run Render904(c_mu,child_Render9041);
	child_Render9041?0;
	stop_process: skip;
	child!0
}
proctype Render904(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Status8411 = [1] of {int};
	run Status841(c_mu,child_Status8411);
	child_Status8411?0;
	

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

