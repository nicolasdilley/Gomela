// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/packer/blob/a9c2283ee589b203c0ce16174a5747b7d2053d61/packer/provisioner_test.go#L47
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestProvisionHook_nilComm470 = [1] of {int};
	run TestProvisionHook_nilComm47(child_TestProvisionHook_nilComm470);
	run receiver(child_TestProvisionHook_nilComm470)
stop_process:skip
}

proctype TestProvisionHook_nilComm47(chan child) {
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
	chan child_Provision340 = [1] of {int};
	chan child_Provision341 = [1] of {int};
	int var_h_Provisionersh_Provisioners = -2; // opt var_h_Provisionersh_Provisioners
	

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
	:: var_h_Provisioners-1 != -3 -> 
				for(i : 0.. var_h_Provisioners-1) {
			for10: skip;
			run Provision34(ui_l,child_Provision340);
			child_Provision340?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run Provision34(ui_l,child_Provision341);
			child_Provision341?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Provision34(Mutexdef ui_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Provision340 = [1] of {int};
	run Provision34(ui_l,child_Provision340);
	child_Provision340?0;
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
