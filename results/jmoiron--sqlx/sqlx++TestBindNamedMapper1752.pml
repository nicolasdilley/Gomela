// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/jmoiron/sqlx/blob//sqlx_test.go#L1752
#define def_var_names  -2 // opt names line 197
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBindNamedMapper17520 = [1] of {int};
	run TestBindNamedMapper1752(child_TestBindNamedMapper17520);
	run receiver(child_TestBindNamedMapper17520)
stop_process:skip
}

proctype TestBindNamedMapper1752(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_bindNamedMapper4211 = [1] of {int};
	chan child_bindNamedMapper4210 = [1] of {int};
	Mutexdef m_mutex;
	run mutexMonitor(m_mutex);
	run bindNamedMapper421(m_mutex,child_bindNamedMapper4210);
	child_bindNamedMapper4210?0;
	run bindNamedMapper421(m_mutex,child_bindNamedMapper4211);
	child_bindNamedMapper4211?0;
	stop_process: skip;
	child!0
}
proctype bindNamedMapper421(Mutexdef m_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_bindMap3040 = [1] of {int};
	chan child_bindArray2731 = [1] of {int};
	chan child_bindStruct2132 = [1] of {int};
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run bindMap304(m_mutex,child_bindMap3040);
		child_bindMap3040?0;
		goto stop_process
	:: true -> 
		run bindArray273(m_mutex,child_bindArray2731);
		child_bindArray2731?0;
		goto stop_process
	:: true -> 
		run bindStruct213(m_mutex,child_bindStruct2132);
		child_bindStruct2132?0;
		goto stop_process
	fi;
	stop_process: skip;
	child!0
}
proctype bindMap304(Mutexdef args_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_bindMapArgs1970 = [1] of {int};
	int var_names = def_var_names;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run bindMapArgs197(args_mutex,var_names,child_bindMapArgs1970);
	child_bindMapArgs1970?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype bindMapArgs197(Mutexdef arg_mutex;int var_names;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype bindArray273(Mutexdef m_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_bindAnyArgs1632 = [1] of {int};
	chan child_bindAnyArgs1631 = [1] of {int};
	int var_arrayLen = -2; // opt var_arrayLen
	

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
	

	if
	:: 0 != -2 && var_arrayLen-1 != -3 -> 
				for(i : 0.. var_arrayLen-1) {
			for23: skip;
			run bindAnyArgs163(m_mutex,child_bindAnyArgs1632);
			child_bindAnyArgs1632?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for23_end: skip
		};
		for23_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run bindAnyArgs163(m_mutex,child_bindAnyArgs1631);
			child_bindAnyArgs1631?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype bindAnyArgs163(Mutexdef m_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_bindArgs1731 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run bindArgs173(m_mutex,child_bindArgs1731);
	child_bindArgs1731?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype bindArgs173(Mutexdef m_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype bindStruct213(Mutexdef m_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_bindAnyArgs1632 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run bindAnyArgs163(m_mutex,child_bindAnyArgs1632);
	child_bindAnyArgs1632?0;
	

	if
	:: true -> 
		goto stop_process
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

