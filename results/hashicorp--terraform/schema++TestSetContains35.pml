
// https://github.com/hashicorp/terraform/blob/master/internal/legacy/helper/schema/set_test.go#L35
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSetContains350 = [1] of {int};
	run TestSetContains35(child_TestSetContains350)
stop_process:skip
}

proctype TestSetContains35(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Contains844 = [1] of {int};
	chan child_Contains843 = [1] of {int};
	chan child_Contains842 = [1] of {int};
	chan child_Add741 = [1] of {int};
	chan child_Add740 = [1] of {int};
	Mutexdef s_once_m;
	run mutexMonitor(s_once_m);
	run Add74(s_once_m,child_Add740);
	child_Add740?0;
	run Add74(s_once_m,child_Add741);
	child_Add741?0;
	run Contains84(s_once_m,child_Contains842);
	child_Contains842?0;
	run Contains84(s_once_m,child_Contains843);
	child_Contains843?0;
	run Contains84(s_once_m,child_Contains844);
	child_Contains844?0;
	stop_process: skip;
	child!0
}
proctype Add74(Mutexdef s_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_add1950 = [1] of {int};
	run add195(s_once_m,child_add1950);
	child_add1950?0;
	stop_process: skip;
	child!0
}
proctype add195(Mutexdef s_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_hash2200 = [1] of {int};
	run hash220(s_once_m,child_hash2200);
	child_hash2200?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype hash220(Mutexdef s_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Contains84(Mutexdef s_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

