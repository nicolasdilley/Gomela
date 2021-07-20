// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grafana/loki/blob/aa544a9dffdb8e78f7d7ed8edafce466d333b0a8/pkg/canary/comparator/comparator_test.go#L260
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSpotCheck2600 = [1] of {int};
	run TestSpotCheck260(child_TestSpotCheck2600);
	run receiver(child_TestSpotCheck2600)
stop_process:skip
}

proctype TestSpotCheck260(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_spotCheckEntries3223 = [1] of {int};
	chan child_spotCheckEntries3222 = [1] of {int};
	chan child_entrySent1890 = [1] of {int};
	chan child_entrySent1891 = [1] of {int};
	Mutexdef c_pruneMtx;
	Mutexdef c_metTestMtx;
	Mutexdef c_spotMtx;
	Mutexdef c_spotEntMtx;
	Mutexdef c_missingMtx;
	Mutexdef c_entMtx;
	int var_entriesentries = -2; // opt var_entriesentries
	run mutexMonitor(c_entMtx);
	run mutexMonitor(c_missingMtx);
	run mutexMonitor(c_spotEntMtx);
	run mutexMonitor(c_spotMtx);
	run mutexMonitor(c_metTestMtx);
	run mutexMonitor(c_pruneMtx);
	

	if
	:: var_entries-1 != -3 -> 
				for(i : 0.. var_entries-1) {
			for20: skip;
			run entrySent189(c_entMtx,c_metTestMtx,c_missingMtx,c_pruneMtx,c_spotEntMtx,c_spotMtx,child_entrySent1890);
			child_entrySent1890?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			run entrySent189(c_entMtx,c_metTestMtx,c_missingMtx,c_pruneMtx,c_spotEntMtx,c_spotMtx,child_entrySent1891);
			child_entrySent1891?0;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	run spotCheckEntries322(c_entMtx,c_metTestMtx,c_missingMtx,c_pruneMtx,c_spotEntMtx,c_spotMtx,child_spotCheckEntries3222);
	child_spotCheckEntries3222?0;
	run spotCheckEntries322(c_entMtx,c_metTestMtx,c_missingMtx,c_pruneMtx,c_spotEntMtx,c_spotMtx,child_spotCheckEntries3223);
	child_spotCheckEntries3223?0;
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
proctype spotCheckEntries322(Mutexdef c_entMtx;Mutexdef c_metTestMtx;Mutexdef c_missingMtx;Mutexdef c_pruneMtx;Mutexdef c_spotEntMtx;Mutexdef c_spotMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_recvdrecvd = -2; // opt var_recvdrecvd
	int var_cpycpy = -2; // opt var_cpycpy
	c_spotEntMtx.Lock!false;
	c_spotEntMtx.Unlock!false;
		defer1: skip;
	c_spotMtx.Lock!false;
	c_spotMtx.Unlock!false;
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

