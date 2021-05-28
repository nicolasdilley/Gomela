// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/consensus/ethash/ethash.go#L389
#define not_found_391  -2 // opt not_found_391
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_MakeCache3890 = [1] of {int};
	run MakeCache389(child_MakeCache3890);
	run receiver(child_MakeCache3890)
stop_process:skip
}

proctype MakeCache389(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_generate2320 = [1] of {int};
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run generate232(c_once_m,not_found_391,child_generate2320);
	child_generate2320?0;
	stop_process: skip;
	child!0
}
proctype generate232(Mutexdef c_once_m;int limit;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int c_epoch = -2; // opt c_epoch
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

