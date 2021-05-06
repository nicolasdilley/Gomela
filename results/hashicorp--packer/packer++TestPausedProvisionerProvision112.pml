
// https://github.com/hashicorp/packer/blob/master/packer/provisioner_test.go#L112
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPausedProvisionerProvision1120 = [1] of {int};
	run TestPausedProvisionerProvision112(child_TestPausedProvisionerProvision1120)
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
	run Provision146(ui_l,comm_StartCmd_m,comm_StartCmd_exitChInit_m,child_Provision1460);
	child_Provision1460?0;
	stop_process: skip;
	child!0
}
proctype Provision146(Mutexdef ui_l;Mutexdef comm_StartCmd_m;Mutexdef comm_StartCmd_exitChInit_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Provision341 = [1] of {int};
	chan child_Say470 = [1] of {int};
	run Say47(ui_l,child_Say470);
	child_Say470?0;
	do
	:: true -> 
		break
	:: true -> 
		goto stop_process
	od;
	run Provision34(ui_l,comm_StartCmd_m,comm_StartCmd_exitChInit_m,child_Provision341);
	child_Provision341?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Say47(Mutexdef u_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_colorize730 = [1] of {int};
	run colorize73(u_l,child_colorize730);
	child_colorize730?0;
	stop_process: skip;
	child!0
}
proctype colorize73(Mutexdef u_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_supportsColors860 = [1] of {int};
	run supportsColors86(u_l,child_supportsColors860);
	child_supportsColors860?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype supportsColors86(Mutexdef u_l;chan child) {
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
proctype Provision34(Mutexdef ui_l;Mutexdef comm_StartCmd_m;Mutexdef comm_StartCmd_exitChInit_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Provision341 = [1] of {int};
	run Provision34(ui_l,comm_StartCmd_m,comm_StartCmd_exitChInit_m,child_Provision341);
	child_Provision341?0;
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

