
// https://github.com/rclone/rclone/blob/master/backend/crypt/cipher_test.go#L1154
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDecrypterClose11540 = [1] of {int};
	run TestDecrypterClose1154(child_TestDecrypterClose11540)
stop_process:skip
}

proctype TestDecrypterClose1154(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close10172 = [1] of {int};
	chan child_Close10171 = [1] of {int};
	chan child_Close10170 = [1] of {int};
	Mutexdef fh_mu;
	run mutexMonitor(fh_mu);
	run Close1017(fh_mu,child_Close10170);
	child_Close10170?0;
	run Close1017(fh_mu,child_Close10171);
	child_Close10171?0;
	run Close1017(fh_mu,child_Close10172);
	child_Close10172?0;
	stop_process: skip;
	child!0
}
proctype Close1017(Mutexdef fh_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_finish9900 = [1] of {int};
	fh_mu.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run finish990(fh_mu,child_finish9900);
		child_finish9900?0
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		fh_mu.Unlock!false;
	child!0
}
proctype finish990(Mutexdef fh_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

