
// https://github.com/k6io/k6/blob/master/stats/stats_test.go#L260
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSampleImplementations2600 = [1] of {int};
	run TestSampleImplementations260(child_TestSampleImplementations2600)
stop_process:skip
}

proctype TestSampleImplementations260(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetTags3954 = [1] of {int};
	chan child_GetTags3953 = [1] of {int};
	chan child_GetTime4012 = [1] of {int};
	chan child_GetSamples3891 = [1] of {int};
	chan child_GetSamples3890 = [1] of {int};
	Mutexdef sample_Metric_Thresholds_Runtime_vm_interruptLock;
	Mutexdef sample_Metric_Thresholds_Runtime_vm_prg_src_mu;
	run mutexMonitor(sample_Metric_Thresholds_Runtime_vm_prg_src_mu);
	run mutexMonitor(sample_Metric_Thresholds_Runtime_vm_interruptLock);
	run GetSamples389(sample_Metric_Thresholds_Runtime_vm_prg_src_mu,sample_Metric_Thresholds_Runtime_vm_interruptLock,child_GetSamples3890);
	child_GetSamples3890?0;
	run GetSamples389(sample_Metric_Thresholds_Runtime_vm_prg_src_mu,sample_Metric_Thresholds_Runtime_vm_interruptLock,child_GetSamples3891);
	child_GetSamples3891?0;
	run GetTime401(sample_Metric_Thresholds_Runtime_vm_prg_src_mu,sample_Metric_Thresholds_Runtime_vm_interruptLock,child_GetTime4012);
	child_GetTime4012?0;
	run GetTags395(sample_Metric_Thresholds_Runtime_vm_prg_src_mu,sample_Metric_Thresholds_Runtime_vm_interruptLock,child_GetTags3953);
	child_GetTags3953?0;
	run GetTags395(sample_Metric_Thresholds_Runtime_vm_prg_src_mu,sample_Metric_Thresholds_Runtime_vm_interruptLock,child_GetTags3954);
	child_GetTags3954?0;
	stop_process: skip;
	child!0
}
proctype GetSamples389(Mutexdef s_Metric_Thresholds_Runtime_vm_prg_src_mu;Mutexdef s_Metric_Thresholds_Runtime_vm_interruptLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetTime401(Mutexdef s_Metric_Thresholds_Runtime_vm_prg_src_mu;Mutexdef s_Metric_Thresholds_Runtime_vm_interruptLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetTags395(Mutexdef s_Metric_Thresholds_Runtime_vm_prg_src_mu;Mutexdef s_Metric_Thresholds_Runtime_vm_interruptLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

