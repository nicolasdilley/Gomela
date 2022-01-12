// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/containers/podman/blob//libpod/container_internal_test.go#L20
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPostDeleteHooks200 = [1] of {int};
	run TestPostDeleteHooks20(child_TestPostDeleteHooks200);
	run receiver(child_TestPostDeleteHooks200)
stop_process:skip
}

proctype TestPostDeleteHooks20(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_postDeleteHooks18560 = [1] of {int};
	Mutexdef c_runtime_lock;
	run mutexMonitor(c_runtime_lock);
	run postDeleteHooks1856(c_runtime_lock,child_postDeleteHooks18560);
	child_postDeleteHooks18560?0;
	stop_process: skip;
	child!0
}
proctype postDeleteHooks1856(Mutexdef c_runtime_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ID3274 = [1] of {int};
	chan child_ID3273 = [1] of {int};
	chan child_ID3272 = [1] of {int};
	chan child_ID3271 = [1] of {int};
	chan child_ID3270 = [1] of {int};
	chan child_ID3279 = [1] of {int};
	chan child_ID3278 = [1] of {int};
	chan child_ID3277 = [1] of {int};
	chan child_ID3276 = [1] of {int};
	chan child_ID3275 = [1] of {int};
	int var_extensionHooks = -2; // opt var_extensionHooks
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: var_extensionHooks-1 != -3 -> 
								for(i : 0.. var_extensionHooks-1) {
					for10: skip;
					run ID327(c_runtime_lock,child_ID3270);
					child_ID3270?0;
					

					if
					:: true -> 
						run ID327(c_runtime_lock,child_ID3271);
						child_ID3271?0;
						

						if
						:: true -> 
							run ID327(c_runtime_lock,child_ID3272);
							child_ID3272?0
						:: true;
						fi;
						

						if
						:: true -> 
							run ID327(c_runtime_lock,child_ID3273);
							child_ID3273?0
						:: true;
						fi;
						

						if
						:: true -> 
							run ID327(c_runtime_lock,child_ID3274);
							child_ID3274?0
						:: true;
						fi
					:: true;
					fi;
					for10_end: skip
				};
				for10_exit: skip
			:: else -> 
				do
				:: true -> 
					for11: skip;
					run ID327(c_runtime_lock,child_ID3275);
					child_ID3275?0;
					

					if
					:: true -> 
						run ID327(c_runtime_lock,child_ID3276);
						child_ID3276?0;
						

						if
						:: true -> 
							run ID327(c_runtime_lock,child_ID3277);
							child_ID3277?0
						:: true;
						fi;
						

						if
						:: true -> 
							run ID327(c_runtime_lock,child_ID3278);
							child_ID3278?0
						:: true;
						fi;
						

						if
						:: true -> 
							run ID327(c_runtime_lock,child_ID3279);
							child_ID3279?0
						:: true;
						fi
					:: true;
					fi;
					for11_end: skip
				:: true -> 
					break
				od;
				for11_exit: skip
			fi
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ID327(Mutexdef c_runtime_lock;chan child) {
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

