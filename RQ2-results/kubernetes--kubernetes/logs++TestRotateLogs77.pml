
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/logs/container_log_manager_test.go#L77
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRotateLogs770 = [1] of {int};
	run TestRotateLogs77(child_TestRotateLogs770)
stop_process:skip
}

proctype TestRotateLogs77(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_rotateLogs2100 = [1] of {int};
	Mutexdef c_mutex;
	run mutexMonitor(c_mutex);
	run rotateLogs210(c_mutex,child_rotateLogs2100);
	child_rotateLogs2100?0;
	stop_process: skip;
	child!0
}
proctype rotateLogs210(Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_rotateLog2650 = [1] of {int};
	chan child_rotateLog2651 = [1] of {int};
	int containers = -2;
	c_mutex.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: containers-1 != -3 -> 
				for(i : 0.. containers-1) {
			for20: skip;
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto for20_end
				:: true;
				fi;
				

				if
				:: true -> 
					goto for20_end
				:: true;
				fi;
				

				if
				:: true -> 
					goto for20_end
				:: true;
				fi
			:: true;
			fi;
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			run rotateLog265(c_mutex,child_rotateLog2650);
			child_rotateLog2650?0;
			

			if
			:: true -> 
				goto for26_end
			:: true;
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for27: skip;
			

			if
			:: true -> 
				goto for27_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for27_end
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto for27_end
				:: true;
				fi;
				

				if
				:: true -> 
					goto for27_end
				:: true;
				fi;
				

				if
				:: true -> 
					goto for27_end
				:: true;
				fi
			:: true;
			fi;
			

			if
			:: true -> 
				goto for27_end
			:: true;
			fi;
			run rotateLog265(c_mutex,child_rotateLog2651);
			child_rotateLog2651?0;
			

			if
			:: true -> 
				goto for27_end
			:: true;
			fi;
			for27_end: skip
		:: true -> 
			break
		od;
		for27_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
		c_mutex.Unlock!false;
	child!0
}
proctype rotateLog265(Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_rotateLatestLog4014 = [1] of {int};
	chan child_compressLog3672 = [1] of {int};
	chan child_compressLog3673 = [1] of {int};
	chan child_removeExcessLogs3451 = [1] of {int};
	chan child_cleanupUnusedLogs3020 = [1] of {int};
	int logs = -2;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run cleanupUnusedLogs302(c_mutex,child_cleanupUnusedLogs3020);
	child_cleanupUnusedLogs3020?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run removeExcessLogs345(c_mutex,logs,child_removeExcessLogs3451);
	child_removeExcessLogs3451?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: logs-1 != -3 -> 
				for(i : 0.. logs-1) {
			for25: skip;
			

			if
			:: true -> 
				goto for25_end
			:: true;
			fi;
			run compressLog367(c_mutex,child_compressLog3672);
			child_compressLog3672?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for25_end: skip
		};
		for25_exit: skip
	:: else -> 
		do
		:: true -> 
			for26: skip;
			

			if
			:: true -> 
				goto for26_end
			:: true;
			fi;
			run compressLog367(c_mutex,child_compressLog3673);
			child_compressLog3673?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for26_end: skip
		:: true -> 
			break
		od;
		for26_exit: skip
	fi;
	run rotateLatestLog401(c_mutex,child_rotateLatestLog4014);
	child_rotateLatestLog4014?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype cleanupUnusedLogs302(Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype removeExcessLogs345(Mutexdef c_mutex;int logs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype compressLog367(Mutexdef c_mutex;chan child) {
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
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype rotateLatestLog401(Mutexdef c_mutex;chan child) {
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

