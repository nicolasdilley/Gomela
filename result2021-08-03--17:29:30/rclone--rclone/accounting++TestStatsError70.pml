// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/rclone/rclone/blob/a223b78872dc7a8713ca2aa4596ae3e30c173cdd/fs/accounting/stats_test.go#L70
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
	chan child_RetryAfter55347 = [1] of {int};
	chan child_HadRetryError45846 = [1] of {int};
	chan child_HadFatalError44445 = [1] of {int};
	chan child_GetErrors41644 = [1] of {int};
	chan child_Error52643 = [1] of {int};
	chan child_Errored51942 = [1] of {int};
	chan child_GetLastError42341 = [1] of {int};
	chan child_RetryAfter55340 = [1] of {int};
	chan child_HadRetryError45839 = [1] of {int};
	chan child_HadFatalError44438 = [1] of {int};
	chan child_GetErrors41637 = [1] of {int};
	chan child_ResetErrors50836 = [1] of {int};
	chan child_RetryAfter55335 = [1] of {int};
	chan child_HadRetryError45834 = [1] of {int};
	chan child_HadFatalError44433 = [1] of {int};
	chan child_GetErrors41632 = [1] of {int};
	chan child_Error52631 = [1] of {int};
	chan child_RetryAfter55330 = [1] of {int};
	chan child_HadRetryError45829 = [1] of {int};
	chan child_HadFatalError44428 = [1] of {int};
	chan child_GetErrors41627 = [1] of {int};
	chan child_Error52626 = [1] of {int};
	chan child_GetLastError42325 = [1] of {int};
	chan child_RetryAfter55324 = [1] of {int};
	chan child_HadRetryError45823 = [1] of {int};
	chan child_HadFatalError44422 = [1] of {int};
	chan child_GetErrors41621 = [1] of {int};
	chan child_Error52620 = [1] of {int};
	chan child_Errored51919 = [1] of {int};
	chan child_GetLastError42318 = [1] of {int};
	chan child_RetryAfter55317 = [1] of {int};
	chan child_HadRetryError45816 = [1] of {int};
	chan child_HadFatalError44415 = [1] of {int};
	chan child_GetErrors41614 = [1] of {int};
	chan child_Error52613 = [1] of {int};
	chan child_Errored51912 = [1] of {int};
	chan child_GetLastError42311 = [1] of {int};
	chan child_RetryAfter55310 = [1] of {int};
	chan child_HadRetryError4589 = [1] of {int};
	chan child_HadFatalError4448 = [1] of {int};
	chan child_GetErrors4167 = [1] of {int};
	chan child_Error5266 = [1] of {int};
	chan child_Errored5195 = [1] of {int};
	chan child_GetLastError4234 = [1] of {int};
	chan child_RetryAfter5533 = [1] of {int};
	chan child_HadRetryError4582 = [1] of {int};
	chan child_HadFatalError4441 = [1] of {int};
	chan child_GetErrors4160 = [1] of {int};
	Mutexdef s_inProgress_mu;
	Mutexdef s_transferring_mu;
	Mutexdef s_checking_mu;
	Mutexdef s_mu;
	run mutexMonitor(s_mu);
	run mutexMonitor(s_checking_mu);
	run mutexMonitor(s_transferring_mu);
	run mutexMonitor(s_inProgress_mu);
	run GetErrors416(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetErrors4160);
	child_GetErrors4160?0;
	run HadFatalError444(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadFatalError4441);
	child_HadFatalError4441?0;
	run HadRetryError458(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadRetryError4582);
	child_HadRetryError4582?0;
	run RetryAfter553(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_RetryAfter5533);
	child_RetryAfter5533?0;
	run GetLastError423(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetLastError4234);
	child_GetLastError4234?0;
	run Errored519(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_Errored5195);
	child_Errored5195?0;
	run Error526(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_Error5266);
	child_Error5266?0;
	run GetErrors416(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetErrors4167);
	child_GetErrors4167?0;
	run HadFatalError444(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadFatalError4448);
	child_HadFatalError4448?0;
	run HadRetryError458(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadRetryError4589);
	child_HadRetryError4589?0;
	run RetryAfter553(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_RetryAfter55310);
	child_RetryAfter55310?0;
	run GetLastError423(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetLastError42311);
	child_GetLastError42311?0;
	run Errored519(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_Errored51912);
	child_Errored51912?0;
	run Error526(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_Error52613);
	child_Error52613?0;
	run GetErrors416(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetErrors41614);
	child_GetErrors41614?0;
	run HadFatalError444(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadFatalError44415);
	child_HadFatalError44415?0;
	run HadRetryError458(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadRetryError45816);
	child_HadRetryError45816?0;
	run RetryAfter553(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_RetryAfter55317);
	child_RetryAfter55317?0;
	run GetLastError423(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetLastError42318);
	child_GetLastError42318?0;
	run Errored519(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_Errored51919);
	child_Errored51919?0;
	run Error526(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_Error52620);
	child_Error52620?0;
	run GetErrors416(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetErrors41621);
	child_GetErrors41621?0;
	run HadFatalError444(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadFatalError44422);
	child_HadFatalError44422?0;
	run HadRetryError458(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadRetryError45823);
	child_HadRetryError45823?0;
	run RetryAfter553(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_RetryAfter55324);
	child_RetryAfter55324?0;
	run GetLastError423(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetLastError42325);
	child_GetLastError42325?0;
	run Error526(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_Error52626);
	child_Error52626?0;
	run GetErrors416(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetErrors41627);
	child_GetErrors41627?0;
	run HadFatalError444(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadFatalError44428);
	child_HadFatalError44428?0;
	run HadRetryError458(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadRetryError45829);
	child_HadRetryError45829?0;
	run RetryAfter553(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_RetryAfter55330);
	child_RetryAfter55330?0;
	run Error526(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_Error52631);
	child_Error52631?0;
	run GetErrors416(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetErrors41632);
	child_GetErrors41632?0;
	run HadFatalError444(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadFatalError44433);
	child_HadFatalError44433?0;
	run HadRetryError458(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadRetryError45834);
	child_HadRetryError45834?0;
	run RetryAfter553(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_RetryAfter55335);
	child_RetryAfter55335?0;
	run ResetErrors508(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_ResetErrors50836);
	child_ResetErrors50836?0;
	run GetErrors416(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetErrors41637);
	child_GetErrors41637?0;
	run HadFatalError444(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadFatalError44438);
	child_HadFatalError44438?0;
	run HadRetryError458(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadRetryError45839);
	child_HadRetryError45839?0;
	run RetryAfter553(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_RetryAfter55340);
	child_RetryAfter55340?0;
	run GetLastError423(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetLastError42341);
	child_GetLastError42341?0;
	run Errored519(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_Errored51942);
	child_Errored51942?0;
	run Error526(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_Error52643);
	child_Error52643?0;
	run GetErrors416(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_GetErrors41644);
	child_GetErrors41644?0;
	run HadFatalError444(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadFatalError44445);
	child_HadFatalError44445?0;
	run HadRetryError458(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_HadRetryError45846);
	child_HadRetryError45846?0;
	run RetryAfter553(s_checking_mu,s_inProgress_mu,s_mu,s_transferring_mu,child_RetryAfter55347);
	child_RetryAfter55347?0;
	stop_process: skip;
	child!0
}
proctype GetErrors416(Mutexdef s_checking_mu;Mutexdef s_inProgress_mu;Mutexdef s_mu;Mutexdef s_transferring_mu;chan child) {
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
proctype HadFatalError444(Mutexdef s_checking_mu;Mutexdef s_inProgress_mu;Mutexdef s_mu;Mutexdef s_transferring_mu;chan child) {
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
proctype HadRetryError458(Mutexdef s_checking_mu;Mutexdef s_inProgress_mu;Mutexdef s_mu;Mutexdef s_transferring_mu;chan child) {
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
proctype RetryAfter553(Mutexdef s_checking_mu;Mutexdef s_inProgress_mu;Mutexdef s_mu;Mutexdef s_transferring_mu;chan child) {
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
proctype GetLastError423(Mutexdef s_checking_mu;Mutexdef s_inProgress_mu;Mutexdef s_mu;Mutexdef s_transferring_mu;chan child) {
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
proctype Errored519(Mutexdef s_checking_mu;Mutexdef s_inProgress_mu;Mutexdef s_mu;Mutexdef s_transferring_mu;chan child) {
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
proctype Error526(Mutexdef s_checking_mu;Mutexdef s_inProgress_mu;Mutexdef s_mu;Mutexdef s_transferring_mu;chan child) {
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
proctype ResetErrors508(Mutexdef s_checking_mu;Mutexdef s_inProgress_mu;Mutexdef s_mu;Mutexdef s_transferring_mu;chan child) {
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

