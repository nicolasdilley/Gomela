
// https://github.com/moby/moby/blob/master/pkg/ioutils/bytespipe_test.go#L51
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBytesPipeWrite510 = [1] of {int};
	run TestBytesPipeWrite51(child_TestBytesPipeWrite510)
stop_process:skip
}

proctype TestBytesPipeWrite51(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Write514 = [1] of {int};
	chan child_Write513 = [1] of {int};
	chan child_Write512 = [1] of {int};
	chan child_Write511 = [1] of {int};
	chan child_Write510 = [1] of {int};
	Mutexdef buf_mu;
	run mutexMonitor(buf_mu);
	run Write51(buf_mu,child_Write510);
	child_Write510?0;
	run Write51(buf_mu,child_Write511);
	child_Write511?0;
	run Write51(buf_mu,child_Write512);
	child_Write512?0;
	run Write51(buf_mu,child_Write513);
	child_Write513?0;
	run Write51(buf_mu,child_Write514);
	child_Write514?0;
	stop_process: skip;
	child!0
}
proctype Write51(Mutexdef bp_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	bp_mu.Lock!false;
	do
	:: true -> 
		for10: skip;
		

		if
		:: true -> 
			bp_mu.Unlock!false;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			bp_mu.Unlock!false;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			break
		:: true;
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
	loop0: skip;
	bp_mu.Unlock!false;
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

