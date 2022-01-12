// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/service/servicegroup_test.go#L91
#define def_var_multipliers97  ?? // mand multipliers line 97
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
	chan child_TestServiceGroup_WithStarter910 = [1] of {int};
	run TestServiceGroup_WithStarter91(child_TestServiceGroup_WithStarter910);
	run receiver(child_TestServiceGroup_WithStarter910)
stop_process:skip
}

proctype TestServiceGroup_WithStarter91(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef lock;
	Wgdef wait;
	int var_multipliers = def_var_multipliers97; // mand var_multipliers
	run wgMonitor(wait);
	run mutexMonitor(lock);
	wait.update!var_multipliers;
	wait.wait?0;
	lock.Lock!false;
		defer1: skip;
	lock.Unlock!false;
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

