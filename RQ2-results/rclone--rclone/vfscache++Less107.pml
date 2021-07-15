
// https://github.com/rclone/rclone/blob/master/vfs/vfscache/item.go#L107
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
	chan child_Less1070 = [1] of {int};
	run Less107(child_Less1070)
stop_process:skip
}

proctype Less107(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef jItem_downloaders_mu;
	Wgdef jItem_downloaders_wg;
	Mutexdef jItem_mu;
	Mutexdef jItem_c_kickerMu;
	Mutexdef jItem_c_mu;
	Mutexdef jItem_c_writeback_mu;
	Mutexdef iItem_downloaders_mu;
	Wgdef iItem_downloaders_wg;
	Mutexdef iItem_mu;
	Mutexdef iItem_c_kickerMu;
	Mutexdef iItem_c_mu;
	Mutexdef iItem_c_writeback_mu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(iItem_c_writeback_mu);
	run mutexMonitor(iItem_c_mu);
	run mutexMonitor(iItem_c_kickerMu);
	run mutexMonitor(iItem_mu);
	run wgMonitor(iItem_downloaders_wg);
	run mutexMonitor(iItem_downloaders_mu);
	run mutexMonitor(jItem_c_writeback_mu);
	run mutexMonitor(jItem_c_mu);
	run mutexMonitor(jItem_c_kickerMu);
	run mutexMonitor(jItem_mu);
	run wgMonitor(jItem_downloaders_wg);
	run mutexMonitor(jItem_downloaders_mu);
	iItem_mu.Lock!false;
	jItem_mu.Lock!false;
	goto stop_process;
	stop_process: skip;
		jItem_mu.Unlock!false;
		iItem_mu.Unlock!false;
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

