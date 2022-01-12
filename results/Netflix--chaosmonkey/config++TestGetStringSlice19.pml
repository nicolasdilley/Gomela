// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/Netflix/chaosmonkey/blob//config/config_test.go#L19
#define not_found_2524  -2
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetStringSlice190 = [1] of {int};
	run TestGetStringSlice19(child_TestGetStringSlice190);
	run receiver(child_TestGetStringSlice190)
stop_process:skip
}

proctype TestGetStringSlice19(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getStringSlice3163 = [1] of {int};
	chan child_getStringSlice3164 = [1] of {int};
	chan child_Set1822 = [1] of {int};
	chan child_Set1821 = [1] of {int};
	chan child_Set1820 = [1] of {int};
	Mutexdef cfg_v_envKeyReplacer_once_m;
	run mutexMonitor(cfg_v_envKeyReplacer_once_m);
	run Set182(cfg_v_envKeyReplacer_once_m,child_Set1820);
	child_Set1820?0;
	run Set182(cfg_v_envKeyReplacer_once_m,child_Set1821);
	child_Set1821?0;
	run Set182(cfg_v_envKeyReplacer_once_m,child_Set1822);
	child_Set1822?0;
	

	if
	:: not_found_2524-1 != -3 -> 
				for(i : 0.. not_found_2524-1) {
			for10: skip;
			run getStringSlice316(cfg_v_envKeyReplacer_once_m,child_getStringSlice3163);
			child_getStringSlice3163?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run getStringSlice316(cfg_v_envKeyReplacer_once_m,child_getStringSlice3164);
			child_getStringSlice3164?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype Set182(Mutexdef m_v_envKeyReplacer_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype getStringSlice316(Mutexdef m_v_envKeyReplacer_once_m;chan child) {
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
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
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

