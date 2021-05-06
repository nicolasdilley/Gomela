
// https://github.com/gin-gonic/gin/blob/master/context_test.go#L70
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextFormFile700 = [1] of {int};
	run TestContextFormFile70(child_TestContextFormFile700)
stop_process:skip
}

proctype TestContextFormFile70(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SaveUploadedFile5771 = [1] of {int};
	chan child_FormFile5560 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run FormFile556(c_mu,child_FormFile5560);
	child_FormFile5560?0;
	run SaveUploadedFile577(c_mu,child_SaveUploadedFile5771);
	child_SaveUploadedFile5771?0;
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
proctype SaveUploadedFile577(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
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

