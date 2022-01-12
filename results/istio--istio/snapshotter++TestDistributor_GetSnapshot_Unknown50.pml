// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob//galley/pkg/config/processing/snapshotter/distributor_test.go#L50
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDistributor_GetSnapshot_Unknown500 = [1] of {int};
	run TestDistributor_GetSnapshot_Unknown50(child_TestDistributor_GetSnapshot_Unknown500);
	run receiver(child_TestDistributor_GetSnapshot_Unknown500)
stop_process:skip
}

proctype TestDistributor_GetSnapshot_Unknown50(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetSnapshot701 = [1] of {int};
	chan child_Distribute610 = [1] of {int};
	Mutexdef d_snapshotsLock;
	run mutexMonitor(d_snapshotsLock);
	run Distribute61(d_snapshotsLock,child_Distribute610);
	child_Distribute610?0;
	run GetSnapshot70(d_snapshotsLock,child_GetSnapshot701);
	child_GetSnapshot701?0;
	stop_process: skip;
	child!0
}
proctype Distribute61(Mutexdef d_snapshotsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	d_snapshotsLock.Lock!false;
		defer1: skip;
	d_snapshotsLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype GetSnapshot70(Mutexdef d_snapshotsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	d_snapshotsLock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	d_snapshotsLock.Unlock!false;
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

