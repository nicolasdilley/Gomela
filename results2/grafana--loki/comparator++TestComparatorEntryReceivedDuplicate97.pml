// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/grafana/loki/blob/aa544a9dffdb8e78f7d7ed8edafce466d333b0a8/pkg/canary/comparator/comparator_test.go#L97
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestComparatorEntryReceivedDuplicate970 = [1] of {int};
	run TestComparatorEntryReceivedDuplicate97(child_TestComparatorEntryReceivedDuplicate970);
	run receiver(child_TestComparatorEntryReceivedDuplicate970)
stop_process:skip
}

proctype TestComparatorEntryReceivedDuplicate97(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Size24213 = [1] of {int};
	chan child_entryReceived20412 = [1] of {int};
	chan child_Size24211 = [1] of {int};
	chan child_entryReceived20410 = [1] of {int};
	chan child_Size2429 = [1] of {int};
	chan child_entryReceived2048 = [1] of {int};
	chan child_Size2427 = [1] of {int};
	chan child_entryReceived2046 = [1] of {int};
	chan child_Size2425 = [1] of {int};
	chan child_entryReceived2044 = [1] of {int};
	chan child_entrySent1893 = [1] of {int};
	chan child_entrySent1892 = [1] of {int};
	chan child_entrySent1891 = [1] of {int};
	chan child_entrySent1890 = [1] of {int};
	Mutexdef c_pruneMtx;
	Mutexdef c_metTestMtx;
	Mutexdef c_spotMtx;
	Mutexdef c_spotEntMtx;
	Mutexdef c_missingMtx;
	Mutexdef c_entMtx;
	run mutexMonitor(c_entMtx);
	run mutexMonitor(c_missingMtx);
	run mutexMonitor(c_spotEntMtx);
	run mutexMonitor(c_spotMtx);
	run mutexMonitor(c_metTestMtx);
	run mutexMonitor(c_pruneMtx);
	run entrySent189(c_entMtx,c_metTestMtx,c_missingMtx,c_pruneMtx,c_spotEntMtx,c_spotMtx,child_entrySent1890);
	child_entrySent1890?0;
	run entrySent189(c_entMtx,c_metTestMtx,c_missingMtx,c_pruneMtx,c_spotEntMtx,c_spotMtx,child_entrySent1891);
	child_entrySent1891?0;
	run entrySent189(c_entMtx,c_metTestMtx,c_missingMtx,c_pruneMtx,c_spotEntMtx,c_spotMtx,child_entrySent1892);
	child_entrySent1892?0;
	run entrySent189(c_entMtx,c_metTestMtx,c_missingMtx,c_pruneMtx,c_spotEntMtx,c_spotMtx,child_entrySent1893);
	child_entrySent1893?0;
	run entryReceived204(c_entMtx,c_metTestMtx,c_missingMtx,c_pruneMtx,c_spotEntMtx,c_spotMtx,child_entryReceived2044);
	child_entryReceived2044?0;
	run Size242(c_entMtx,c_metTestMtx,c_missingMtx,c_pruneMtx,c_spotEntMtx,c_spotMtx,child_Size2425);
	child_Size2425?0;
	run entryReceived204(c_entMtx,c_metTestMtx,c_missingMtx,c_pruneMtx,c_spotEntMtx,c_spotMtx,child_entryReceived2046);
	child_entryReceived2046?0;
	run Size242(c_entMtx,c_metTestMtx,c_missingMtx,c_pruneMtx,c_spotEntMtx,c_spotMtx,child_Size2427);
	child_Size2427?0;
	run entryReceived204(c_entMtx,c_metTestMtx,c_missingMtx,c_pruneMtx,c_spotEntMtx,c_spotMtx,child_entryReceived2048);
	child_entryReceived2048?0;
	run Size242(c_entMtx,c_metTestMtx,c_missingMtx,c_pruneMtx,c_spotEntMtx,c_spotMtx,child_Size2429);
	child_Size2429?0;
	run entryReceived204(c_entMtx,c_metTestMtx,c_missingMtx,c_pruneMtx,c_spotEntMtx,c_spotMtx,child_entryReceived20410);
	child_entryReceived20410?0;
	run Size242(c_entMtx,c_metTestMtx,c_missingMtx,c_pruneMtx,c_spotEntMtx,c_spotMtx,child_Size24211);
	child_Size24211?0;
	run entryReceived204(c_entMtx,c_metTestMtx,c_missingMtx,c_pruneMtx,c_spotEntMtx,c_spotMtx,child_entryReceived20412);
	child_entryReceived20412?0;
	run Size242(c_entMtx,c_metTestMtx,c_missingMtx,c_pruneMtx,c_spotEntMtx,c_spotMtx,child_Size24213);
	child_Size24213?0;
	stop_process: skip;
	child!0
}
proctype entrySent189(Mutexdef c_entMtx;Mutexdef c_metTestMtx;Mutexdef c_missingMtx;Mutexdef c_pruneMtx;Mutexdef c_spotEntMtx;Mutexdef c_spotMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_entMtx.Lock!false;
	c_entMtx.Unlock!false;
	c_spotEntMtx.Lock!false;
	c_spotEntMtx.Unlock!false;
	stop_process: skip;
	child!0
}
proctype entryReceived204(Mutexdef c_entMtx;Mutexdef c_metTestMtx;Mutexdef c_missingMtx;Mutexdef c_pruneMtx;Mutexdef c_spotEntMtx;Mutexdef c_spotMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_c_ackdEntriesc_ackdEntries = -2; // opt var_c_ackdEntriesc_ackdEntries
	c_entMtx.Lock!false;
		defer1: skip;
	c_entMtx.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Size242(Mutexdef c_entMtx;Mutexdef c_metTestMtx;Mutexdef c_missingMtx;Mutexdef c_pruneMtx;Mutexdef c_spotEntMtx;Mutexdef c_spotMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_entMtx.Lock!false;
	goto defer1;
		defer1: skip;
	c_entMtx.Unlock!false;
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

