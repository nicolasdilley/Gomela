// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/packer/blob//packer/provisioner_test.go#L112
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPausedProvisionerProvision1120 = [1] of {int};
	run TestPausedProvisionerProvision112(child_TestPausedProvisionerProvision1120);
	run receiver(child_TestPausedProvisionerProvision1120)
stop_process:skip
}

proctype TestPausedProvisionerProvision112(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Provision1460 = [1] of {int};
	Mutexdef comm_StartCmd_exitChInit_m;
	Mutexdef comm_StartCmd_m;
	Mutexdef ui_l;
	run mutexMonitor(ui_l);
	run mutexMonitor(comm_StartCmd_m);
	run mutexMonitor(comm_StartCmd_exitChInit_m);
	run Provision146(ui_l,comm_StartCmd_exitChInit_m,comm_StartCmd_m,child_Provision1460);
	child_Provision1460?0;
	stop_process: skip;
	child!0
}
proctype Provision146(Mutexdef ui_l;Mutexdef comm_StartCmd_exitChInit_m;Mutexdef comm_StartCmd_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		break
	:: true -> 
		goto stop_process
	od;
	for10_exit: skip;
	for10_end: skip;
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

