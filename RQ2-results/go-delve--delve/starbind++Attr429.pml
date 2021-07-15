
// https://github.com/go-delve/delve/blob/master/pkg/terminal/starbind/conv.go#L429
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Attr4290 = [1] of {int};
	run Attr429(child_Attr4290)
stop_process:skip
}

proctype Attr429(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Attr3030 = [1] of {int};
	Mutexdef x_env_contextMu;
	chan child_Attr4291 = [1] of {int};
	Mutexdef v2_env_contextMu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run mutexMonitor(x_env_contextMu);
		run Attr303(x_env_contextMu,child_Attr3030);
		child_Attr3030?0;
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			run mutexMonitor(v2_env_contextMu);
			run Attr429(v2_env_contextMu,child_Attr4291);
			child_Attr4291?0;
			goto stop_process
		:: true;
		fi
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Attr303(Mutexdef v_env_contextMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_variableValueToStarlarkValue2051 = [1] of {int};
	chan child_autoLoad2550 = [1] of {int};
	chan child_variableValueToStarlarkValue2053 = [1] of {int};
	chan child_autoLoad2552 = [1] of {int};
	int v_v_Children=3;
	

	if
	:: v_v_Children-1 != -3 -> 
				for(i : 0.. v_v_Children-1) {
			for10: skip;
			

			if
			:: true -> 
				run autoLoad255(v_env_contextMu,child_autoLoad2550);
				child_autoLoad2550?0;
				run variableValueToStarlarkValue205(v_env_contextMu,child_variableValueToStarlarkValue2051);
				child_variableValueToStarlarkValue2051?0;
				goto stop_process
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			

			if
			:: true -> 
				run autoLoad255(v_env_contextMu,child_autoLoad2552);
				child_autoLoad2552?0;
				run variableValueToStarlarkValue205(v_env_contextMu,child_variableValueToStarlarkValue2053);
				child_variableValueToStarlarkValue2053?0;
				goto stop_process
			:: true;
			fi;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype autoLoad255(Mutexdef env_contextMu;chan child) {
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
proctype variableValueToStarlarkValue205(Mutexdef env_contextMu;chan child) {
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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
	:: true -> 
		goto stop_process
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


