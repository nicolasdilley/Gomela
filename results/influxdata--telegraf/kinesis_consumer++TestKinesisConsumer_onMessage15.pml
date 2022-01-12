// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/kinesis_consumer/kinesis_consumer_test.go#L15
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestKinesisConsumer_onMessage150 = [1] of {int};
	run TestKinesisConsumer_onMessage15(child_TestKinesisConsumer_onMessage150);
	run receiver(child_TestKinesisConsumer_onMessage150)
stop_process:skip
}

proctype TestKinesisConsumer_onMessage15(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Init3820 = [1] of {int};
	Wgdef k_wg;
	Mutexdef k_recordsTex;
	Mutexdef k_checkpointTex;
	int var_acc_Metrics = -2; // opt var_acc_Metrics
	int var_tests = -2; // opt var_tests
	run mutexMonitor(k_checkpointTex);
	run mutexMonitor(k_recordsTex);
	run wgMonitor(k_wg);
	run Init382(k_wg,k_checkpointTex,k_recordsTex,child_Init3820);
	child_Init3820?0;
	stop_process: skip;
	child!0
}
proctype Init382(Wgdef k_wg;Mutexdef k_checkpointTex;Mutexdef k_recordsTex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_configureProcessContentEncodingFunc3680 = [1] of {int};
	run configureProcessContentEncodingFunc368(k_wg,k_checkpointTex,k_recordsTex,child_configureProcessContentEncodingFunc3680);
	child_configureProcessContentEncodingFunc3680?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype configureProcessContentEncodingFunc368(Wgdef k_wg;Mutexdef k_checkpointTex;Mutexdef k_recordsTex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true;
	:: true;
	:: true;
	:: true -> 
		goto stop_process
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

