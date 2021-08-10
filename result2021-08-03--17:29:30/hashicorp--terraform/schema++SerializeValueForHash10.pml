// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/internal/legacy/helper/schema/serialize.go#L10
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_SerializeValueForHash100 = [1] of {int};
	run SerializeValueForHash10(child_SerializeValueForHash100);
	run receiver(child_SerializeValueForHash100)
stop_process:skip
}

proctype SerializeValueForHash10(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef s_once_m;
	int var_s_List = -2; // opt var_s_List
	int var_keys = -2; // opt var_keys
	int var_m = -2; // opt var_m
	int var_l = -2; // opt var_l
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
		run mutexMonitor(s_once_m)
	:: true;
	fi;
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

