// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/command/views/hook_ui_test.go#L502
#define not_found_532  -2 // opt not_found_532
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPostImportState5020 = [1] of {int};
	run TestPostImportState502(child_TestPostImportState5020);
	run receiver(child_TestPostImportState5020)
stop_process:skip
}

proctype TestPostImportState502(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PostImportState2690 = [1] of {int};
	Mutexdef h_resourcesLock;
	Mutexdef h_viewLock;
	run mutexMonitor(h_viewLock);
	run mutexMonitor(h_resourcesLock);
	run PostImportState269(h_resourcesLock,h_viewLock,not_found_532,child_PostImportState2690);
	child_PostImportState2690?0;
	stop_process: skip;
	child!0
}
proctype PostImportState269(Mutexdef h_resourcesLock;Mutexdef h_viewLock;int imported;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_println2851 = [1] of {int};
	chan child_println2852 = [1] of {int};
	chan child_println2850 = [1] of {int};
	run println285(h_resourcesLock,h_viewLock,child_println2850);
	child_println2850?0;
	

	if
	:: imported-1 != -3 -> 
				for(i : 0.. imported-1) {
			for10: skip;
			run println285(h_resourcesLock,h_viewLock,child_println2851);
			child_println2851?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run println285(h_resourcesLock,h_viewLock,child_println2852);
			child_println2852?0;
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
proctype println285(Mutexdef h_resourcesLock;Mutexdef h_viewLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	h_viewLock.Lock!false;
		defer1: skip;
	h_viewLock.Unlock!false;
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

