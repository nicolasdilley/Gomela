// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ipfs/go-ipfs/blob//core/commands/dag/get.go#L19
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_dagGet190 = [1] of {int};
	run dagGet19(child_dagGet190);
	run receiver(child_dagGet190)
stop_process:skip
}

proctype dagGet19(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousdagGet63620 = [1] of {int};
	Mutexdef w_p_once_m;
	Mutexdef w_p_wrMu;
	Mutexdef r_p_once_m;
	Mutexdef r_p_wrMu;
	

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
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(r_p_wrMu);
	run mutexMonitor(r_p_once_m);
	run mutexMonitor(w_p_wrMu);
	run mutexMonitor(w_p_once_m);
	run AnonymousdagGet6362(r_p_wrMu,r_p_once_m,w_p_wrMu,w_p_once_m,child_AnonymousdagGet63620);
	run receiver(child_AnonymousdagGet63620);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousdagGet6362(Mutexdef r_p_wrMu;Mutexdef r_p_once_m;Mutexdef w_p_wrMu;Mutexdef w_p_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

