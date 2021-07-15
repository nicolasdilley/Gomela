
// https://github.com/drone/drone/blob/master/store/build/build_test.go#L20
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBuild200 = [1] of {int};
	run TestBuild20(child_TestBuild200)
stop_process:skip
}

proctype TestBuild20(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Disconnect611 = [1] of {int};
	chan child_Reset440 = [1] of {int};
	chan child_testBuildLatest3138 = [1] of {int};
	chan child_testBuildRunning2867 = [1] of {int};
	chan child_testBuildPending2596 = [1] of {int};
	chan child_testBuildCount2395 = [1] of {int};
	chan child_testBuildPurge2024 = [1] of {int};
	chan child_testBuildCreate403 = [1] of {int};
	chan child_New322 = [1] of {int};
	Mutexdef store_db_conn_Mapper_mutex;
	Mutexdef conn_conn_Mapper_mutex;
	run mutexMonitor(conn_conn_Mapper_mutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(store_db_conn_Mapper_mutex);
	run New32(conn_conn_Mapper_mutex,child_New322);
	child_New322?0;
	run testBuildCreate40(store_db_conn_Mapper_mutex,child_testBuildCreate403);
	child_testBuildCreate403?0;
	run testBuildPurge202(store_db_conn_Mapper_mutex,child_testBuildPurge2024);
	child_testBuildPurge2024?0;
	run testBuildCount239(store_db_conn_Mapper_mutex,child_testBuildCount2395);
	child_testBuildCount2395?0;
	run testBuildPending259(store_db_conn_Mapper_mutex,child_testBuildPending2596);
	child_testBuildPending2596?0;
	run testBuildRunning286(store_db_conn_Mapper_mutex,child_testBuildRunning2867);
	child_testBuildRunning2867?0;
	run testBuildLatest313(store_db_conn_Mapper_mutex,child_testBuildLatest3138);
	child_testBuildLatest3138?0;
	stop_process: skip;
		run Reset44(conn_conn_Mapper_mutex,child_Reset440);
	child_Reset440?0;
	run Disconnect61(conn_conn_Mapper_mutex,child_Disconnect611);
	child_Disconnect611?0;
	child!0
}
proctype Reset44(Mutexdef d_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Disconnect61(Mutexdef d_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype New32(Mutexdef db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testBuildCreate40(Mutexdef store_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testBuildPurge202(Mutexdef store_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testBuildCount239(Mutexdef store_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testBuildPending259(Mutexdef store_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testBuildRunning286(Mutexdef store_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testBuildLatest313(Mutexdef store_db_conn_Mapper_mutex;chan child) {
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

