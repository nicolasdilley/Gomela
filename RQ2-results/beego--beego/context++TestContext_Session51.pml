
// https://github.com/beego/beego/blob/master/server/web/context/context_test.go#L51
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContext_Session510 = [1] of {int};
	run TestContext_Session51(child_TestContext_Session510)
stop_process:skip
}

proctype TestContext_Session51(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Session2010 = [1] of {int};
	Mutexdef c_Input_dataLock;
	run mutexMonitor(c_Input_dataLock);
	run Session201(c_Input_dataLock,child_Session2010);
	child_Session2010?0;
	stop_process: skip;
	child!0
}
proctype Session201(Mutexdef ctx_Input_dataLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
	:: true -> 
		goto stop_process
	fi;
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

