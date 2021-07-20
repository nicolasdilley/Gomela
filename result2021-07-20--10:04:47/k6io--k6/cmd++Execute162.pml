// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/k6io/k6/blob/af1e032ebf949cde092d4a2eddb78528ea0a5864/cmd/root.go#L162
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Execute1620 = [1] of {int};
	run Execute162(child_Execute1620);
	run receiver(child_Execute1620)
stop_process:skip
}

proctype Execute162(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getRunCmd756 = [1] of {int};
	chan child_getInspectCmd375 = [1] of {int};
	chan child_getCloudCmd624 = [1] of {int};
	chan child_getArchiveCmd363 = [1] of {int};
	chan child_getLoginInfluxDBCommand402 = [1] of {int};
	chan child_getLoginCloudCommand411 = [1] of {int};
	chan child_newRootCommand900 = [1] of {int};
	Mutexdef logger_mu_lock;
	run mutexMonitor(logger_mu_lock);
	run newRootCommand90(logger_mu_lock,child_newRootCommand900);
	child_newRootCommand900?0;
	run getLoginCloudCommand41(logger_mu_lock,child_getLoginCloudCommand411);
	child_getLoginCloudCommand411?0;
	run getLoginInfluxDBCommand40(logger_mu_lock,child_getLoginInfluxDBCommand402);
	child_getLoginInfluxDBCommand402?0;
	run getArchiveCmd36(logger_mu_lock,child_getArchiveCmd363);
	child_getArchiveCmd363?0;
	run getCloudCmd62(logger_mu_lock,child_getCloudCmd624);
	child_getCloudCmd624?0;
	run getInspectCmd37(logger_mu_lock,child_getInspectCmd375);
	child_getInspectCmd375?0;
	run getRunCmd75(logger_mu_lock,child_getRunCmd756);
	child_getRunCmd756?0;
	stop_process: skip;
	child!0
}
proctype newRootCommand90(Mutexdef logger_mu_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getLoginCloudCommand41(Mutexdef logger_mu_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getLoginInfluxDBCommand40(Mutexdef logger_mu_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getArchiveCmd36(Mutexdef logger_mu_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getCloudCmd62(Mutexdef logger_mu_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getInspectCmd37(Mutexdef logger_mu_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getRunCmd75(Mutexdef logger_mu_lock;chan child) {
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

