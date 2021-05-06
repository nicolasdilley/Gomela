
// https://github.com/gin-gonic/gin/blob/master/context_test.go#L714
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextRenderJSONPWithoutCallback7140 = [1] of {int};
	run TestContextRenderJSONPWithoutCallback714(child_TestContextRenderJSONPWithoutCallback7140)
stop_process:skip
}

proctype TestContextRenderJSONPWithoutCallback714(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_JSONP9440 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run JSONP944(c_mu,child_JSONP9440);
	child_JSONP9440?0;
	stop_process: skip;
	child!0
}
proctype JSONP944(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Render9042 = [1] of {int};
	chan child_Render9041 = [1] of {int};
	chan child_DefaultQuery4040 = [1] of {int};
	run DefaultQuery404(c_mu,child_DefaultQuery4040);
	child_DefaultQuery4040?0;
	

	if
	:: true -> 
		run Render904(c_mu,child_Render9041);
		child_Render9041?0;
		goto stop_process
	:: true;
	fi;
	run Render904(c_mu,child_Render9042);
	child_Render9042?0;
	stop_process: skip;
	child!0
}
proctype DefaultQuery404(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetQuery4190 = [1] of {int};
	run GetQuery419(c_mu,child_GetQuery4190);
	child_GetQuery4190?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetQuery419(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetQueryArray4450 = [1] of {int};
	run GetQueryArray445(c_mu,child_GetQueryArray4450);
	child_GetQueryArray4450?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetQueryArray445(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_initQueryCache4330 = [1] of {int};
	run initQueryCache433(c_mu,child_initQueryCache4330);
	child_initQueryCache4330?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype initQueryCache433(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

