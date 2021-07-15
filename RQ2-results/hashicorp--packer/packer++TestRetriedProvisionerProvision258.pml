#define ub_for183_2  -2

// https://github.com/hashicorp/packer/blob/master/packer/provisioner_test.go#L258
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRetriedProvisionerProvision2580 = [1] of {int};
	run TestRetriedProvisionerProvision258(child_TestRetriedProvisionerProvision2580)
stop_process:skip
}

proctype TestRetriedProvisionerProvision258(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Provision1720 = [1] of {int};
	Mutexdef comm_StartCmd_exitChInit_m;
	Mutexdef comm_StartCmd_m;
	Mutexdef ui_l;
	run mutexMonitor(ui_l);
	run mutexMonitor(comm_StartCmd_m);
	run mutexMonitor(comm_StartCmd_exitChInit_m);
	run Provision172(ui_l,comm_StartCmd_m,comm_StartCmd_exitChInit_m,child_Provision1720);
	child_Provision1720?0;
	stop_process: skip;
	child!0
}
proctype Provision172(Mutexdef ui_l;Mutexdef comm_StartCmd_m;Mutexdef comm_StartCmd_exitChInit_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Say475 = [1] of {int};
	chan child_Provision344 = [1] of {int};
	chan child_Say473 = [1] of {int};
	chan child_Provision342 = [1] of {int};
	chan child_Say471 = [1] of {int};
	chan child_Provision340 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Provision34(ui_l,comm_StartCmd_m,comm_StartCmd_exitChInit_m,child_Provision340);
	child_Provision340?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 0 != -2 && ub_for183_2 != -2 -> 
				for(i : 0.. ub_for183_2) {
			for11: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			run Say47(ui_l,child_Say473);
			child_Say473?0;
			run Provision34(ui_l,comm_StartCmd_m,comm_StartCmd_exitChInit_m,child_Provision344);
			child_Provision344?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			run Say47(ui_l,child_Say471);
			child_Say471?0;
			run Provision34(ui_l,comm_StartCmd_m,comm_StartCmd_exitChInit_m,child_Provision342);
			child_Provision342?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run Say47(ui_l,child_Say475);
	child_Say475?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Provision34(Mutexdef ui_l;Mutexdef comm_StartCmd_m;Mutexdef comm_StartCmd_exitChInit_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Provision340 = [1] of {int};
	run Provision34(ui_l,comm_StartCmd_m,comm_StartCmd_exitChInit_m,child_Provision340);
	child_Provision340?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Say47(Mutexdef u_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_colorize731 = [1] of {int};
	run colorize73(u_l,child_colorize731);
	child_colorize731?0;
	stop_process: skip;
	child!0
}
proctype colorize73(Mutexdef u_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_supportsColors861 = [1] of {int};
	run supportsColors86(u_l,child_supportsColors861);
	child_supportsColors861?0;
	

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

