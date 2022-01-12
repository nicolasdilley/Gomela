// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/packer/blob//packer/build_test.go#L172
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBuildPrepare_variables_default1720 = [1] of {int};
	run TestBuildPrepare_variables_default172(child_TestBuildPrepare_variables_default1720);
	run receiver(child_TestBuildPrepare_variables_default1720)
stop_process:skip
}

proctype TestBuildPrepare_variables_default172(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Prepare720 = [1] of {int};
	Mutexdef build_l;
	run mutexMonitor(build_l);
	run Prepare72(build_l,child_Prepare720);
	child_Prepare720?0;
	stop_process: skip;
	child!0
}
proctype Prepare72(Mutexdef b_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_ppSeq = -2; // opt var_ppSeq
	int var_b_PostProcessors = -2; // opt var_b_PostProcessors
	int var_b_Provisioners = -2; // opt var_b_Provisioners
	int var_generatedVars = -2; // opt var_generatedVars
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	b_l.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	b_l.Unlock!false;
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

