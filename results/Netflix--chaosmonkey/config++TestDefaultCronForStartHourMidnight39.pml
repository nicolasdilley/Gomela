// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/Netflix/chaosmonkey/blob//config/monkey_test.go#L39
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDefaultCronForStartHourMidnight390 = [1] of {int};
	run TestDefaultCronForStartHourMidnight39(child_TestDefaultCronForStartHourMidnight390);
	run receiver(child_TestDefaultCronForStartHourMidnight390)
stop_process:skip
}

proctype TestDefaultCronForStartHourMidnight39(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CronExpression4521 = [1] of {int};
	chan child_Set1820 = [1] of {int};
	Mutexdef monkey_v_envKeyReplacer_once_m;
	run mutexMonitor(monkey_v_envKeyReplacer_once_m);
	run Set182(monkey_v_envKeyReplacer_once_m,child_Set1820);
	child_Set1820?0;
	run CronExpression452(monkey_v_envKeyReplacer_once_m,child_CronExpression4521);
	child_CronExpression4521?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
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
proctype CronExpression452(Mutexdef m_v_envKeyReplacer_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_StartHour2641 = [1] of {int};
	

	if
	:: true -> 
		run StartHour264(m_v_envKeyReplacer_once_m,child_StartHour2641);
		child_StartHour2641?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	stop_process: skip;
	child!0
}
proctype StartHour264(Mutexdef m_v_envKeyReplacer_once_m;chan child) {
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

