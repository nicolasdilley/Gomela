// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/jmoiron/sqlx/blob//reflectx/reflect_test.go#L298
#define def_var_names  -2 // opt names line 185
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFieldsEmbedded2980 = [1] of {int};
	run TestFieldsEmbedded298(child_TestFieldsEmbedded2980);
	run receiver(child_TestFieldsEmbedded2980)
stop_process:skip
}

proctype TestFieldsEmbedded298(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TraversalsByName1684 = [1] of {int};
	chan child_FieldByName1333 = [1] of {int};
	chan child_FieldByName1332 = [1] of {int};
	chan child_FieldByName1331 = [1] of {int};
	chan child_TypeMap1050 = [1] of {int};
	Mutexdef m_mutex;
	run mutexMonitor(m_mutex);
	run TypeMap105(m_mutex,child_TypeMap1050);
	child_TypeMap1050?0;
	run FieldByName133(m_mutex,child_FieldByName1331);
	child_FieldByName1331?0;
	run FieldByName133(m_mutex,child_FieldByName1332);
	child_FieldByName1332?0;
	run FieldByName133(m_mutex,child_FieldByName1333);
	child_FieldByName1333?0;
	run TraversalsByName168(m_mutex,child_TraversalsByName1684);
	child_TraversalsByName1684?0;
	stop_process: skip;
	child!0
}
proctype TypeMap105(Mutexdef m_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	m_mutex.Lock!false;
	m_mutex.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype FieldByName133(Mutexdef m_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TypeMap1051 = [1] of {int};
	run TypeMap105(m_mutex,child_TypeMap1051);
	child_TypeMap1051?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype TraversalsByName168(Mutexdef m_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TraversalsByNameFunc1854 = [1] of {int};
	int var_names = def_var_names;
	run TraversalsByNameFunc185(m_mutex,var_names,child_TraversalsByNameFunc1854);
	child_TraversalsByNameFunc1854?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype TraversalsByNameFunc185(Mutexdef m_mutex;int var_names;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TypeMap1054 = [1] of {int};
	run TypeMap105(m_mutex,child_TypeMap1054);
	child_TypeMap1054?0;
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

