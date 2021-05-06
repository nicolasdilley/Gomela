
// https://github.com/syncthing/syncthing/blob/master/lib/model/model_test.go#L2690
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestIssue447526900 = [1] of {int};
	run TestIssue44752690(child_TestIssue447526900)
stop_process:skip
}

proctype TestIssue44752690(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_sendIndexUpdate1491 = [1] of {int};
	chan child_addFile1090 = [1] of {int};
	Mutexdef conn_mut;
	run mutexMonitor(conn_mut);
	run addFile109(conn_mut,child_addFile1090);
	child_addFile1090?0;
	run sendIndexUpdate149(conn_mut,child_sendIndexUpdate1491);
	child_sendIndexUpdate1491?0;
	stop_process: skip;
	child!0
}
proctype addFile109(Mutexdef f_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_addFileLocked650 = [1] of {int};
	f_mut.Lock!false;
	run addFileLocked65(f_mut,child_addFileLocked650);
	child_addFileLocked650?0;
	stop_process: skip;
		f_mut.Unlock!false;
	child!0
}
proctype addFileLocked65(Mutexdef f_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true;
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype sendIndexUpdate149(Mutexdef f_mut;chan child) {
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

