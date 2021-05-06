
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubeapiserver/options/admission_test.go#L24
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestValidate240 = [1] of {int};
	run TestValidate24(child_TestValidate240)
stop_process:skip
}

proctype TestValidate24(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Validate833 = [1] of {int};
	chan child_Validate832 = [1] of {int};
	chan child_Validate831 = [1] of {int};
	chan child_Validate830 = [1] of {int};
	Mutexdef options_GenericAdmission_Plugins_lock;
	run mutexMonitor(options_GenericAdmission_Plugins_lock);
	run Validate83(options_GenericAdmission_Plugins_lock,child_Validate830);
	child_Validate830?0;
	run Validate83(options_GenericAdmission_Plugins_lock,child_Validate831);
	child_Validate831?0;
	run Validate83(options_GenericAdmission_Plugins_lock,child_Validate832);
	child_Validate832?0;
	run Validate83(options_GenericAdmission_Plugins_lock,child_Validate833);
	child_Validate833?0;
	stop_process: skip;
	child!0
}
proctype Validate83(Mutexdef a_GenericAdmission_Plugins_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Validate830 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Validate83(a_GenericAdmission_Plugins_lock,child_Validate830);
	child_Validate830?0;
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

