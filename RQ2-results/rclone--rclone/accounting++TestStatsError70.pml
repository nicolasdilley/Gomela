
// https://github.com/rclone/rclone/blob/master/fs/accounting/stats_test.go#L70
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStatsError700 = [1] of {int};
	run TestStatsError70(child_TestStatsError700)
stop_process:skip
}

proctype TestStatsError70(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RetryAfter59947 = [1] of {int};
	chan child_HadRetryError50446 = [1] of {int};
	chan child_HadFatalError49045 = [1] of {int};
	chan child_GetErrors46244 = [1] of {int};
	chan child_Error57243 = [1] of {int};
	chan child_Errored56542 = [1] of {int};
	chan child_GetLastError46941 = [1] of {int};
	chan child_RetryAfter59940 = [1] of {int};
	chan child_HadRetryError50439 = [1] of {int};
	chan child_HadFatalError49038 = [1] of {int};
	chan child_GetErrors46237 = [1] of {int};
	chan child_ResetErrors55436 = [1] of {int};
	chan child_RetryAfter59935 = [1] of {int};
	chan child_HadRetryError50434 = [1] of {int};
	chan child_HadFatalError49033 = [1] of {int};
	chan child_GetErrors46232 = [1] of {int};
	chan child_Error57231 = [1] of {int};
	chan child_RetryAfter59930 = [1] of {int};
	chan child_HadRetryError50429 = [1] of {int};
	chan child_HadFatalError49028 = [1] of {int};
	chan child_GetErrors46227 = [1] of {int};
	chan child_Error57226 = [1] of {int};
	chan child_GetLastError46925 = [1] of {int};
	chan child_RetryAfter59924 = [1] of {int};
	chan child_HadRetryError50423 = [1] of {int};
	chan child_HadFatalError49022 = [1] of {int};
	chan child_GetErrors46221 = [1] of {int};
	chan child_Error57220 = [1] of {int};
	chan child_Errored56519 = [1] of {int};
	chan child_GetLastError46918 = [1] of {int};
	chan child_RetryAfter59917 = [1] of {int};
	chan child_HadRetryError50416 = [1] of {int};
	chan child_HadFatalError49015 = [1] of {int};
	chan child_GetErrors46214 = [1] of {int};
	chan child_Error57213 = [1] of {int};
	chan child_Errored56512 = [1] of {int};
	chan child_GetLastError46911 = [1] of {int};
	chan child_RetryAfter59910 = [1] of {int};
	chan child_HadRetryError5049 = [1] of {int};
	chan child_HadFatalError4908 = [1] of {int};
	chan child_GetErrors4627 = [1] of {int};
	chan child_Error5726 = [1] of {int};
	chan child_Errored5655 = [1] of {int};
	chan child_GetLastError4694 = [1] of {int};
	chan child_RetryAfter5993 = [1] of {int};
	chan child_HadRetryError5042 = [1] of {int};
	chan child_HadFatalError4901 = [1] of {int};
	chan child_GetErrors4620 = [1] of {int};
	Mutexdef s_inProgress_mu;
	Mutexdef s_transferring_mu;
	Mutexdef s_checking_mu;
	Mutexdef s_mu;
	run mutexMonitor(s_mu);
	run mutexMonitor(s_checking_mu);
	run mutexMonitor(s_transferring_mu);
	run mutexMonitor(s_inProgress_mu);
	run GetErrors462(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_GetErrors4620);
	child_GetErrors4620?0;
	run HadFatalError490(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_HadFatalError4901);
	child_HadFatalError4901?0;
	run HadRetryError504(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_HadRetryError5042);
	child_HadRetryError5042?0;
	run RetryAfter599(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_RetryAfter5993);
	child_RetryAfter5993?0;
	run GetLastError469(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_GetLastError4694);
	child_GetLastError4694?0;
	run Errored565(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_Errored5655);
	child_Errored5655?0;
	run Error572(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_Error5726);
	child_Error5726?0;
	run GetErrors462(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_GetErrors4627);
	child_GetErrors4627?0;
	run HadFatalError490(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_HadFatalError4908);
	child_HadFatalError4908?0;
	run HadRetryError504(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_HadRetryError5049);
	child_HadRetryError5049?0;
	run RetryAfter599(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_RetryAfter59910);
	child_RetryAfter59910?0;
	run GetLastError469(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_GetLastError46911);
	child_GetLastError46911?0;
	run Errored565(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_Errored56512);
	child_Errored56512?0;
	run Error572(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_Error57213);
	child_Error57213?0;
	run GetErrors462(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_GetErrors46214);
	child_GetErrors46214?0;
	run HadFatalError490(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_HadFatalError49015);
	child_HadFatalError49015?0;
	run HadRetryError504(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_HadRetryError50416);
	child_HadRetryError50416?0;
	run RetryAfter599(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_RetryAfter59917);
	child_RetryAfter59917?0;
	run GetLastError469(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_GetLastError46918);
	child_GetLastError46918?0;
	run Errored565(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_Errored56519);
	child_Errored56519?0;
	run Error572(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_Error57220);
	child_Error57220?0;
	run GetErrors462(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_GetErrors46221);
	child_GetErrors46221?0;
	run HadFatalError490(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_HadFatalError49022);
	child_HadFatalError49022?0;
	run HadRetryError504(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_HadRetryError50423);
	child_HadRetryError50423?0;
	run RetryAfter599(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_RetryAfter59924);
	child_RetryAfter59924?0;
	run GetLastError469(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_GetLastError46925);
	child_GetLastError46925?0;
	run Error572(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_Error57226);
	child_Error57226?0;
	run GetErrors462(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_GetErrors46227);
	child_GetErrors46227?0;
	run HadFatalError490(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_HadFatalError49028);
	child_HadFatalError49028?0;
	run HadRetryError504(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_HadRetryError50429);
	child_HadRetryError50429?0;
	run RetryAfter599(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_RetryAfter59930);
	child_RetryAfter59930?0;
	run Error572(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_Error57231);
	child_Error57231?0;
	run GetErrors462(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_GetErrors46232);
	child_GetErrors46232?0;
	run HadFatalError490(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_HadFatalError49033);
	child_HadFatalError49033?0;
	run HadRetryError504(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_HadRetryError50434);
	child_HadRetryError50434?0;
	run RetryAfter599(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_RetryAfter59935);
	child_RetryAfter59935?0;
	run ResetErrors554(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_ResetErrors55436);
	child_ResetErrors55436?0;
	run GetErrors462(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_GetErrors46237);
	child_GetErrors46237?0;
	run HadFatalError490(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_HadFatalError49038);
	child_HadFatalError49038?0;
	run HadRetryError504(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_HadRetryError50439);
	child_HadRetryError50439?0;
	run RetryAfter599(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_RetryAfter59940);
	child_RetryAfter59940?0;
	run GetLastError469(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_GetLastError46941);
	child_GetLastError46941?0;
	run Errored565(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_Errored56542);
	child_Errored56542?0;
	run Error572(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_Error57243);
	child_Error57243?0;
	run GetErrors462(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_GetErrors46244);
	child_GetErrors46244?0;
	run HadFatalError490(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_HadFatalError49045);
	child_HadFatalError49045?0;
	run HadRetryError504(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_HadRetryError50446);
	child_HadRetryError50446?0;
	run RetryAfter599(s_mu,s_checking_mu,s_transferring_mu,s_inProgress_mu,child_RetryAfter59947);
	child_RetryAfter59947?0;
	stop_process: skip;
	child!0
}
proctype GetErrors462(Mutexdef s_mu;Mutexdef s_checking_mu;Mutexdef s_transferring_mu;Mutexdef s_inProgress_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.RLock!false;
	goto stop_process;
	stop_process: skip;
		s_mu.RUnlock!false;
	child!0
}
proctype HadFatalError490(Mutexdef s_mu;Mutexdef s_checking_mu;Mutexdef s_transferring_mu;Mutexdef s_inProgress_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.RLock!false;
	goto stop_process;
	stop_process: skip;
		s_mu.RUnlock!false;
	child!0
}
proctype HadRetryError504(Mutexdef s_mu;Mutexdef s_checking_mu;Mutexdef s_transferring_mu;Mutexdef s_inProgress_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.RLock!false;
	goto stop_process;
	stop_process: skip;
		s_mu.RUnlock!false;
	child!0
}
proctype RetryAfter599(Mutexdef s_mu;Mutexdef s_checking_mu;Mutexdef s_transferring_mu;Mutexdef s_inProgress_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.Lock!false;
	goto stop_process;
	stop_process: skip;
		s_mu.Unlock!false;
	child!0
}
proctype GetLastError469(Mutexdef s_mu;Mutexdef s_checking_mu;Mutexdef s_transferring_mu;Mutexdef s_inProgress_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.RLock!false;
	goto stop_process;
	stop_process: skip;
		s_mu.RUnlock!false;
	child!0
}
proctype Errored565(Mutexdef s_mu;Mutexdef s_checking_mu;Mutexdef s_transferring_mu;Mutexdef s_inProgress_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.RLock!false;
	goto stop_process;
	stop_process: skip;
		s_mu.RUnlock!false;
	child!0
}
proctype Error572(Mutexdef s_mu;Mutexdef s_checking_mu;Mutexdef s_transferring_mu;Mutexdef s_inProgress_mu;chan child) {
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
	goto stop_process;
	stop_process: skip;
		s_mu.Unlock!false;
	child!0
}
proctype ResetErrors554(Mutexdef s_mu;Mutexdef s_checking_mu;Mutexdef s_transferring_mu;Mutexdef s_inProgress_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.Lock!false;
	stop_process: skip;
		s_mu.Unlock!false;
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

