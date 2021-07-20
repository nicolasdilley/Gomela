// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/wagoodman/dive/blob/64880972b0726ec2ff2b005b0cc97801067c1bb5/cmd/root.go#L141
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_initLogging1410 = [1] of {int};
	run initLogging141(child_initLogging1410);
	run receiver(child_initLogging1410)
stop_process:skip
}

proctype initLogging141(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef Formatter_terminalInitOnce_m;
	int var_viper_AllSettings__viper_AllSettings__ = -2; // opt var_viper_AllSettings__viper_AllSettings__
	run mutexMonitor(Formatter_terminalInitOnce_m);
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

