// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/statsd/statsd_test.go#L197
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
	chan child_TestParse_ValidLines1970 = [1] of {int};
	run TestParse_ValidLines197(child_TestParse_ValidLines1970);
	run receiver(child_TestParse_ValidLines1970)
stop_process:skip
}

proctype TestParse_ValidLines197(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_parseStatsdLine6020 = [1] of {int};
	chan child_parseStatsdLine6021 = [1] of {int};
	Wgdef s_wg;
	Mutexdef s_cleanup;
	int var_validLines = -2; // opt var_validLines
	run mutexMonitor(s_cleanup);
	run wgMonitor(s_wg);
	

	if
	:: var_validLines-1 != -3 -> 
				for(i : 0.. var_validLines-1) {
			for10: skip;
			run parseStatsdLine602(s_wg,s_cleanup,child_parseStatsdLine6020);
			child_parseStatsdLine6020?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for117: skip;
			run parseStatsdLine602(s_wg,s_cleanup,child_parseStatsdLine6021);
			child_parseStatsdLine6021?0;
			for117_end: skip
		:: true -> 
			break
		od;
		for117_exit: skip
	fi;
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
			for13: skip;
			

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
			for13_end: skip
		};
		for13_exit: skip
	:: else -> 
		do
		:: true -> 
			for112: skip;
			

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
			for112_end: skip
		:: true -> 
			break
		od;
		for112_exit: skip
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

