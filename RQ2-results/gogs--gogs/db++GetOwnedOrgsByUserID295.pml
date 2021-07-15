
// https://github.com/gogs/gogs/blob/master/internal/db/org.go#L295
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_GetOwnedOrgsByUserID2950 = [1] of {int};
	run GetOwnedOrgsByUserID295(child_GetOwnedOrgsByUserID2950)
stop_process:skip
}

proctype GetOwnedOrgsByUserID295(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getOwnedOrgsByUserID2880 = [1] of {int};
	Mutexdef sess_statement_Engine_cacherLock;
	Mutexdef sess_statement_Engine_mutex;
	Mutexdef sess_statement_Engine_db_reflectCacheMutex;
	Mutexdef sess_tx_db_reflectCacheMutex;
	Mutexdef sess_engine_cacherLock;
	Mutexdef sess_engine_mutex;
	Mutexdef sess_engine_db_reflectCacheMutex;
	Mutexdef sess_db_reflectCacheMutex;
	run mutexMonitor(sess_db_reflectCacheMutex);
	run mutexMonitor(sess_engine_db_reflectCacheMutex);
	run mutexMonitor(sess_engine_mutex);
	run mutexMonitor(sess_engine_cacherLock);
	run mutexMonitor(sess_tx_db_reflectCacheMutex);
	run mutexMonitor(sess_statement_Engine_db_reflectCacheMutex);
	run mutexMonitor(sess_statement_Engine_mutex);
	run mutexMonitor(sess_statement_Engine_cacherLock);
	run getOwnedOrgsByUserID288(sess_db_reflectCacheMutex,sess_engine_db_reflectCacheMutex,sess_engine_mutex,sess_engine_cacherLock,sess_tx_db_reflectCacheMutex,sess_statement_Engine_db_reflectCacheMutex,sess_statement_Engine_mutex,sess_statement_Engine_cacherLock,child_getOwnedOrgsByUserID2880);
	child_getOwnedOrgsByUserID2880?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getOwnedOrgsByUserID288(Mutexdef sess_db_reflectCacheMutex;Mutexdef sess_engine_db_reflectCacheMutex;Mutexdef sess_engine_mutex;Mutexdef sess_engine_cacherLock;Mutexdef sess_tx_db_reflectCacheMutex;Mutexdef sess_statement_Engine_db_reflectCacheMutex;Mutexdef sess_statement_Engine_mutex;Mutexdef sess_statement_Engine_cacherLock;chan child) {
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

