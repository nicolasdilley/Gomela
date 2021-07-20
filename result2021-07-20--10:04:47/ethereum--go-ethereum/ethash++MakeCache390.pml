// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/consensus/ethash/ethash.go#L390
#define not_found_392  -2 // opt limit line 233
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_MakeCache3900 = [1] of {int};
	run MakeCache390(child_MakeCache3900);
	run receiver(child_MakeCache3900)
stop_process:skip
}

proctype MakeCache390(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_generate2330 = [1] of {int};
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run generate233(c_once_m,not_found_392,child_generate2330);
	child_generate2330?0;
	stop_process: skip;
	child!0
}
proctype generate233(Mutexdef c_once_m;int limit;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_c_epochc_epoch = -2; // opt var_c_epochc_epoch
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

