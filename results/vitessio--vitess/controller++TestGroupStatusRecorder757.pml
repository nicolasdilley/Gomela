// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtgr/controller/diagnose_test.go#L757
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGroupStatusRecorder7570 = [1] of {int};
	run TestGroupStatusRecorder757(child_TestGroupStatusRecorder7570);
	run receiver(child_TestGroupStatusRecorder7570)
stop_process:skip
}

proctype TestGroupStatusRecorder757(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_recordGroupGTIDs4561 = [1] of {int};
	Mutexdef inst2_tablet_state_atomicMessageInfo_initMu;
	chan child_recordGroupGTIDs4560 = [1] of {int};
	Mutexdef inst1_tablet_state_atomicMessageInfo_initMu;
	run mutexMonitor(inst1_tablet_state_atomicMessageInfo_initMu);
	run recordGroupGTIDs456(inst1_tablet_state_atomicMessageInfo_initMu,child_recordGroupGTIDs4560);
	child_recordGroupGTIDs4560?0;
	run mutexMonitor(inst2_tablet_state_atomicMessageInfo_initMu);
	run recordGroupGTIDs456(inst2_tablet_state_atomicMessageInfo_initMu,child_recordGroupGTIDs4561);
	child_recordGroupGTIDs4561?0;
	stop_process: skip;
	child!0
}
proctype recordGroupGTIDs456(Mutexdef instance_tablet_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

