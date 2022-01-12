// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/executors/periodicalexecutor_test.go#L48
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
	chan child_TestPeriodicalExecutor_Sync480 = [1] of {int};
	run TestPeriodicalExecutor_Sync48(child_TestPeriodicalExecutor_Sync480);
	run receiver(child_TestPeriodicalExecutor_Sync480)
stop_process:skip
}

proctype TestPeriodicalExecutor_Sync48(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Sync850 = [1] of {int};
	Mutexdef exec_lock;
	Mutexdef exec_wgBarrier_lock;
	Wgdef exec_waitGroup;
	run wgMonitor(exec_waitGroup);
	run mutexMonitor(exec_wgBarrier_lock);
	run mutexMonitor(exec_lock);
	run Sync85(exec_waitGroup,exec_lock,exec_wgBarrier_lock,child_Sync850);
	child_Sync850?0;
	stop_process: skip;
	child!0
}
proctype Sync85(Wgdef pe_waitGroup;Mutexdef pe_lock;Mutexdef pe_wgBarrier_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	pe_lock.Lock!false;
		defer1: skip;
	pe_lock.Unlock!false;
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

