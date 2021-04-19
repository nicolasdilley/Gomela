#define not_found_105  -2
#define not_found_120  -2

// https://github.com/moby/moby/blob/master/daemon/images/store_test.go#L90
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContentStoreForPull900 = [1] of {int};
	run TestContentStoreForPull90(child_TestContentStoreForPull900)
stop_process:skip
}

proctype TestContentStoreForPull90(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Writer1231 = [1] of {int};
	chan child_Writer1230 = [1] of {int};
	Mutexdef csP_mu;
	run mutexMonitor(csP_mu);
	run Writer123(csP_mu,not_found_105,child_Writer1230);
	child_Writer1230?0;
	run Writer123(csP_mu,not_found_120,child_Writer1231);
	child_Writer1231?0;
	stop_process: skip;
	child!0
}
proctype Writer123(Mutexdef c_mu;int opts;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_addDigested1090 = [1] of {int};
	

	if
	:: true -> 
		

		if
		:: true -> 
			run addDigested109(c_mu,child_addDigested1090);
			child_addDigested1090?0
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype addDigested109(Mutexdef c_mu;chan child) {
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

