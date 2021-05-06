
// https://github.com/drone/drone/blob/master/store/batch2/batch_test.go#L22
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
	chan child_testBatchDuplicateRecreateRename30112 = [1] of {int};
	chan child_testBatchDuplicateRename34011 = [1] of {int};
	chan child_testBatchDuplicateSlug26610 = [1] of {int};
	chan child_testBatchDuplicateID1749 = [1] of {int};
	chan child_testBatchDelete1318 = [1] of {int};
	chan child_testBatchUpdate897 = [1] of {int};
	chan child_testBatchInsert526 = [1] of {int};
	chan child_seedUser3915 = [1] of {int};
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
	run seedUser391(batcher_db_conn_Mapper_mutex,child_seedUser3915);
	child_seedUser3915?0;
	run testBatchInsert52(batcher_db_conn_Mapper_mutex,child_testBatchInsert526);
	child_testBatchInsert526?0;
	run testBatchUpdate89(batcher_db_conn_Mapper_mutex,child_testBatchUpdate897);
	child_testBatchUpdate897?0;
	run testBatchDelete131(batcher_db_conn_Mapper_mutex,child_testBatchDelete1318);
	child_testBatchDelete1318?0;
	run testBatchDuplicateID174(batcher_db_conn_Mapper_mutex,child_testBatchDuplicateID1749);
	child_testBatchDuplicateID1749?0;
	run testBatchDuplicateSlug266(batcher_db_conn_Mapper_mutex,child_testBatchDuplicateSlug26610);
	child_testBatchDuplicateSlug26610?0;
	run testBatchDuplicateRename340(batcher_db_conn_Mapper_mutex,child_testBatchDuplicateRename34011);
	child_testBatchDuplicateRename34011?0;
	run testBatchDuplicateRecreateRename301(batcher_db_conn_Mapper_mutex,child_testBatchDuplicateRecreateRename30112);
	child_testBatchDuplicateRecreateRename30112?0;
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
proctype seedUser391(Mutexdef db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testBatchInsert52(Mutexdef batcher_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testBatchUpdate89(Mutexdef batcher_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testBatchDelete131(Mutexdef batcher_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testBatchDuplicateID174(Mutexdef batcher_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testBatchDuplicateSlug266(Mutexdef batcher_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testBatchDuplicateRename340(Mutexdef batcher_db_conn_Mapper_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype testBatchDuplicateRecreateRename301(Mutexdef batcher_db_conn_Mapper_mutex;chan child) {
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

