
// https://github.com/hashicorp/packer/blob/master/post-processor/digitalocean-import/post-processor.go#L151
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_PostProcess1510 = [1] of {int};
	run PostProcess151(child_PostProcess1510)
stop_process:skip
}

proctype PostProcess151(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_deleteImageFromSpaces3811 = [1] of {int};
	chan child_uploadImageToSpaces2690 = [1] of {int};
	Mutexdef sess_options_Config_Credentials_m;
	Mutexdef sess_options_Config_Credentials_sf_mu;
	Mutexdef sess_Config_Credentials_m;
	Mutexdef sess_Config_Credentials_sf_mu;
	Mutexdef spacesConfig_Credentials_m;
	Mutexdef spacesConfig_Credentials_sf_mu;
	Mutexdef spacesCreds_m;
	Mutexdef spacesCreds_sf_mu;
	

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
	run mutexMonitor(spacesCreds_sf_mu);
	run mutexMonitor(spacesCreds_m);
	run mutexMonitor(spacesConfig_Credentials_sf_mu);
	run mutexMonitor(spacesConfig_Credentials_m);
	run mutexMonitor(sess_Config_Credentials_sf_mu);
	run mutexMonitor(sess_Config_Credentials_m);
	run mutexMonitor(sess_options_Config_Credentials_sf_mu);
	run mutexMonitor(sess_options_Config_Credentials_m);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run uploadImageToSpaces269(sess_Config_Credentials_sf_mu,sess_Config_Credentials_m,sess_options_Config_Credentials_sf_mu,sess_options_Config_Credentials_m,child_uploadImageToSpaces2690);
	child_uploadImageToSpaces2690?0;
	

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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		run deleteImageFromSpaces381(sess_Config_Credentials_sf_mu,sess_Config_Credentials_m,sess_options_Config_Credentials_sf_mu,sess_options_Config_Credentials_m,child_deleteImageFromSpaces3811);
		child_deleteImageFromSpaces3811?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype uploadImageToSpaces269(Mutexdef s_Config_Credentials_sf_mu;Mutexdef s_Config_Credentials_m;Mutexdef s_options_Config_Credentials_sf_mu;Mutexdef s_options_Config_Credentials_m;chan child) {
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
proctype deleteImageFromSpaces381(Mutexdef s_Config_Credentials_sf_mu;Mutexdef s_Config_Credentials_m;Mutexdef s_options_Config_Credentials_sf_mu;Mutexdef s_options_Config_Credentials_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

