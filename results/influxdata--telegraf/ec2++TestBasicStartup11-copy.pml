// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/processors/aws/ec2/ec2_test.go#L11
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBasicStartup110 = [1] of {int};
	run TestBasicStartup11(child_TestBasicStartup110);
	run receiver(child_TestBasicStartup110)
stop_process:skip
}

proctype TestBasicStartup11(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Init1210 = [1] of {int};
	Mutexdef p_imdsClient_options_tokenProvider_tokenMux;
	run mutexMonitor(p_imdsClient_options_tokenProvider_tokenMux);
	run Init121(p_imdsClient_options_tokenProvider_tokenMux,child_Init1210);
	child_Init1210?0;
	stop_process: skip;
	child!0
}
proctype Init121(Mutexdef r_imdsClient_options_tokenProvider_tokenMux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_r_ImdsTags = -2; // opt var_r_ImdsTags
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

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

