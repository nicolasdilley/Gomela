// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/jmoiron/sqlx/blob//reflectx/reflect_test.go#L631
#define def_var_names  -2 // opt names line 148
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMapperMethodsByName6310 = [1] of {int};
	run TestMapperMethodsByName631(child_TestMapperMethodsByName6310);
	run receiver(child_TestMapperMethodsByName6310)
stop_process:skip
}

proctype TestMapperMethodsByName631(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TraversalsByName1681 = [1] of {int};
	chan child_FieldsByName1480 = [1] of {int};
	int var_names = def_var_names;
	Mutexdef m_mutex;
	int var_values = -2; // opt var_values
	int var_testCases = -2; // opt var_testCases
	run mutexMonitor(m_mutex);
	run FieldsByName148(m_mutex,var_names,child_FieldsByName1480);
	child_FieldsByName1480?0;
	run TraversalsByName168(m_mutex,child_TraversalsByName1681);
	child_TraversalsByName1681?0;
	stop_process: skip;
	child!0
}
proctype FieldsByName148(Mutexdef m_mutex;int var_names;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TypeMap1050 = [1] of {int};
	run TypeMap105(m_mutex,child_TypeMap1050);
	child_TypeMap1050?0;
	goto stop_process;
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
proctype TraversalsByName168(Mutexdef m_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TraversalsByNameFunc1851 = [1] of {int};
	int var_names = def_var_names;
	run TraversalsByNameFunc185(m_mutex,var_names,child_TraversalsByNameFunc1851);
	child_TraversalsByNameFunc1851?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype TraversalsByNameFunc185(Mutexdef m_mutex;int var_names;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TypeMap1051 = [1] of {int};
	run TypeMap105(m_mutex,child_TypeMap1051);
	child_TypeMap1051?0;
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

