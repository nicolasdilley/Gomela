
// https://github.com/rclone/rclone/blob/master/backend/googlephotos/albums_test.go#L277
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAlbumsGet2770 = [1] of {int};
	run TestAlbumsGet277(child_TestAlbumsGet2770)
stop_process:skip
}

proctype TestAlbumsGet277(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get1352 = [1] of {int};
	chan child_get1351 = [1] of {int};
	chan child_add330 = [1] of {int};
	Mutexdef albums_mu;
	run mutexMonitor(albums_mu);
	run add33(albums_mu,child_add330);
	child_add330?0;
	run get135(albums_mu,child_get1351);
	child_get1351?0;
	run get135(albums_mu,child_get1352);
	child_get1352?0;
	stop_process: skip;
	child!0
}
proctype add33(Mutexdef as_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child__add460 = [1] of {int};
	as_mu.Lock!false;
	run _add46(as_mu,child__add460);
	child__add460?0;
	as_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype _add46(Mutexdef as_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child__add461 = [1] of {int};
	chan child__del990 = [1] of {int};
	

	if
	:: true -> 
		

		if
		:: true -> 
			run _del99(as_mu,child__del990);
			child__del990?0;
			run _add46(as_mu,child__add461);
			child__add461?0
		:: true;
		fi
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype _del99(Mutexdef as_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype get135(Mutexdef as_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	as_mu.Lock!false;
	goto stop_process;
	stop_process: skip;
		as_mu.Unlock!false;
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

