// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-gitea/gitea/blob/ed393779004335a0afcca0dfac48937db41fabd6/modules/log/writer_test.go#L30
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBaseLogger300 = [1] of {int};
	run TestBaseLogger30(child_TestBaseLogger300);
	run receiver(child_TestBaseLogger300)
stop_process:skip
}

proctype TestBaseLogger30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close2597 = [1] of {int};
	chan child_LogEvent2236 = [1] of {int};
	chan child_LogEvent2235 = [1] of {int};
	chan child_LogEvent2234 = [1] of {int};
	chan child_LogEvent2233 = [1] of {int};
	chan child_LogEvent2232 = [1] of {int};
	chan child_LogEvent2231 = [1] of {int};
	chan child_GetLevel660 = [1] of {int};
	Mutexdef b_mu;
	run mutexMonitor(b_mu);
	run GetLevel66(b_mu,child_GetLevel660);
	child_GetLevel660?0;
	run LogEvent223(b_mu,child_LogEvent2231);
	child_LogEvent2231?0;
	run LogEvent223(b_mu,child_LogEvent2232);
	child_LogEvent2232?0;
	run LogEvent223(b_mu,child_LogEvent2233);
	child_LogEvent2233?0;
	run LogEvent223(b_mu,child_LogEvent2234);
	child_LogEvent2234?0;
	run LogEvent223(b_mu,child_LogEvent2235);
	child_LogEvent2235?0;
	run LogEvent223(b_mu,child_LogEvent2236);
	child_LogEvent2236?0;
	run Close259(b_mu,child_Close2597);
	child_Close2597?0;
	stop_process: skip;
	child!0
}
proctype GetLevel66(Mutexdef logger_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype LogEvent223(Mutexdef logger_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_createMsg912 = [1] of {int};
	chan child_Match2401 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	logger_mu.Lock!false;
	run Match240(logger_mu,child_Match2401);
	child_Match2401?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run createMsg91(logger_mu,child_createMsg912);
	child_createMsg912?0;
	goto defer1;
		defer1: skip;
	logger_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Match240(Mutexdef logger_mu;chan child) {
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
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype createMsg91(Mutexdef logger_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_lineslines = -2; // opt var_lineslines
	stop_process: skip;
	child!0
}
proctype Close259(Mutexdef logger_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	logger_mu.Lock!false;
		defer1: skip;
	logger_mu.Unlock!false;
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

