// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/ui/app_test.go#L29
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAppResetCmd290 = [1] of {int};
	run TestAppResetCmd29(child_TestAppResetCmd290);
	run receiver(child_TestAppResetCmd290)
stop_process:skip
}

proctype TestAppResetCmd29(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ResetCmd1621 = [1] of {int};
	chan child_Init520 = [1] of {int};
	Mutexdef a_mx;
	run mutexMonitor(a_mx);
	run Init52(a_mx,child_Init520);
	child_Init520?0;
	run ResetCmd162(a_mx,child_ResetCmd1621);
	child_ResetCmd1621?0;
	stop_process: skip;
	child!0
}
proctype Init52(Mutexdef a_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_bindKeys1380 = [1] of {int};
	run bindKeys138(a_mx,child_bindKeys1380);
	child_bindKeys1380?0;
	stop_process: skip;
	child!0
}
proctype bindKeys138(Mutexdef a_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype ResetCmd162(Mutexdef a_mx;chan child) {
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

proctype receiver(chan c) {
c?0
}

