// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gin-gonic/gin/blob/5452a1d3ef0982ffea95fb9e88e5425b0928c431/context_test.go#L1041
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextRenderAttachment10410 = [1] of {int};
	run TestContextRenderAttachment1041(child_TestContextRenderAttachment10410);
	run receiver(child_TestContextRenderAttachment10410)
stop_process:skip
}

proctype TestContextRenderAttachment1041(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_FileAttachment10370 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run FileAttachment1037(c_mu,child_FileAttachment10370);
	child_FileAttachment10370?0;
	stop_process: skip;
	child!0
}
proctype FileAttachment1037(Mutexdef c_mu;chan child) {
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

proctype receiver(chan c) {
c?0
}
