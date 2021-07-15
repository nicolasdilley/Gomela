
// https://github.com/drone/drone/blob/master/store/batch/batch_test.go#L22
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBatch220 = [1] of {int};
	run TestBatch22(child_TestBatch220)
stop_process:skip
}

proctype TestBatch22(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Disconnect611 = [1] of {int};
	chan child_Reset440 = [1] of {int};
	chan child_testBatchDuplicateRename28111 = [1] of {int};
	chan child_testBatchDuplicateSlug24310 = [1] of {int};
	chan child_testBatchDuplicateID1729 = [1] of {int};
	chan child_testBatchDelete1298 = [1] of {int};
	chan child_testBatchUpdate877 = [1] of {int};
	chan child_testBatchInsert506 = [1] of {int};
	chan child_seedUser3325 = [1] of {int};
	chan child_New254 = [1] of {int};
	chan child_New253 = [1] of {int};
	chan child_New282 = [1] of {int};
	Mutexdef batcher_db_conn_Mapper_mutex;
	Mutexdef conn_conn_Mapper_mutex;
	run mutexMonitor(conn_conn_Mapper_mutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(batcher_db_conn_Mapper_mutex);
	run New28(conn_conn_Mapper_mutex,child_New282);
	child_New282?0;
	run New25(conn_conn_Mapper_mutex,child_New253);
	child_New253?0;
	run New25(conn_conn_Mapper_mutex,child_New254);
	child_New254?0;
	run seedUser332(batcher_db_conn_Mapper_mutex,child_seedUser3325);
	child_seedUser3325?0;
	run testBatchInsert50(batcher_db_conn_Mapper_mutex,child_testBatchInsert506);
	child_testBatchInsert506?0;
	run testBatchUpdate87(batcher_db_conn_Mapper_mutex,child_testBatchUpdate877);
	child_testBatchUpdate877?0;
	run testBatchDelete129(batcher_db_conn_Mapper_mutex,child_testBatchDelete1298);
	child_testBatchDelete1298?0;
	run testBatchDuplicateID172(batcher_db_conn_Mapper_mutex,child_testBatchDuplicateID1729);
	child_testBatchDuplicateID1729?0;
	run testBatchDuplicateSlug243(batcher_db_conn_Mapper_mutex,child_testBatchDuplicateSlug24310);
	child_testBatchDuplicateSlug24310?0;
	run testBatchDuplicateRename281(batcher_db_conn_Mapper_mutex,child_testBatchDuplicateRename28111);
	child_testBatchDuplicateRename28111?0;
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
proctype New28(Mutexdef db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype seedUser332(Mutexdef db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testBatchInsert50(Mutexdef batcher_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testBatchUpdate87(Mutexdef batcher_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testBatchDelete129(Mutexdef batcher_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testBatchDuplicateID172(Mutexdef batcher_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testBatchDuplicateSlug243(Mutexdef batcher_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testBatchDuplicateRename281(Mutexdef batcher_db_conn_Mapper_mutex;chan child) {
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

