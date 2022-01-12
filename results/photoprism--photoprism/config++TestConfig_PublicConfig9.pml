// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/client_test.go#L9
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_PublicConfig90 = [1] of {int};
	run TestConfig_PublicConfig9(child_TestConfig_PublicConfig90);
	run receiver(child_TestConfig_PublicConfig90)
stop_process:skip
}

proctype TestConfig_PublicConfig9(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PublicConfig1561 = [1] of {int};
	Mutexdef c2_db_values_mu;
	Mutexdef c2_once_m;
	chan child_PublicConfig1560 = [1] of {int};
	Mutexdef config_db_values_mu;
	Mutexdef config_once_m;
	run mutexMonitor(config_once_m);
	run mutexMonitor(config_db_values_mu);
	run PublicConfig156(config_db_values_mu,config_once_m,child_PublicConfig1560);
	child_PublicConfig1560?0;
	run mutexMonitor(c2_once_m);
	run mutexMonitor(c2_db_values_mu);
	run PublicConfig156(c2_db_values_mu,c2_once_m,child_PublicConfig1561);
	child_PublicConfig1561?0;
	stop_process: skip;
	child!0
}
proctype PublicConfig156(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Settings2392 = [1] of {int};
	chan child_UserConfig2871 = [1] of {int};
	chan child_Public3650 = [1] of {int};
	run Public365(c_db_values_mu,c_once_m,child_Public3650);
	child_Public3650?0;
	

	if
	:: true -> 
		run UserConfig287(c_db_values_mu,c_once_m,child_UserConfig2871);
		child_UserConfig2871?0;
		goto stop_process
	:: true;
	fi;
	run Settings239(c_db_values_mu,c_once_m,child_Settings2392);
	child_Settings2392?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Public365(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Demo3550 = [1] of {int};
	run Demo355(c_db_values_mu,c_once_m,child_Demo3550);
	child_Demo3550?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Demo355(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype UserConfig287(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Settings239(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DisablePlaces273 = [1] of {int};
	chan child_initSettings2212 = [1] of {int};
	

	if
	:: true -> 
		run initSettings221(c_db_values_mu,c_once_m,child_initSettings2212);
		child_initSettings2212?0
	:: true;
	fi;
	run DisablePlaces27(c_db_values_mu,c_once_m,child_DisablePlaces273);
	child_DisablePlaces273?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype initSettings221(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_LocalesPath3333 = [1] of {int};
	chan child_SettingsFile1712 = [1] of {int};
	run SettingsFile171(c_db_values_mu,c_once_m,child_SettingsFile1712);
	child_SettingsFile1712?0;
	run LocalesPath333(c_db_values_mu,c_once_m,child_LocalesPath3333);
	child_LocalesPath3333?0;
	stop_process: skip;
	child!0
}
proctype SettingsFile171(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ConfigPath1532 = [1] of {int};
	run ConfigPath153(c_db_values_mu,c_once_m,child_ConfigPath1532);
	child_ConfigPath1532?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ConfigPath153(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_StoragePath2724 = [1] of {int};
	chan child_StoragePath2723 = [1] of {int};
	chan child_StoragePath2722 = [1] of {int};
	

	if
	:: true -> 
		run StoragePath272(c_db_values_mu,c_once_m,child_StoragePath2722);
		child_StoragePath2722?0;
		

		if
		:: true -> 
			run StoragePath272(c_db_values_mu,c_once_m,child_StoragePath2723);
			child_StoragePath2723?0;
			goto stop_process
		:: true;
		fi;
		run StoragePath272(c_db_values_mu,c_once_m,child_StoragePath2724);
		child_StoragePath2724?0;
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
	chan child_ReadOnly3866 = [1] of {int};
	chan child_ReadOnly3865 = [1] of {int};
	chan child_ReadOnly3864 = [1] of {int};
	chan child_ReadOnly3863 = [1] of {int};
	chan child_OriginalsPath2002 = [1] of {int};
	

	if
	:: true -> 
		run OriginalsPath200(c_db_values_mu,c_once_m,child_OriginalsPath2002);
		child_OriginalsPath2002?0;
		run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly3863);
		child_ReadOnly3863?0;
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly3864);
			child_ReadOnly3864?0;
			

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
			run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly3865);
			child_ReadOnly3865?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly3866);
		child_ReadOnly3866?0;
		

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
	chan child_AssetsPath3233 = [1] of {int};
	run AssetsPath323(c_db_values_mu,c_once_m,child_AssetsPath3233);
	child_AssetsPath3233?0;
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
proctype DisablePlaces27(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
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

