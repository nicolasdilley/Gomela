
// https://github.com/hashicorp/vault/blob/master/internalshared/gatedwriter/writer_test.go#L13
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestWriter130 = [1] of {int};
	run TestWriter13(child_TestWriter130)
stop_process:skip
}

proctype TestWriter13(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Write343 = [1] of {int};
	chan child_Flush252 = [1] of {int};
	chan child_Write341 = [1] of {int};
	chan child_Write340 = [1] of {int};
	Mutexdef w_lock;
	run mutexMonitor(w_lock);
	run Write34(w_lock,child_Write340);
	child_Write340?0;
	run Write34(w_lock,child_Write341);
	child_Write341?0;
	run Flush25(w_lock,child_Flush252);
	child_Flush252?0;
	run Write34(w_lock,child_Write343);
	child_Write343?0;
	stop_process: skip;
	child!0
}
proctype Write34(Mutexdef w_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	w_lock.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		w_lock.Unlock!false;
	child!0
}
proctype Flush25(Mutexdef w_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	w_lock.Lock!false;
	goto stop_process;
	stop_process: skip;
		w_lock.Unlock!false;
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

