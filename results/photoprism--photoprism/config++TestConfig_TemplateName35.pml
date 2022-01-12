// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/server_test.go#L35
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_TemplateName350 = [1] of {int};
	run TestConfig_TemplateName35(child_TestConfig_TemplateName350);
	run receiver(child_TestConfig_TemplateName350)
stop_process:skip
}

proctype TestConfig_TemplateName35(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TemplateName623 = [1] of {int};
	chan child_TemplateName622 = [1] of {int};
	chan child_TemplateName621 = [1] of {int};
	chan child_initSettings2210 = [1] of {int};
	Mutexdef c_db_values_mu;
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run mutexMonitor(c_db_values_mu);
	run initSettings221(c_db_values_mu,c_once_m,child_initSettings2210);
	child_initSettings2210?0;
	run TemplateName62(c_db_values_mu,c_once_m,child_TemplateName621);
	child_TemplateName621?0;
	run TemplateName62(c_db_values_mu,c_once_m,child_TemplateName622);
	child_TemplateName622?0;
	run TemplateName62(c_db_values_mu,c_once_m,child_TemplateName623);
	child_TemplateName623?0;
	stop_process: skip;
	child!0
}
proctype initSettings221(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_LocalesPath3331 = [1] of {int};
	chan child_SettingsFile1710 = [1] of {int};
	run SettingsFile171(c_db_values_mu,c_once_m,child_SettingsFile1710);
	child_SettingsFile1710?0;
	run LocalesPath333(c_db_values_mu,c_once_m,child_LocalesPath3331);
	child_LocalesPath3331?0;
	stop_process: skip;
	child!0
}
proctype SettingsFile171(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ConfigPath1530 = [1] of {int};
	run ConfigPath153(c_db_values_mu,c_once_m,child_ConfigPath1530);
	child_ConfigPath1530?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ConfigPath153(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_StoragePath2722 = [1] of {int};
	chan child_StoragePath2721 = [1] of {int};
	chan child_StoragePath2720 = [1] of {int};
	

	if
	:: true -> 
		run StoragePath272(c_db_values_mu,c_once_m,child_StoragePath2720);
		child_StoragePath2720?0;
		

		if
		:: true -> 
			run StoragePath272(c_db_values_mu,c_once_m,child_StoragePath2721);
			child_StoragePath2721?0;
			goto stop_process
		:: true;
		fi;
		run StoragePath272(c_db_values_mu,c_once_m,child_StoragePath2722);
		child_StoragePath2722?0;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype StoragePath272(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ReadOnly3864 = [1] of {int};
	chan child_ReadOnly3863 = [1] of {int};
	chan child_ReadOnly3862 = [1] of {int};
	chan child_ReadOnly3861 = [1] of {int};
	chan child_OriginalsPath2000 = [1] of {int};
	

	if
	:: true -> 
		run OriginalsPath200(c_db_values_mu,c_once_m,child_OriginalsPath2000);
		child_OriginalsPath2000?0;
		run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly3861);
		child_ReadOnly3861?0;
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly3862);
			child_ReadOnly3862?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly3863);
			child_ReadOnly3863?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly3864);
		child_ReadOnly3864?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype OriginalsPath200(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ReadOnly386(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype LocalesPath333(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AssetsPath3231 = [1] of {int};
	run AssetsPath323(c_db_values_mu,c_once_m,child_AssetsPath3231);
	child_AssetsPath3231?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AssetsPath323(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype TemplateName62(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TemplateExists572 = [1] of {int};
	chan child_Settings2391 = [1] of {int};
	run Settings239(c_db_values_mu,c_once_m,child_Settings2391);
	child_Settings2391?0;
	

	if
	:: true -> 
		run TemplateExists57(c_db_values_mu,c_once_m,child_TemplateExists572);
		child_TemplateExists572?0;
		

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
proctype Settings239(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DisablePlaces272 = [1] of {int};
	chan child_initSettings2211 = [1] of {int};
	

	if
	:: true -> 
		run initSettings221(c_db_values_mu,c_once_m,child_initSettings2211);
		child_initSettings2211?0
	:: true;
	fi;
	run DisablePlaces27(c_db_values_mu,c_once_m,child_DisablePlaces272);
	child_DisablePlaces272?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DisablePlaces27(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype TemplateExists57(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TemplatesPath522 = [1] of {int};
	run TemplatesPath52(c_db_values_mu,c_once_m,child_TemplatesPath522);
	child_TemplatesPath522?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype TemplatesPath52(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AssetsPath3232 = [1] of {int};
	run AssetsPath323(c_db_values_mu,c_once_m,child_AssetsPath3232);
	child_AssetsPath3232?0;
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

