// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kops/blob//pkg/model/openstackmodel/servergroup_test.go#L987
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_RunGoldenTest9870 = [1] of {int};
	run RunGoldenTest987(child_RunGoldenTest9870);
	run receiver(child_RunGoldenTest9870)
stop_process:skip
}

proctype RunGoldenTest987(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close1040 = [1] of {int};
	chan child_MockKopsVersion3411 = [1] of {int};
	Mutexdef h_T_context_mu;
	Mutexdef h_T_context_match_mu;
	run mutexMonitor(h_T_context_match_mu);
	run mutexMonitor(h_T_context_mu);
	run MockKopsVersion341(h_T_context_match_mu,h_T_context_mu,child_MockKopsVersion3411);
	child_MockKopsVersion3411?0;
		defer1: skip;
	run Close104(h_T_context_match_mu,h_T_context_mu,child_Close1040);
	child_Close1040?0;
	stop_process: skip;
	child!0
}
proctype Close104(Mutexdef h_T_context_match_mu;Mutexdef h_T_context_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype MockKopsVersion341(Mutexdef h_T_context_match_mu;Mutexdef h_T_context_mu;chan child) {
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

