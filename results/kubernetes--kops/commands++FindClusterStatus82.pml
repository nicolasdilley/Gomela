// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kops/blob//pkg/commands/status_discovery.go#L82
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_FindClusterStatus820 = [1] of {int};
	run FindClusterStatus82(child_FindClusterStatus820);
	run receiver(child_FindClusterStatus820)
stop_process:skip
}

proctype FindClusterStatus82(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_FindClusterStatus2350 = [1] of {int};
	Mutexdef doCloud_Client_ratemtx;
	

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
	run mutexMonitor(doCloud_Client_ratemtx);
	

	if
	:: true -> 
		run FindClusterStatus235(doCloud_Client_ratemtx,child_FindClusterStatus2350);
		child_FindClusterStatus2350?0;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype FindClusterStatus235(Mutexdef c_Client_ratemtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_findEtcdStatus2480 = [1] of {int};
	run findEtcdStatus248(c_Client_ratemtx,child_findEtcdStatus2480);
	child_findEtcdStatus2480?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype findEtcdStatus248(Mutexdef c_Client_ratemtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getEtcdClusterSpec3121 = [1] of {int};
	chan child_getEtcdClusterSpec3122 = [1] of {int};
	chan child_getEtcdClusterSpec3123 = [1] of {int};
	chan child_getEtcdClusterSpec3124 = [1] of {int};
	chan child_getEtcdClusterSpec3125 = [1] of {int};
	chan child_getEtcdClusterSpec3126 = [1] of {int};
	chan child_getEtcdClusterSpec3127 = [1] of {int};
	chan child_getEtcdClusterSpec3128 = [1] of {int};
	chan child_getAllVolumesByRegion1540 = [1] of {int};
	int var_statusMap = -2; // opt var_statusMap
	int var_volume_Tags = -2; // opt var_volume_Tags
	int var_volumes = -2; // opt var_volumes
	run getAllVolumesByRegion154(c_Client_ratemtx,child_getAllVolumesByRegion1540);
	child_getAllVolumesByRegion1540?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: var_volumes-1 != -3 -> 
				for(i : 0.. var_volumes-1) {
			for20: skip;
			

			if
			:: var_volume_Tags-1 != -3 -> 
								for(i : 0.. var_volume_Tags-1) {
					for21: skip;
					

					if
					:: true -> 
						

						if
						:: var_volume_Tags-1 != -3 -> 
														for(i : 0.. var_volume_Tags-1) {
								for22: skip;
								

								if
								:: true -> 
									

									if
									:: true -> 
										goto stop_process
									:: true;
									fi;
									run getEtcdClusterSpec312(c_Client_ratemtx,child_getEtcdClusterSpec3121);
									child_getEtcdClusterSpec3121?0;
									

									if
									:: true -> 
										goto stop_process
									:: true;
									fi
								:: true;
								fi;
								for22_end: skip
							};
							for22_exit: skip
						:: else -> 
							do
							:: true -> 
								for23: skip;
								

								if
								:: true -> 
									

									if
									:: true -> 
										goto stop_process
									:: true;
									fi;
									run getEtcdClusterSpec312(c_Client_ratemtx,child_getEtcdClusterSpec3122);
									child_getEtcdClusterSpec3122?0;
									

									if
									:: true -> 
										goto stop_process
									:: true;
									fi
								:: true;
								fi;
								for23_end: skip
							:: true -> 
								break
							od;
							for23_exit: skip
						fi
					:: true;
					fi;
					for21_end: skip
				};
				for21_exit: skip
			:: else -> 
				do
				:: true -> 
					for24: skip;
					

					if
					:: true -> 
						

						if
						:: var_volume_Tags-1 != -3 -> 
														for(i : 0.. var_volume_Tags-1) {
								for25: skip;
								

								if
								:: true -> 
									

									if
									:: true -> 
										goto stop_process
									:: true;
									fi;
									run getEtcdClusterSpec312(c_Client_ratemtx,child_getEtcdClusterSpec3123);
									child_getEtcdClusterSpec3123?0;
									

									if
									:: true -> 
										goto stop_process
									:: true;
									fi
								:: true;
								fi;
								for25_end: skip
							};
							for25_exit: skip
						:: else -> 
							do
							:: true -> 
								for26: skip;
								

								if
								:: true -> 
									

									if
									:: true -> 
										goto stop_process
									:: true;
									fi;
									run getEtcdClusterSpec312(c_Client_ratemtx,child_getEtcdClusterSpec3124);
									child_getEtcdClusterSpec3124?0;
									

									if
									:: true -> 
										goto stop_process
									:: true;
									fi
								:: true;
								fi;
								for26_end: skip
							:: true -> 
								break
							od;
							for26_exit: skip
						fi
					:: true;
					fi;
					for24_end: skip
				:: true -> 
					break
				od;
				for24_exit: skip
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for27: skip;
			

			if
			:: var_volume_Tags-1 != -3 -> 
								for(i : 0.. var_volume_Tags-1) {
					for28: skip;
					

					if
					:: true -> 
						

						if
						:: var_volume_Tags-1 != -3 -> 
														for(i : 0.. var_volume_Tags-1) {
								for29: skip;
								

								if
								:: true -> 
									

									if
									:: true -> 
										goto stop_process
									:: true;
									fi;
									run getEtcdClusterSpec312(c_Client_ratemtx,child_getEtcdClusterSpec3125);
									child_getEtcdClusterSpec3125?0;
									

									if
									:: true -> 
										goto stop_process
									:: true;
									fi
								:: true;
								fi;
								for29_end: skip
							};
							for29_exit: skip
						:: else -> 
							do
							:: true -> 
								for210: skip;
								

								if
								:: true -> 
									

									if
									:: true -> 
										goto stop_process
									:: true;
									fi;
									run getEtcdClusterSpec312(c_Client_ratemtx,child_getEtcdClusterSpec3126);
									child_getEtcdClusterSpec3126?0;
									

									if
									:: true -> 
										goto stop_process
									:: true;
									fi
								:: true;
								fi;
								for210_end: skip
							:: true -> 
								break
							od;
							for210_exit: skip
						fi
					:: true;
					fi;
					for28_end: skip
				};
				for28_exit: skip
			:: else -> 
				do
				:: true -> 
					for211: skip;
					

					if
					:: true -> 
						

						if
						:: var_volume_Tags-1 != -3 -> 
														for(i : 0.. var_volume_Tags-1) {
								for212: skip;
								

								if
								:: true -> 
									

									if
									:: true -> 
										goto stop_process
									:: true;
									fi;
									run getEtcdClusterSpec312(c_Client_ratemtx,child_getEtcdClusterSpec3127);
									child_getEtcdClusterSpec3127?0;
									

									if
									:: true -> 
										goto stop_process
									:: true;
									fi
								:: true;
								fi;
								for212_end: skip
							};
							for212_exit: skip
						:: else -> 
							do
							:: true -> 
								for213: skip;
								

								if
								:: true -> 
									

									if
									:: true -> 
										goto stop_process
									:: true;
									fi;
									run getEtcdClusterSpec312(c_Client_ratemtx,child_getEtcdClusterSpec3128);
									child_getEtcdClusterSpec3128?0;
									

									if
									:: true -> 
										goto stop_process
									:: true;
									fi
								:: true;
								fi;
								for213_end: skip
							:: true -> 
								break
							od;
							for213_exit: skip
						fi
					:: true;
					fi;
					for211_end: skip
				:: true -> 
					break
				od;
				for211_exit: skip
			fi;
			for27_end: skip
		:: true -> 
			break
		od;
		for27_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getAllVolumesByRegion154(Mutexdef cloud_Client_ratemtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getEtcdClusterSpec312(Mutexdef c_Client_ratemtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		fi
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

