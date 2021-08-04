// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/traefik/traefik/blob/080cf98e512f6fcb93838de76a6aa34ff147dee4/pkg/middlewares/requestdecorator/hostresolver.go#L76
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_cnameResolve760 = [1] of {int};
	run cnameResolve76(child_cnameResolve760);
	run receiver(child_cnameResolve760)
stop_process:skip
}

proctype cnameResolve76(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getRecord1050 = [1] of {int};
	chan child_getRecord1051 = [1] of {int};
	Mutexdef client_TLSConfig_mutex;
	int var_config_Servers = -2; // opt var_config_Servers
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(client_TLSConfig_mutex);
	

	if
	:: var_config_Servers-1 != -3 -> 
				for(i : 0.. var_config_Servers-1) {
			for10: skip;
			run getRecord105(client_TLSConfig_mutex,child_getRecord1050);
			child_getRecord1050?0;
			

			if
			:: true -> 
				goto for10_end
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run getRecord105(client_TLSConfig_mutex,child_getRecord1051);
			child_getRecord1051?0;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
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
proctype getRecord105(Mutexdef client_TLSConfig_mutex;chan child) {
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

