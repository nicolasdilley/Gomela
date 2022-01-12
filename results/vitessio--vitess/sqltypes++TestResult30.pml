// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/sqltypes/proto3_test.go#L30
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestResult300 = [1] of {int};
	run TestResult30(child_TestResult300);
	run receiver(child_TestResult300)
stop_process:skip
}

proctype TestResult30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CustomProto3ToResult1271 = [1] of {int};
	chan child_Proto3ToResult1120 = [1] of {int};
	Mutexdef p3converted_state_atomicMessageInfo_initMu;
	Mutexdef p3Result_state_atomicMessageInfo_initMu;
	run mutexMonitor(p3Result_state_atomicMessageInfo_initMu);
	run mutexMonitor(p3converted_state_atomicMessageInfo_initMu);
	run Proto3ToResult112(p3Result_state_atomicMessageInfo_initMu,child_Proto3ToResult1120);
	child_Proto3ToResult1120?0;
	run CustomProto3ToResult127(p3Result_state_atomicMessageInfo_initMu,child_CustomProto3ToResult1271);
	child_CustomProto3ToResult1271?0;
	stop_process: skip;
	child!0
}
proctype Proto3ToResult112(Mutexdef qr_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype CustomProto3ToResult127(Mutexdef qr_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

proctype receiver(chan c) {
c?0
}

