#define prs152  -2

// https://github.com/wtfutil/wtf/blob/master/modules/github/github_repo.go#L152
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_individualPRs1520 = [1] of {int};
	run individualPRs152(prs152,child_individualPRs1520)
stop_process:skip
}

proctype individualPRs152(int prs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef github_rateMu;
	Mutexdef github_clientMu;
	run mutexMonitor(github_clientMu);
	run mutexMonitor(github_rateMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

