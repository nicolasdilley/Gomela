// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/trie/secure_trie_test.go#L108
#define var_threads114  ?? // mand threads line 114
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
	chan child_TestSecureTrieConcurrency1080 = [1] of {int};
	run TestSecureTrieConcurrency108(child_TestSecureTrieConcurrency1080);
	run receiver(child_TestSecureTrieConcurrency1080)
stop_process:skip
}

proctype TestSecureTrieConcurrency108(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestSecureTrieConcurrency1221220 = [1] of {int};
	Wgdef pend;
	Mutexdef __lock;
	int var_threads = var_threads114; // mand var_threads
	run mutexMonitor(__lock);
	run wgMonitor(pend);
	pend.update!var_threads;
		for(i : 0.. var_threads-1) {
		for20: skip;
		run AnonymousTestSecureTrieConcurrency122122(pend,__lock,child_AnonymousTestSecureTrieConcurrency1221220);
		run receiver(child_AnonymousTestSecureTrieConcurrency1221220);
		for20_end: skip
	};
	for20_exit: skip;
	pend.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestSecureTrieConcurrency122122(Wgdef pend;Mutexdef __lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_byte_3_byte_3_ = -2; // opt var_byte_3_byte_3_
	int var_byte_0_byte_0_ = -2; // opt var_byte_0_byte_0_
		defer1: skip;
	pend.update!-1;
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

