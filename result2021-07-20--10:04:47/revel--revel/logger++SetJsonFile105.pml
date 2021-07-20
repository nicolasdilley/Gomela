// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/revel/revel/blob/ee237a4ce4b7660dcbafda789dd6f524a4a4b47d/logger/composite_multihandler.go#L105
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_SetJsonFile1050 = [1] of {int};
	run SetJsonFile105(child_SetJsonFile1050);
	run receiver(child_SetJsonFile1050)
stop_process:skip
}

proctype SetJsonFile105(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetJson930 = [1] of {int};
	Mutexdef writer_startMill_m;
	Mutexdef writer_mu;
	run mutexMonitor(writer_mu);
	run mutexMonitor(writer_startMill_m);
	run SetJson93(writer_mu,writer_startMill_m,child_SetJson930);
	child_SetJson930?0;
	stop_process: skip;
	child!0
}
proctype SetJson93(Mutexdef writer_mu;Mutexdef writer_startMill_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_StreamHandler1530 = [1] of {int};
	run StreamHandler153(writer_mu,writer_startMill_m,child_StreamHandler1530);
	child_StreamHandler1530?0;
	stop_process: skip;
	child!0
}
proctype StreamHandler153(Mutexdef wr_mu;Mutexdef wr_startMill_m;chan child) {
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

