// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/hashicorp/packer/blob//post-processor/yandex-export/step-create-s3-keys.go#L107
#define def_var_paths  -2 // opt paths line 107
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_cleanUpEmptyObjects1070 = [1] of {int};
	run cleanUpEmptyObjects107(def_var_paths,child_cleanUpEmptyObjects1070);
	run receiver(child_cleanUpEmptyObjects1070)
stop_process:skip
}

proctype cleanUpEmptyObjects107(int var_paths;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef newSession_options_Config_Credentials_m;
	Mutexdef newSession_Config_Credentials_m;
	Mutexdef newSession_Config_Credentials_sf_mu;
	run mutexMonitor(newSession_Config_Credentials_sf_mu);
	run mutexMonitor(newSession_Config_Credentials_m);
	run mutexMonitor(newSession_options_Config_Credentials_m);
	

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

