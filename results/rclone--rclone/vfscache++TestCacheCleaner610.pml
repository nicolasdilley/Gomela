
// https://github.com/rclone/rclone/blob/master/vfs/vfscache/cache_test.go#L610
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
	chan child_TestCacheCleaner6100 = [1] of {int};
	run TestCacheCleaner610(child_TestCacheCleaner6100)
stop_process:skip
}

proctype TestCacheCleaner610(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get2613 = [1] of {int};
	chan child_get2612 = [1] of {int};
	chan child_get2611 = [1] of {int};
	Mutexdef potato2_downloaders_mu;
	Wgdef potato2_downloaders_wg;
	Mutexdef potato2_mu;
	Mutexdef potato2_c_kickerMu;
	Mutexdef potato2_c_mu;
	Mutexdef potato2_c_writeback_mu;
	chan child_Item2740 = [1] of {int};
	Mutexdef potato_downloaders_mu;
	Wgdef potato_downloaders_wg;
	Mutexdef potato_mu;
	Mutexdef potato_c_kickerMu;
	Mutexdef potato_c_mu;
	Mutexdef potato_c_writeback_mu;
	Mutexdef c_kickerMu;
	Mutexdef c_mu;
	Mutexdef c_writeback_mu;
	run mutexMonitor(c_writeback_mu);
	run mutexMonitor(c_mu);
	run mutexMonitor(c_kickerMu);
	run mutexMonitor(potato_c_writeback_mu);
	run mutexMonitor(potato_c_mu);
	run mutexMonitor(potato_c_kickerMu);
	run mutexMonitor(potato_mu);
	run wgMonitor(potato_downloaders_wg);
	run mutexMonitor(potato_downloaders_mu);
	run Item274(c_writeback_mu,c_mu,c_kickerMu,child_Item2740);
	child_Item2740?0;
	run mutexMonitor(potato2_c_writeback_mu);
	run mutexMonitor(potato2_c_mu);
	run mutexMonitor(potato2_c_kickerMu);
	run mutexMonitor(potato2_mu);
	run wgMonitor(potato2_downloaders_wg);
	run mutexMonitor(potato2_downloaders_mu);
	run get261(c_writeback_mu,c_mu,c_kickerMu,child_get2611);
	child_get2611?0;
	

	if
	:: 0 != -2 && 100-1 != -3 -> 
				for(i : 0.. 100-1) {
			for11: skip;
			run get261(c_writeback_mu,c_mu,c_kickerMu,child_get2613);
			child_get2613?0;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run get261(c_writeback_mu,c_mu,c_kickerMu,child_get2612);
			child_get2612?0;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype Item274(Mutexdef c_writeback_mu;Mutexdef c_mu;Mutexdef c_kickerMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get2610 = [1] of {int};
	run get261(c_writeback_mu,c_mu,c_kickerMu,child_get2610);
	child_get2610?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype get261(Mutexdef c_writeback_mu;Mutexdef c_mu;Mutexdef c_kickerMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child__get1980 = [1] of {int};
	c_mu.Lock!false;
	run _get198(c_writeback_mu,c_mu,c_kickerMu,child__get1980);
	child__get1980?0;
	c_mu.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype _get198(Mutexdef c_writeback_mu;Mutexdef c_mu;Mutexdef c_kickerMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newItem1320 = [1] of {int};
	

	if
	:: true -> 
		run newItem132(c_writeback_mu,c_mu,c_kickerMu,child_newItem1320);
		child_newItem1320?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newItem132(Mutexdef c_writeback_mu;Mutexdef c_mu;Mutexdef c_kickerMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_toOSPath1620 = [1] of {int};
	run toOSPath162(c_writeback_mu,c_mu,c_kickerMu,child_toOSPath1620);
	child_toOSPath1620?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype toOSPath162(Mutexdef c_writeback_mu;Mutexdef c_mu;Mutexdef c_kickerMu;chan child) {
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

