#define sections227  -2

// https://github.com/ethereum/go-ethereum/blob/master/light/odr_util.go#L227
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_GetBloomBits2270 = [1] of {int};
	run GetBloomBits227(sections227,child_GetBloomBits2270)
stop_process:skip
}

proctype GetBloomBits227(int sections;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Retrieve2770 = [1] of {int};
	Mutexdef r_Proofs_lock;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(r_Proofs_lock);
	run Retrieve277(r_Proofs_lock,child_Retrieve2770);
	child_Retrieve2770?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Retrieve277(Mutexdef req_Proofs_lock;chan child) {
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

