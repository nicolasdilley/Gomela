
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubeapiserver/options/admission.go#L52
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewAdmissionOptions520 = [1] of {int};
	run NewAdmissionOptions52(child_NewAdmissionOptions520)
stop_process:skip
}

proctype NewAdmissionOptions52(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RegisterAllAdmissionPlugins1070 = [1] of {int};
	Mutexdef options_Plugins_lock;
	run mutexMonitor(options_Plugins_lock);
	run RegisterAllAdmissionPlugins107(options_Plugins_lock,child_RegisterAllAdmissionPlugins1070);
	child_RegisterAllAdmissionPlugins1070?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype RegisterAllAdmissionPlugins107(Mutexdef plugins_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Register3427 = [1] of {int};
	chan child_Register3926 = [1] of {int};
	chan child_Register3825 = [1] of {int};
	chan child_Register3824 = [1] of {int};
	chan child_Register3823 = [1] of {int};
	chan child_Register4422 = [1] of {int};
	chan child_Register3321 = [1] of {int};
	chan child_Register4620 = [1] of {int};
	chan child_Register5119 = [1] of {int};
	chan child_Register5118 = [1] of {int};
	chan child_Register4617 = [1] of {int};
	chan child_Register4916 = [1] of {int};
	chan child_Register4615 = [1] of {int};
	chan child_Register3514 = [1] of {int};
	chan child_Register5213 = [1] of {int};
	chan child_Register3812 = [1] of {int};
	chan child_Register3911 = [1] of {int};
	chan child_Register5110 = [1] of {int};
	chan child_Register709 = [1] of {int};
	chan child_Register398 = [1] of {int};
	chan child_Register357 = [1] of {int};
	chan child_Register366 = [1] of {int};
	chan child_Register335 = [1] of {int};
	chan child_Register364 = [1] of {int};
	chan child_Register423 = [1] of {int};
	chan child_Register342 = [1] of {int};
	chan child_Register451 = [1] of {int};
	chan child_Register310 = [1] of {int};
	run Register31(plugins_lock,child_Register310);
	child_Register310?0;
	run Register45(plugins_lock,child_Register451);
	child_Register451?0;
	run Register34(plugins_lock,child_Register342);
	child_Register342?0;
	run Register42(plugins_lock,child_Register423);
	child_Register423?0;
	run Register36(plugins_lock,child_Register364);
	child_Register364?0;
	run Register33(plugins_lock,child_Register335);
	child_Register335?0;
	run Register36(plugins_lock,child_Register366);
	child_Register366?0;
	run Register35(plugins_lock,child_Register357);
	child_Register357?0;
	run Register39(plugins_lock,child_Register398);
	child_Register398?0;
	run Register70(plugins_lock,child_Register709);
	child_Register709?0;
	run Register51(plugins_lock,child_Register5110);
	child_Register5110?0;
	run Register39(plugins_lock,child_Register3911);
	child_Register3911?0;
	run Register38(plugins_lock,child_Register3812);
	child_Register3812?0;
	run Register52(plugins_lock,child_Register5213);
	child_Register5213?0;
	run Register35(plugins_lock,child_Register3514);
	child_Register3514?0;
	run Register46(plugins_lock,child_Register4615);
	child_Register4615?0;
	run Register49(plugins_lock,child_Register4916);
	child_Register4916?0;
	run Register46(plugins_lock,child_Register4617);
	child_Register4617?0;
	run Register51(plugins_lock,child_Register5118);
	child_Register5118?0;
	run Register51(plugins_lock,child_Register5119);
	child_Register5119?0;
	run Register46(plugins_lock,child_Register4620);
	child_Register4620?0;
	run Register33(plugins_lock,child_Register3321);
	child_Register3321?0;
	run Register44(plugins_lock,child_Register4422);
	child_Register4422?0;
	run Register38(plugins_lock,child_Register3823);
	child_Register3823?0;
	run Register38(plugins_lock,child_Register3824);
	child_Register3824?0;
	run Register38(plugins_lock,child_Register3825);
	child_Register3825?0;
	run Register39(plugins_lock,child_Register3926);
	child_Register3926?0;
	run Register34(plugins_lock,child_Register3427);
	child_Register3427?0;
	stop_process: skip;
	child!0
}
proctype Register31(Mutexdef plugins_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

