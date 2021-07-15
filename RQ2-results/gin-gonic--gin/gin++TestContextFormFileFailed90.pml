
// https://github.com/gin-gonic/gin/blob/master/context_test.go#L90
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextFormFileFailed900 = [1] of {int};
	run TestContextFormFileFailed90(child_TestContextFormFileFailed900)
stop_process:skip
}

proctype TestContextFormFileFailed90(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_FormFile5560 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run FormFile556(c_mu,child_FormFile5560);
	child_FormFile5560?0;
	stop_process: skip;
	child!0
}
proctype FormFile556(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
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

