#define not_found_532  -2

// https://github.com/hashicorp/terraform/blob/master/command/views/hook_ui_test.go#L502
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPostImportState5020 = [1] of {int};
	run TestPostImportState502(child_TestPostImportState5020)
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
	run PostImportState269(h_viewLock,h_resourcesLock,not_found_532,child_PostImportState2690);
	child_PostImportState2690?0;
	stop_process: skip;
	child!0
}
proctype PostImportState269(Mutexdef h_viewLock;Mutexdef h_resourcesLock;int imported;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_println2851 = [1] of {int};
	chan child_println2852 = [1] of {int};
	chan child_println2850 = [1] of {int};
	run println285(h_viewLock,h_resourcesLock,child_println2850);
	child_println2850?0;
	

	if
	:: imported-1 != -3 -> 
				for(i : 0.. imported-1) {
			for10: skip;
			run println285(h_viewLock,h_resourcesLock,child_println2851);
			child_println2851?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run println285(h_viewLock,h_resourcesLock,child_println2852);
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
proctype println285(Mutexdef h_viewLock;Mutexdef h_resourcesLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	h_viewLock.Lock!false;
	stop_process: skip;
		h_viewLock.Unlock!false;
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

