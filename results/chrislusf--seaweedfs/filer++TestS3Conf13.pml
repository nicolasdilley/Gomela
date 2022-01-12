// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/chrislusf/seaweedfs/blob//weed/filer/s3iam_conf_test.go#L13
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestS3Conf130 = [1] of {int};
	run TestS3Conf13(child_TestS3Conf130);
	run receiver(child_TestS3Conf130)
stop_process:skip
}

proctype TestS3Conf13(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ParseS3ConfigurationFromBytes111 = [1] of {int};
	Mutexdef s3ConfSaved_state_atomicMessageInfo_initMu;
	chan child_ProtoToText180 = [1] of {int};
	Mutexdef s3Conf_state_atomicMessageInfo_initMu;
	run mutexMonitor(s3Conf_state_atomicMessageInfo_initMu);
	run ProtoToText18(s3Conf_state_atomicMessageInfo_initMu,child_ProtoToText180);
	child_ProtoToText180?0;
	run mutexMonitor(s3ConfSaved_state_atomicMessageInfo_initMu);
	run ParseS3ConfigurationFromBytes11(s3ConfSaved_state_atomicMessageInfo_initMu,child_ParseS3ConfigurationFromBytes111);
	child_ParseS3ConfigurationFromBytes111?0;
	stop_process: skip;
	child!0
}
proctype ProtoToText18(Mutexdef config_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ParseS3ConfigurationFromBytes11(Mutexdef config_state_atomicMessageInfo_initMu;chan child) {
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

