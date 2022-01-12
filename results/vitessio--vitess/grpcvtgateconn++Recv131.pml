// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtgate/grpcvtgateconn/conn.go#L131
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Recv1310 = [1] of {int};
	run Recv131(child_Recv1310);
	run receiver(child_Recv1310)
stop_process:skip
}

proctype Recv131(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CustomProto3ToResult1270 = [1] of {int};
	Mutexdef qr_state_atomicMessageInfo_initMu;
	run mutexMonitor(qr_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run CustomProto3ToResult127(qr_state_atomicMessageInfo_initMu,child_CustomProto3ToResult1270);
	child_CustomProto3ToResult1270?0;
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

