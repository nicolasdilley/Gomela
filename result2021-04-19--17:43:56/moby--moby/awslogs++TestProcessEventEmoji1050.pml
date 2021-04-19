#define ub_for603_2  -2

// https://github.com/moby/moby/blob/master/daemon/logger/awslogs/cloudwatchlogs_test.go#L1050
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestProcessEventEmoji10500 = [1] of {int};
	run TestProcessEventEmoji1050(child_TestProcessEventEmoji10500)
stop_process:skip
}

proctype TestProcessEventEmoji1050(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_processEvent6020 = [1] of {int};
	Mutexdef stream_lock;
	run mutexMonitor(stream_lock);
	run processEvent602(stream_lock,child_processEvent6020);
	child_processEvent6020?0;
	stop_process: skip;
	child!0
}
proctype processEvent602(Mutexdef l_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_publishBatch6591 = [1] of {int};
	chan child_publishBatch6590 = [1] of {int};
	

	if
	:: 0 != -2 && ub_for603_2 != -2 -> 
				for(i : 0.. ub_for603_2) {
			for11: skip;
			

			if
			:: true -> 
				run publishBatch659(l_lock,child_publishBatch6591);
				child_publishBatch6591?0
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: true -> 
				run publishBatch659(l_lock,child_publishBatch6590);
				child_publishBatch6590?0
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype publishBatch659(Mutexdef l_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_putLogEvents6961 = [1] of {int};
	chan child_putLogEvents6960 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run putLogEvents696(l_lock,child_putLogEvents6960);
	child_putLogEvents6960?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: true -> 
					run putLogEvents696(l_lock,child_putLogEvents6961);
					child_putLogEvents6961?0
				:: true;
				fi
			fi
		:: true;
		fi
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype putLogEvents696(Mutexdef l_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
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

