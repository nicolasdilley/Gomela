
// https://github.com/mattermost/mattermost-server/blob/master/plugin/checker/internal/asthelpers/helpers.go#L14
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_GetPackage140 = [1] of {int};
	run GetPackage14(child_GetPackage140)
stop_process:skip
}

proctype GetPackage14(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cfg_Fset_last_mutex;
	Mutexdef cfg_Fset_mutex;
	Mutexdef cfg_gocmdRunner_once_m;
	run mutexMonitor(cfg_gocmdRunner_once_m);
	run mutexMonitor(cfg_Fset_mutex);
	run mutexMonitor(cfg_Fset_last_mutex);
	

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

