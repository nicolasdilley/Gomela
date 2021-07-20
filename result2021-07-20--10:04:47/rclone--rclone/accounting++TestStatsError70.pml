// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/rclone/rclone/blob/6ef7178ee4465f2361b6e2cf483cef5bbfd9c95c/fs/accounting/stats_test.go#L70
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStatsError700 = [1] of {int};
	run TestStatsError70(child_TestStatsError700);
	run receiver(child_TestStatsError700)
stop_process:skip
}

proctype TestStatsError70(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RetryAfter60047 = [1] of {int};
	chan child_HadRetryError50546 = [1] of {int};
	chan child_HadFatalError49145 = [1] of {int};
	chan child_GetErrors46344 = [1] of {int};
	chan child_Error57343 = [1] of {int};
	chan child_Errored56642 = [1] of {int};
	chan child_GetLastError47041 = [1] of {int};
	chan child_RetryAfter60040 = [1] of {int};
	chan child_HadRetryError50539 = [1] of {int};
	chan child_HadFatalError49138 = [1] of {int};
	chan child_GetErrors46337 = [1] of {int};
	chan child_ResetErrors55536 = [1] of {int};
	chan child_RetryAfter60035 = [1] of {int};
	chan child_HadRetryError50534 = [1] of {int};
	chan child_HadFatalError49133 = [1] of {int};
	chan child_GetErrors46332 = [1] of {int};
	chan child_Error57331 = [1] of {int};
	chan child_RetryAfter60030 = [1] of {int};
	chan child_HadRetryError50529 = [1] of {int};
	chan child_HadFatalError49128 = [1] of {int};
	chan child_GetErrors46327 = [1] of {int};
	chan child_Error57326 = [1] of {int};
	chan child_GetLastError47025 = [1] of {int};
	chan child_RetryAfter60024 = [1] of {int};
	chan child_HadRetryError50523 = [1] of {int};
	chan child_HadFatalError49122 = [1] of {int};
	chan child_GetErrors46321 = [1] of {int};
	chan child_Error57320 = [1] of {int};
	chan child_Errored56619 = [1] of {int};
	chan child_GetLastError47018 = [1] of {int};
	chan child_RetryAfter60017 = [1] of {int};
	chan child_HadRetryError50516 = [1] of {int};
	chan child_HadFatalError49115 = [1] of {int};
	chan child_GetErrors46314 = [1] of {int};
	chan child_Error57313 = [1] of {int};
	chan child_Errored56612 = [1] of {int};
	chan child_GetLastError47011 = [1] of {int};
	chan child_RetryAfter60010 = [1] of {int};
	chan child_HadRetryError5059 = [1] of {int};
	chan child_HadFatalError4918 = [1] of {int};
	chan child_GetErrors4637 = [1] of {int};
	chan child_Error5736 = [1] of {int};
	chan child_Errored5665 = [1] of {int};
	chan child_GetLastError4704 = [1] of {int};
	chan child_RetryAfter6003 = [1] of {int};
	chan child_HadRetryError5052 = [1] of {int};
	chan child_HadFatalError4911 = [1] of {int};
	chan child_GetErrors4630 = [1] of {int};
	Mutexdef s_inProgress_mu;
	Mutexdef s_transferring_mu;
	Mutexdef s_checking_mu;
	Mutexdef s_mu;
	run mutexMonitor(s_mu);
	run mutexMonitor(s_checking_mu);
	run mutexMonitor(s_transferring_mu);
	run mutexMonitor(s_inProgress_mu);
	run GetErrors463(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetErrors4630);
	child_GetErrors4630?0;
	run HadFatalError491(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadFatalError4911);
	child_HadFatalError4911?0;
	run HadRetryError505(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadRetryError5052);
	child_HadRetryError5052?0;
	run RetryAfter600(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_RetryAfter6003);
	child_RetryAfter6003?0;
	run GetLastError470(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetLastError4704);
	child_GetLastError4704?0;
	run Errored566(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_Errored5665);
	child_Errored5665?0;
	run Error573(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_Error5736);
	child_Error5736?0;
	run GetErrors463(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetErrors4637);
	child_GetErrors4637?0;
	run HadFatalError491(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadFatalError4918);
	child_HadFatalError4918?0;
	run HadRetryError505(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadRetryError5059);
	child_HadRetryError5059?0;
	run RetryAfter600(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_RetryAfter60010);
	child_RetryAfter60010?0;
	run GetLastError470(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetLastError47011);
	child_GetLastError47011?0;
	run Errored566(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_Errored56612);
	child_Errored56612?0;
	run Error573(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_Error57313);
	child_Error57313?0;
	run GetErrors463(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetErrors46314);
	child_GetErrors46314?0;
	run HadFatalError491(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadFatalError49115);
	child_HadFatalError49115?0;
	run HadRetryError505(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadRetryError50516);
	child_HadRetryError50516?0;
	run RetryAfter600(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_RetryAfter60017);
	child_RetryAfter60017?0;
	run GetLastError470(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetLastError47018);
	child_GetLastError47018?0;
	run Errored566(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_Errored56619);
	child_Errored56619?0;
	run Error573(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_Error57320);
	child_Error57320?0;
	run GetErrors463(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetErrors46321);
	child_GetErrors46321?0;
	run HadFatalError491(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadFatalError49122);
	child_HadFatalError49122?0;
	run HadRetryError505(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadRetryError50523);
	child_HadRetryError50523?0;
	run RetryAfter600(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_RetryAfter60024);
	child_RetryAfter60024?0;
	run GetLastError470(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetLastError47025);
	child_GetLastError47025?0;
	run Error573(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_Error57326);
	child_Error57326?0;
	run GetErrors463(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetErrors46327);
	child_GetErrors46327?0;
	run HadFatalError491(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadFatalError49128);
	child_HadFatalError49128?0;
	run HadRetryError505(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadRetryError50529);
	child_HadRetryError50529?0;
	run RetryAfter600(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_RetryAfter60030);
	child_RetryAfter60030?0;
	run Error573(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_Error57331);
	child_Error57331?0;
	run GetErrors463(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetErrors46332);
	child_GetErrors46332?0;
	run HadFatalError491(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadFatalError49133);
	child_HadFatalError49133?0;
	run HadRetryError505(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadRetryError50534);
	child_HadRetryError50534?0;
	run RetryAfter600(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_RetryAfter60035);
	child_RetryAfter60035?0;
	run ResetErrors555(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_ResetErrors55536);
	child_ResetErrors55536?0;
	run GetErrors463(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetErrors46337);
	child_GetErrors46337?0;
	run HadFatalError491(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadFatalError49138);
	child_HadFatalError49138?0;
	run HadRetryError505(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadRetryError50539);
	child_HadRetryError50539?0;
	run RetryAfter600(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_RetryAfter60040);
	child_RetryAfter60040?0;
	run GetLastError470(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetLastError47041);
	child_GetLastError47041?0;
	run Errored566(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_Errored56642);
	child_Errored56642?0;
	run Error573(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_Error57343);
	child_Error57343?0;
	run GetErrors463(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetErrors46344);
	child_GetErrors46344?0;
	run HadFatalError491(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadFatalError49145);
	child_HadFatalError49145?0;
	run HadRetryError505(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadRetryError50546);
	child_HadRetryError50546?0;
	run RetryAfter600(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_RetryAfter60047);
	child_RetryAfter60047?0;
	stop_process: skip;
	child!0
}
proctype GetErrors463(Mutexdef s_checking_mu;Mutexdef s_inProgress_mu;Mutexdef s_mu;Mutexdef s_transferring_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.RLock!false;
	goto defer1;
		defer1: skip;
	s_mu.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype HadFatalError491(Mutexdef s_checking_mu;Mutexdef s_inProgress_mu;Mutexdef s_mu;Mutexdef s_transferring_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.RLock!false;
	goto defer1;
		defer1: skip;
	s_mu.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype HadRetryError505(Mutexdef s_checking_mu;Mutexdef s_inProgress_mu;Mutexdef s_mu;Mutexdef s_transferring_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.RLock!false;
	goto defer1;
		defer1: skip;
	s_mu.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype RetryAfter600(Mutexdef s_checking_mu;Mutexdef s_inProgress_mu;Mutexdef s_mu;Mutexdef s_transferring_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.Lock!false;
	goto defer1;
		defer1: skip;
	s_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype GetLastError470(Mutexdef s_checking_mu;Mutexdef s_inProgress_mu;Mutexdef s_mu;Mutexdef s_transferring_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.RLock!false;
	goto defer1;
		defer1: skip;
	s_mu.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype Errored566(Mutexdef s_checking_mu;Mutexdef s_inProgress_mu;Mutexdef s_mu;Mutexdef s_transferring_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.RLock!false;
	goto defer1;
		defer1: skip;
	s_mu.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype Error573(Mutexdef s_checking_mu;Mutexdef s_inProgress_mu;Mutexdef s_mu;Mutexdef s_transferring_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	s_mu.Lock!false;
	

	if
	:: true;
	:: true;
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	s_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype ResetErrors555(Mutexdef s_checking_mu;Mutexdef s_inProgress_mu;Mutexdef s_mu;Mutexdef s_transferring_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.Lock!false;
		defer1: skip;
	s_mu.Unlock!false;
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

