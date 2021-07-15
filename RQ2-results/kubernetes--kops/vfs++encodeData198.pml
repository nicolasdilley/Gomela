
// https://github.com/kubernetes/kops/blob/master/util/pkg/vfs/vaultfs.go#L198
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_encodeData1980 = [1] of {int};
	run encodeData198(child_encodeData1980)
stop_process:skip
}

proctype encodeData198(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousencodeData2021990 = [1] of {int};
	Mutexdef pw_p_once_m;
	Mutexdef pw_p_wrMu;
	Mutexdef pr_p_once_m;
	Mutexdef pr_p_wrMu;
	run mutexMonitor(pr_p_wrMu);
	run mutexMonitor(pr_p_once_m);
	run mutexMonitor(pw_p_wrMu);
	run mutexMonitor(pw_p_once_m);
	run AnonymousencodeData202199(pr_p_wrMu,pr_p_once_m,pw_p_wrMu,pw_p_once_m,child_AnonymousencodeData2021990);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousencodeData202199(Mutexdef pr_p_wrMu;Mutexdef pr_p_once_m;Mutexdef pw_p_wrMu;Mutexdef pw_p_once_m;chan child) {
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

