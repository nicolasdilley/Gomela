// num_comm_params=3
// num_mand_comm_params=0
// num_opt_comm_params=3

// git_link=https://github.com/grafana/loki/blob/aa544a9dffdb8e78f7d7ed8edafce466d333b0a8/clients/pkg/logentry/stages/metrics_test.go#L252
#define not_found_35  -2 // opt stgs line 27
#define not_found_63  -2 // opt stgs line 27
#define not_found_90  -2 // opt stgs line 27
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDefaultIdleDuration2520 = [1] of {int};
	run TestDefaultIdleDuration252(child_TestDefaultIdleDuration2520);
	run receiver(child_TestDefaultIdleDuration2520)
stop_process:skip
}

proctype TestDefaultIdleDuration252(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_New700 = [1] of {int};
	Mutexdef registry_mtx;
	run mutexMonitor(registry_mtx);
	run New70(registry_mtx,child_New700);
	child_New700?0;
	stop_process: skip;
	child!0
}
proctype New70(Mutexdef registerer_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewDocker110 = [1] of {int};
	chan child_NewCRI391 = [1] of {int};
	chan child_newMetricStage882 = [1] of {int};
	chan child_newMatcherStage703 = [1] of {int};
	chan child_newDropStage794 = [1] of {int};
	chan child_newPackStage1255 = [1] of {int};
	

	if
	:: true -> 
		run NewDocker11(registerer_mtx,child_NewDocker110);
		child_NewDocker110?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		run NewCRI39(registerer_mtx,child_NewCRI391);
		child_NewCRI391?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		run newMetricStage88(registerer_mtx,child_newMetricStage882);
		child_newMetricStage882?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		run newMatcherStage70(registerer_mtx,child_newMatcherStage703);
		child_newMatcherStage703?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		run newDropStage79(registerer_mtx,child_newDropStage794);
		child_newDropStage794?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		run newPackStage125(registerer_mtx,child_newPackStage1255);
		child_newPackStage1255?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		goto stop_process
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewDocker11(Mutexdef registerer_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewPipeline270 = [1] of {int};
	run NewPipeline27(registerer_mtx,not_found_35,child_NewPipeline270);
	child_NewPipeline270?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewPipeline27(Mutexdef registerer_mtx;int var_stgs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_New700 = [1] of {int};
	chan child_New701 = [1] of {int};
	chan child_New702 = [1] of {int};
	chan child_New703 = [1] of {int};
	int var_stage = -2; // opt var_stage
	

	if
	:: var_stgs-1 != -3 -> 
				for(i : 0.. var_stgs-1) {
			for10: skip;
			

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
			:: var_stage-1 != -3 -> 
								for(i : 0.. var_stage-1) {
					for11: skip;
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					run New70(registerer_mtx,child_New700);
					child_New700?0;
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					for11_end: skip
				};
				for11_exit: skip
			:: else -> 
				do
				:: true -> 
					for12: skip;
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					run New70(registerer_mtx,child_New701);
					child_New701?0;
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					for12_end: skip
				:: true -> 
					break
				od;
				for12_exit: skip
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			

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
			:: var_stage-1 != -3 -> 
								for(i : 0.. var_stage-1) {
					for14: skip;
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					run New70(registerer_mtx,child_New702);
					child_New702?0;
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					for14_end: skip
				};
				for14_exit: skip
			:: else -> 
				do
				:: true -> 
					for15: skip;
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					run New70(registerer_mtx,child_New703);
					child_New703?0;
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					for15_end: skip
				:: true -> 
					break
				od;
				for15_exit: skip
			fi;
			for13_end: skip
		:: true -> 
			break
		od;
		for13_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewCRI39(Mutexdef registerer_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewPipeline271 = [1] of {int};
	run NewPipeline27(registerer_mtx,not_found_63,child_NewPipeline271);
	child_NewPipeline271?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newMetricStage88(Mutexdef registry_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_cfgs = -2; // opt var_cfgs
	

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
proctype newMatcherStage70(Mutexdef registerer_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewPipeline273 = [1] of {int};
	

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
		run NewPipeline27(registerer_mtx,not_found_90,child_NewPipeline273);
		child_NewPipeline273?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
proctype newDropStage79(Mutexdef registerer_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
proctype newPackStage125(Mutexdef registerer_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

