// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//x-pack/filebeat/input/netflow/decoder/v9/v9.go#L40
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_New400 = [1] of {int};
	run New40(child_New400);
	run receiver(child_New400)
stop_process:skip
}

proctype New40(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewProtocolWithDecoder450 = [1] of {int};
	Mutexdef logger_mu;
	run mutexMonitor(logger_mu);
	run NewProtocolWithDecoder45(logger_mu,child_NewProtocolWithDecoder450);
	child_NewProtocolWithDecoder450?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewProtocolWithDecoder45(Mutexdef logger_mu;chan child) {
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

proctype receiver(chan c) {
c?0
}

