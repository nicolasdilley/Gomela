// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//x-pack/dockerlogbeat/pipelinemanager/libbeattools.go#L51
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
	chan child_loadNewPipeline510 = [1] of {int};
	run loadNewPipeline51(child_loadNewPipeline510);
	run receiver(child_loadNewPipeline510)
stop_process:skip
}

proctype loadNewPipeline51(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef pipeline_guardStartSigPropagation_m;
	Mutexdef pipeline_eventSema_mutex;
	Wgdef pipeline_waitCloser_events;
	Wgdef pipeline_eventer_waitClose_events;
	Mutexdef pipeline_eventer_mutex;
	Wgdef pipeline_output_consumer_wg;
	Wgdef pipeline_output_retryer_doneWaiter;
	Mutexdef pipeline_output_monitors_Tracer_statsMu;
	Mutexdef pipeline_output_monitors_Telemetry_mu;
	Mutexdef pipeline_output_monitors_Metrics_mu;
	Mutexdef pipeline_monitors_Tracer_statsMu;
	Mutexdef pipeline_monitors_Tracer_breakdownMetrics_mu;
	Mutexdef pipeline_monitors_Telemetry_mu;
	Mutexdef pipeline_monitors_Metrics_mu;
	

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
	run mutexMonitor(pipeline_monitors_Metrics_mu);
	run mutexMonitor(pipeline_monitors_Telemetry_mu);
	run mutexMonitor(pipeline_monitors_Tracer_breakdownMetrics_mu);
	run mutexMonitor(pipeline_monitors_Tracer_statsMu);
	run mutexMonitor(pipeline_output_monitors_Metrics_mu);
	run mutexMonitor(pipeline_output_monitors_Telemetry_mu);
	run mutexMonitor(pipeline_output_monitors_Tracer_statsMu);
	run wgMonitor(pipeline_output_retryer_doneWaiter);
	run wgMonitor(pipeline_output_consumer_wg);
	run mutexMonitor(pipeline_eventer_mutex);
	run wgMonitor(pipeline_eventer_waitClose_events);
	run wgMonitor(pipeline_waitCloser_events);
	run mutexMonitor(pipeline_eventSema_mutex);
	run mutexMonitor(pipeline_guardStartSigPropagation_m);
	

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

