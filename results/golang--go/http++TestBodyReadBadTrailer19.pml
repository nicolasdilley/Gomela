// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//net/http/transfer_test.go#L19
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBodyReadBadTrailer190 = [1] of {int};
	run TestBodyReadBadTrailer19(child_TestBodyReadBadTrailer190);
	run receiver(child_TestBodyReadBadTrailer190)
stop_process:skip
}

proctype TestBodyReadBadTrailer19(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Read8282 = [1] of {int};
	chan child_Read8281 = [1] of {int};
	chan child_Read8280 = [1] of {int};
	Mutexdef b_mu;
	run mutexMonitor(b_mu);
	run Read828(b_mu,child_Read8280);
	child_Read8280?0;
	run Read828(b_mu,child_Read8281);
	child_Read8281?0;
	run Read828(b_mu,child_Read8282);
	child_Read8282?0;
	stop_process: skip;
	child!0
}
proctype Read828(Mutexdef b_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_readLocked8380 = [1] of {int};
	b_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run readLocked838(b_mu,child_readLocked8380);
	child_readLocked8380?0;
	goto defer1;
		defer1: skip;
	b_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype readLocked838(Mutexdef b_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_readTrailer9080 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run readTrailer908(b_mu,child_readTrailer9080);
			child_readTrailer9080?0
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype readTrailer908(Mutexdef b_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true;
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

proctype receiver(chan c) {
c?0
}

