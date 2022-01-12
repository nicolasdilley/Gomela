// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/statsd/statsd_test.go#L1411
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
	chan child_TestParse_Timings_Delete14110 = [1] of {int};
	run TestParse_Timings_Delete1411(child_TestParse_Timings_Delete14110);
	run receiver(child_TestParse_Timings_Delete14110)
stop_process:skip
}

proctype TestParse_Timings_Delete1411(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Gather2921 = [1] of {int};
	chan child_parseStatsdLine6020 = [1] of {int};
	Wgdef s_wg;
	Mutexdef s_cleanup;
	run mutexMonitor(s_cleanup);
	run wgMonitor(s_wg);
	run parseStatsdLine602(s_wg,s_cleanup,child_parseStatsdLine6020);
	child_parseStatsdLine6020?0;
	run Gather292(s_wg,s_cleanup,child_Gather2921);
	child_Gather2921?0;
	stop_process: skip;
	child!0
}
proctype parseStatsdLine602(Wgdef s_wg;Mutexdef s_cleanup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_aggregate8101 = [1] of {int};
	chan child_parseName7480 = [1] of {int};
	chan child_aggregate8103 = [1] of {int};
	chan child_parseName7482 = [1] of {int};
	int var_m_tags = -2; // opt var_m_tags
	int var_lineTags = -2; // opt var_lineTags
	int var_bits = -2; // opt var_bits
	int var_pipesplit = -2; // opt var_pipesplit
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: var_bits-1 != -3 -> 
				for(i : 0.. var_bits-1) {
			for20: skip;
			

			if
			:: true -> 
				goto stop_process
			fi;
			

			if
			:: true;
			:: true -> 
				goto stop_process
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true;
				fi
			:: true;
			fi;
			run parseName748(s_wg,s_cleanup,child_parseName7480);
			child_parseName7480?0;
			

			if
			:: true;
			:: true;
			:: true;
			:: true;
			:: true;
			:: true;
			fi;
			run aggregate810(s_wg,s_cleanup,child_aggregate8101);
			child_aggregate8101?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for29: skip;
			

			if
			:: true -> 
				goto stop_process
			fi;
			

			if
			:: true;
			:: true -> 
				goto stop_process
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true;
				fi
			:: true;
			fi;
			run parseName748(s_wg,s_cleanup,child_parseName7482);
			child_parseName7482?0;
			

			if
			:: true;
			:: true;
			:: true;
			:: true;
			:: true;
			:: true;
			fi;
			run aggregate810(s_wg,s_cleanup,child_aggregate8103);
			child_aggregate8103?0;
			for29_end: skip
		:: true -> 
			break
		od;
		for29_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype parseName748(Wgdef s_wg;Mutexdef s_cleanup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype aggregate810(Wgdef s_wg;Mutexdef s_cleanup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_m_samplerate = -2; // opt var_m_samplerate
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype Gather292(Wgdef s_wg;Mutexdef s_cleanup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_expireCachedMetrics10421 = [1] of {int};
	int var_s_sets = -2; // opt var_s_sets
	int var_s_counters = -2; // opt var_s_counters
	int var_s_gauges = -2; // opt var_s_gauges
	int var_s_Percentiles = -2; // opt var_s_Percentiles
	int var_m_fields = -2; // opt var_m_fields
	int var_s_timings = -2; // opt var_s_timings
	int var_s_distributions = -2; // opt var_s_distributions
	run expireCachedMetrics1042(s_wg,s_cleanup,child_expireCachedMetrics10421);
	child_expireCachedMetrics10421?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype expireCachedMetrics1042(Wgdef s_wg;Mutexdef s_cleanup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_s_counters = -2; // opt var_s_counters
	int var_s_timings = -2; // opt var_s_timings
	int var_s_sets = -2; // opt var_s_sets
	int var_s_gauges = -2; // opt var_s_gauges
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

