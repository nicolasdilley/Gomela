
// https://github.com/sirupsen/logrus/blob/master/hooks/test/test_test.go#L42
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
	chan child_TestLoggingWithHooksRace420 = [1] of {int};
	run TestLoggingWithHooksRace42(child_TestLoggingWithHooksRace420)
stop_process:skip
}

proctype TestLoggingWithHooksRace42(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AllEntries742 = [1] of {int};
	chan child_AnonymousTestLoggingWithHooksRace55550 = [1] of {int};
	Wgdef wgAll;
	Wgdef wgOne;
	Mutexdef hook_mu;
	Mutexdef logger_mu_lock;
	run mutexMonitor(logger_mu_lock);
	run mutexMonitor(hook_mu);
	run wgMonitor(wgOne);
	run wgMonitor(wgAll);
	wgOne.update!1;
	wgAll.update!100;
		for(i : 0.. 100-1) {
		for10: skip;
		run AnonymousTestLoggingWithHooksRace5555(wgOne,wgAll,logger_mu_lock,hook_mu,child_AnonymousTestLoggingWithHooksRace55550);
		for10_end: skip
	};
	for10_exit: skip;
	wgOne.wait?0;
	wgAll.wait?0;
	run AllEntries74(hook_mu,child_AllEntries742);
	child_AllEntries742?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestLoggingWithHooksRace5555(Wgdef wgOne;Wgdef wgAll;Mutexdef logger_mu_lock;Mutexdef hook_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wgAll.update!-1;
	

	if
	:: true -> 
		wgOne.update!-1
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype AllEntries74(Mutexdef t_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	t_mu.RLock!false;
	goto stop_process;
	stop_process: skip;
		t_mu.RUnlock!false;
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

