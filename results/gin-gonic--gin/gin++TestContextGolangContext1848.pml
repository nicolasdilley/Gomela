
// https://github.com/gin-gonic/gin/blob/master/context_test.go#L1848
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextGolangContext18480 = [1] of {int};
	run TestContextGolangContext1848(child_TestContextGolangContext18480)
stop_process:skip
}

proctype TestContextGolangContext1848(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Value11697 = [1] of {int};
	chan child_Value11696 = [1] of {int};
	chan child_Set2395 = [1] of {int};
	chan child_Value11694 = [1] of {int};
	chan child_Value11693 = [1] of {int};
	chan child_Deadline11502 = [1] of {int};
	chan child_Done11571 = [1] of {int};
	chan child_Err11620 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run Err1162(c_mu,child_Err11620);
	child_Err11620?0;
	run Done1157(c_mu,child_Done11571);
	child_Done11571?0;
	run Deadline1150(c_mu,child_Deadline11502);
	child_Deadline11502?0;
	run Value1169(c_mu,child_Value11693);
	child_Value11693?0;
	run Value1169(c_mu,child_Value11694);
	child_Value11694?0;
	run Set239(c_mu,child_Set2395);
	child_Set2395?0;
	run Value1169(c_mu,child_Value11696);
	child_Value11696?0;
	run Value1169(c_mu,child_Value11697);
	child_Value11697?0;
	stop_process: skip;
	child!0
}
proctype Err1162(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Done1157(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Deadline1150(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Value1169(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get2513 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run Get251(c_mu,child_Get2513);
		child_Get2513?0;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Get251(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mu.RLock!false;
	c_mu.RUnlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Set239(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mu.Lock!false;
	c_mu.Unlock!false;
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

