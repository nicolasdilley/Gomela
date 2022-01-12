// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/history/history_test.go#L57
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLatest570 = [1] of {int};
	run TestLatest57(child_TestLatest570);
	run receiver(child_TestLatest570)
stop_process:skip
}

proctype TestLatest57(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Latest945 = [1] of {int};
	chan child_Add524 = [1] of {int};
	chan child_Latest943 = [1] of {int};
	chan child_Add522 = [1] of {int};
	chan child_Latest941 = [1] of {int};
	chan child_Add520 = [1] of {int};
	Mutexdef h_mu;
	run mutexMonitor(h_mu);
	run Add52(h_mu,child_Add520);
	child_Add520?0;
	run Latest94(h_mu,child_Latest941);
	child_Latest941?0;
	run Add52(h_mu,child_Add522);
	child_Add522?0;
	run Latest94(h_mu,child_Latest943);
	child_Latest943?0;
	run Add52(h_mu,child_Add524);
	child_Add524?0;
	run Latest94(h_mu,child_Latest945);
	child_Latest945?0;
	stop_process: skip;
	child!0
}
proctype Add52(Mutexdef history_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	history_mu.Lock!false;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	:: true;
	fi;
		defer1: skip;
	history_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Latest94(Mutexdef history_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	history_mu.Lock!false;
	goto defer1;
		defer1: skip;
	history_mu.Unlock!false;
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

