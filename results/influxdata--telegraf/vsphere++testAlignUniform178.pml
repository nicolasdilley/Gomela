// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/vsphere/vsphere_test.go#L178
#define def_var_n  -2 // opt n line 178
#define def_var_info  -2 // opt info line 1042
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testAlignUniform1780 = [1] of {int};
	run testAlignUniform178(def_var_n,child_testAlignUniform1780);
	run receiver(child_testAlignUniform1780)
stop_process:skip
}

proctype testAlignUniform178(int var_n;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_alignSamples10420 = [1] of {int};
	int var_info = def_var_info;
	Mutexdef e_metricNameMux;
	Mutexdef e_busy;
	Mutexdef e_clientFactory_mux;
	Mutexdef e_clientFactory_client_closeGate_m;
	Mutexdef e_collectMux;
	Mutexdef e_hwMarks_mux;
	int var_newValues = -2; // opt var_newValues
	run mutexMonitor(e_hwMarks_mux);
	run mutexMonitor(e_collectMux);
	run mutexMonitor(e_clientFactory_client_closeGate_m);
	run mutexMonitor(e_clientFactory_mux);
	run mutexMonitor(e_busy);
	run mutexMonitor(e_metricNameMux);
	run alignSamples1042(e_busy,e_clientFactory_client_closeGate_m,e_clientFactory_mux,e_collectMux,e_hwMarks_mux,e_metricNameMux,var_info,child_alignSamples10420);
	child_alignSamples10420?0;
	stop_process: skip;
	child!0
}
proctype alignSamples1042(Mutexdef e_busy;Mutexdef e_clientFactory_client_closeGate_m;Mutexdef e_clientFactory_mux;Mutexdef e_collectMux;Mutexdef e_hwMarks_mux;Mutexdef e_metricNameMux;int var_info;chan child) {
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

proctype receiver(chan c) {
c?0
}

