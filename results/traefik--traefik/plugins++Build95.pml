// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/traefik/traefik/blob//pkg/plugins/builder.go#L95
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Build950 = [1] of {int};
	run Build95(child_Build950);
	run receiver(child_Build950)
stop_process:skip
}

proctype Build95(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newMiddleware1200 = [1] of {int};
	Mutexdef descriptor_interpreter_frame_mutex;
	Mutexdef descriptor_interpreter_mutex;
	Mutexdef descriptor_interpreter_fset_last_mutex;
	Mutexdef descriptor_interpreter_fset_mutex;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(descriptor_interpreter_fset_mutex);
	run mutexMonitor(descriptor_interpreter_fset_last_mutex);
	run mutexMonitor(descriptor_interpreter_mutex);
	run mutexMonitor(descriptor_interpreter_frame_mutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run newMiddleware120(descriptor_interpreter_frame_mutex,descriptor_interpreter_fset_last_mutex,descriptor_interpreter_fset_mutex,descriptor_interpreter_mutex,child_newMiddleware1200);
	child_newMiddleware1200?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newMiddleware120(Mutexdef descriptor_interpreter_frame_mutex;Mutexdef descriptor_interpreter_fset_last_mutex;Mutexdef descriptor_interpreter_fset_mutex;Mutexdef descriptor_interpreter_mutex;chan child) {
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

