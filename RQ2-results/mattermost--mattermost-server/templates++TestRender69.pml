
// https://github.com/mattermost/mattermost-server/blob/master/shared/templates/templates_test.go#L69
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRender690 = [1] of {int};
	run TestRender69(child_TestRender690)
stop_process:skip
}

proctype TestRender69(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Render1331 = [1] of {int};
	chan child_RenderToString1230 = [1] of {int};
	Mutexdef mt_mutex;
	run mutexMonitor(mt_mutex);
	run RenderToString123(mt_mutex,child_RenderToString1230);
	child_RenderToString1230?0;
	run Render133(mt_mutex,child_Render1331);
	child_Render1331?0;
	stop_process: skip;
	child!0
}
proctype RenderToString123(Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Render1330 = [1] of {int};
	run Render133(c_mutex,child_Render1330);
	child_Render1330?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Render133(Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mutex.RLock!false;
	c_mutex.RUnlock!false;
	

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

