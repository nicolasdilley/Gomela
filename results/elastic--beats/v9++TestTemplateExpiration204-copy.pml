// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//x-pack/filebeat/input/netflow/decoder/v9/session_test.go#L204
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTemplateExpiration2040 = [1] of {int};
	run TestTemplateExpiration204(child_TestTemplateExpiration2040);
	run receiver(child_TestTemplateExpiration2040)
stop_process:skip
}

proctype TestTemplateExpiration204(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetTemplate649 = [1] of {int};
	chan child_ExpireTemplates778 = [1] of {int};
	chan child_GetTemplate647 = [1] of {int};
	chan child_ExpireTemplates776 = [1] of {int};
	chan child_GetTemplate645 = [1] of {int};
	chan child_ExpireTemplates774 = [1] of {int};
	chan child_AddTemplate563 = [1] of {int};
	chan child_AddTemplate562 = [1] of {int};
	chan child_GetTemplate641 = [1] of {int};
	chan child_GetTemplate640 = [1] of {int};
	Mutexdef s_logger_mu;
	Mutexdef s_mutex;
	run mutexMonitor(s_mutex);
	run mutexMonitor(s_logger_mu);
	run GetTemplate64(s_logger_mu,s_mutex,child_GetTemplate640);
	child_GetTemplate640?0;
	run GetTemplate64(s_logger_mu,s_mutex,child_GetTemplate641);
	child_GetTemplate641?0;
	run AddTemplate56(s_logger_mu,s_mutex,child_AddTemplate562);
	child_AddTemplate562?0;
	run AddTemplate56(s_logger_mu,s_mutex,child_AddTemplate563);
	child_AddTemplate563?0;
	run ExpireTemplates77(s_logger_mu,s_mutex,child_ExpireTemplates774);
	child_ExpireTemplates774?0;
	run GetTemplate64(s_logger_mu,s_mutex,child_GetTemplate645);
	child_GetTemplate645?0;
	run ExpireTemplates77(s_logger_mu,s_mutex,child_ExpireTemplates776);
	child_ExpireTemplates776?0;
	run GetTemplate64(s_logger_mu,s_mutex,child_GetTemplate647);
	child_GetTemplate647?0;
	run ExpireTemplates77(s_logger_mu,s_mutex,child_ExpireTemplates778);
	child_ExpireTemplates778?0;
	run GetTemplate64(s_logger_mu,s_mutex,child_GetTemplate649);
	child_GetTemplate649?0;
	stop_process: skip;
	child!0
}
proctype GetTemplate64(Mutexdef s_logger_mu;Mutexdef s_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mutex.RLock!false;
	goto defer1;
		defer1: skip;
	s_mutex.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype AddTemplate56(Mutexdef s_logger_mu;Mutexdef s_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mutex.Lock!false;
		defer1: skip;
	s_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype ExpireTemplates77(Mutexdef s_logger_mu;Mutexdef s_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_toDelete = -2; // opt var_toDelete
	int var_s_Templates = -2; // opt var_s_Templates
	s_mutex.RLock!false;
	s_mutex.RUnlock!false;
	

	if
	:: true -> 
		s_mutex.Lock!false;
		s_mutex.Unlock!false
	:: true;
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

proctype receiver(chan c) {
c?0
}

