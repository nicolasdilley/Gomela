// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/GoogleContainerTools/skaffold/blob//pkg/skaffold/util/port_test.go#L46
#define def_var_N56  ?? // mand N line 56
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetAvailablePort460 = [1] of {int};
	run TestGetAvailablePort46(child_TestGetAvailablePort460);
	run receiver(child_TestGetAvailablePort460)
stop_process:skip
}

proctype TestGetAvailablePort46(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestGetAvailablePort58520 = [1] of {int};
	Wgdef wg;
	Mutexdef lock;
	Mutexdef ports_lock;
	int var_errors = -2; // opt var_errors
	int var_N = def_var_N56; // mand var_N
	run mutexMonitor(ports_lock);
	run mutexMonitor(lock);
	run wgMonitor(wg);
	wg.update!var_N;
		for(i : 0.. var_N-1) {
		for10: skip;
		run AnonymousTestGetAvailablePort5852(wg,ports_lock,lock,child_AnonymousTestGetAvailablePort58520);
		run receiver(child_AnonymousTestGetAvailablePort58520);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestGetAvailablePort5852(Wgdef wg;Mutexdef ports_lock;Mutexdef lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		lock.Lock!false;
		lock.Unlock!false
	fi;
	wg.update!-1;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

