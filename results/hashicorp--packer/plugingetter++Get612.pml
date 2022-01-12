// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/packer/blob//packer/plugin-getter/plugins_test.go#L612
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Get6120 = [1] of {int};
	run Get612(child_Get6120);
	run receiver(child_Get6120)
stop_process:skip
}

proctype Get612(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGet6356340 = [1] of {int};
	Mutexdef write_p_once_m;
	Mutexdef write_p_wrMu;
	Mutexdef read_p_once_m;
	Mutexdef read_p_wrMu;
	

	if
	:: true;
	:: true;
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(read_p_wrMu);
	run mutexMonitor(read_p_once_m);
	run mutexMonitor(write_p_wrMu);
	run mutexMonitor(write_p_once_m);
	run AnonymousGet635634(read_p_wrMu,read_p_once_m,write_p_wrMu,write_p_once_m,child_AnonymousGet6356340);
	run receiver(child_AnonymousGet6356340);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousGet635634(Mutexdef read_p_wrMu;Mutexdef read_p_once_m;Mutexdef write_p_wrMu;Mutexdef write_p_once_m;chan child) {
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

