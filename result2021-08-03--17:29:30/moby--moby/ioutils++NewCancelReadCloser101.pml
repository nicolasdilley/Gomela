// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/moby/moby/blob/5a82cee6d499e51bc903a743e4f0f205adb161a9/pkg/ioutils/readers.go#L101
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewCancelReadCloser1010 = [1] of {int};
	run NewCancelReadCloser101(child_NewCancelReadCloser1010);
	run receiver(child_NewCancelReadCloser1010)
stop_process:skip
}

proctype NewCancelReadCloser101(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousNewCancelReadCloser1251021 = [1] of {int};
	chan child_AnonymousNewCancelReadCloser1131020 = [1] of {int};
	Mutexdef pW_p_wrMu;
	Mutexdef pR_p_wrMu;
	run mutexMonitor(pR_p_wrMu);
	run mutexMonitor(pW_p_wrMu);
	run AnonymousNewCancelReadCloser113102(pR_p_wrMu,pW_p_wrMu,child_AnonymousNewCancelReadCloser1131020);
	run receiver(child_AnonymousNewCancelReadCloser1131020);
	run AnonymousNewCancelReadCloser125102(pR_p_wrMu,pW_p_wrMu,child_AnonymousNewCancelReadCloser1251021);
	run receiver(child_AnonymousNewCancelReadCloser1251021);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousNewCancelReadCloser113102(Mutexdef pR_p_wrMu;Mutexdef pW_p_wrMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		break
	:: true -> 
		break
	od;
	for10_exit: skip;
	for10_end: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousNewCancelReadCloser125102(Mutexdef pR_p_wrMu;Mutexdef pW_p_wrMu;chan child) {
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

proctype receiver(chan c) {
c?0
}

