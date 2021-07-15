
// https://github.com/drone/drone/blob/master/store/repos/repos_test.go#L25
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRepo250 = [1] of {int};
	run TestRepo25(child_TestRepo250)
stop_process:skip
}

proctype TestRepo25(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Disconnect611 = [1] of {int};
	chan child_Reset440 = [1] of {int};
	chan child_testRepoDelete30813 = [1] of {int};
	chan child_testRepoIncrement28812 = [1] of {int};
	chan child_testRepoLocking27111 = [1] of {int};
	chan child_testRepoActivate24710 = [1] of {int};
	chan child_testRepoUpdate2189 = [1] of {int};
	chan child_testRepoListLatest2018 = [1] of {int};
	chan child_testRepoList1657 = [1] of {int};
	chan child_testRepoFindName1386 = [1] of {int};
	chan child_testRepoFind1065 = [1] of {int};
	chan child_testRepoCount944 = [1] of {int};
	chan child_testRepoCreate503 = [1] of {int};
	chan child_New252 = [1] of {int};
	Mutexdef store_db_conn_Mapper_mutex;
	Mutexdef conn_conn_Mapper_mutex;
	run mutexMonitor(conn_conn_Mapper_mutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(store_db_conn_Mapper_mutex);
	run New25(conn_conn_Mapper_mutex,child_New252);
	child_New252?0;
	run testRepoCreate50(store_db_conn_Mapper_mutex,child_testRepoCreate503);
	child_testRepoCreate503?0;
	run testRepoCount94(store_db_conn_Mapper_mutex,child_testRepoCount944);
	child_testRepoCount944?0;
	run testRepoFind106(store_db_conn_Mapper_mutex,child_testRepoFind1065);
	child_testRepoFind1065?0;
	run testRepoFindName138(store_db_conn_Mapper_mutex,child_testRepoFindName1386);
	child_testRepoFindName1386?0;
	run testRepoList165(store_db_conn_Mapper_mutex,child_testRepoList1657);
	child_testRepoList1657?0;
	run testRepoListLatest201(store_db_conn_Mapper_mutex,child_testRepoListLatest2018);
	child_testRepoListLatest2018?0;
	run testRepoUpdate218(store_db_conn_Mapper_mutex,child_testRepoUpdate2189);
	child_testRepoUpdate2189?0;
	run testRepoActivate247(store_db_conn_Mapper_mutex,child_testRepoActivate24710);
	child_testRepoActivate24710?0;
	run testRepoLocking271(store_db_conn_Mapper_mutex,child_testRepoLocking27111);
	child_testRepoLocking27111?0;
	run testRepoIncrement288(store_db_conn_Mapper_mutex,child_testRepoIncrement28812);
	child_testRepoIncrement28812?0;
	run testRepoDelete308(store_db_conn_Mapper_mutex,child_testRepoDelete30813);
	child_testRepoDelete30813?0;
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
proctype New25(Mutexdef db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testRepoCreate50(Mutexdef repos_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testRepoCount94(Mutexdef repos_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testRepoFind106(Mutexdef repos_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testRepoFindName138(Mutexdef repos_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testRepoList165(Mutexdef repos_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testRepoListLatest201(Mutexdef repos_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testRepoUpdate218(Mutexdef repos_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testRepoActivate247(Mutexdef repos_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testRepoLocking271(Mutexdef repos_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testRepoIncrement288(Mutexdef repos_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testRepoDelete308(Mutexdef repos_db_conn_Mapper_mutex;chan child) {
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

