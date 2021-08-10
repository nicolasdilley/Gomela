// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/packer/blob/a9c2283ee589b203c0ce16174a5747b7d2053d61/packer/provisioner_test.go#L21
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestProvisionHook210 = [1] of {int};
	run TestProvisionHook21(child_TestProvisionHook210);
	run receiver(child_TestProvisionHook210)
stop_process:skip
}

proctype TestProvisionHook21(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Run1060 = [1] of {int};
	Mutexdef ui_l;
	run mutexMonitor(ui_l);
	run Run106(ui_l,child_Run1060);
	child_Run1060?0;
	stop_process: skip;
	child!0
}
proctype Run106(Mutexdef ui_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_h_Provisioners = -2; // opt var_h_Provisioners
	

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

