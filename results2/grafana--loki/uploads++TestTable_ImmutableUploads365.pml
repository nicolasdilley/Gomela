// num_comm_params=5
// num_mand_comm_params=0
// num_opt_comm_params=5

// git_link=https://github.com/grafana/loki/blob/aa544a9dffdb8e78f7d7ed8edafce466d333b0a8/pkg/storage/stores/shipper/uploads/table_test.go#L365
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTable_ImmutableUploads3650 = [1] of {int};
	run TestTable_ImmutableUploads365(child_TestTable_ImmutableUploads3650);
	run receiver(child_TestTable_ImmutableUploads3650)
stop_process:skip
}

proctype TestTable_ImmutableUploads365(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stop2630 = [1] of {int};
	chan child_Stop2632 = [1] of {int};
	chan child_buildObjectKey45610 = [1] of {int};
	chan child_buildObjectKey45611 = [1] of {int};
	chan child_Upload3209 = [1] of {int};
	chan child_buildObjectKey4567 = [1] of {int};
	chan child_buildObjectKey4568 = [1] of {int};
	chan child_Upload3206 = [1] of {int};
	chan child_buildObjectKey4564 = [1] of {int};
	chan child_buildObjectKey4565 = [1] of {int};
	chan child_Upload3203 = [1] of {int};
	chan child_LoadTable851 = [1] of {int};
	Mutexdef table_dbUploadTimeMtx;
	Mutexdef table_dbSnapshotsMtx;
	Mutexdef table_dbsMtx;
	Wgdef boltDBIndexClient_wait;
	Mutexdef boltDBIndexClient_dbsMtx;
	int dir = -2; // opt dir
	int expectedDBsToUpload = -2; // opt expectedDBsToUpload
	int dbNames = -2; // opt dbNames
	run mutexMonitor(boltDBIndexClient_dbsMtx);
	run wgMonitor(boltDBIndexClient_wait);
	run mutexMonitor(table_dbsMtx);
	run mutexMonitor(table_dbSnapshotsMtx);
	run mutexMonitor(table_dbUploadTimeMtx);
	run LoadTable85(boltDBIndexClient_wait,boltDBIndexClient_dbsMtx,child_LoadTable851);
	child_LoadTable851?0;
	run Upload320(table_dbSnapshotsMtx,table_dbsMtx,table_dbUploadTimeMtx,child_Upload3203);
	child_Upload3203?0;
	

	if
	:: expectedDBsToUpload-1 != -3 -> 
				for(i : 0.. expectedDBsToUpload-1) {
			for40: skip;
			run buildObjectKey456(table_dbSnapshotsMtx,table_dbsMtx,table_dbUploadTimeMtx,child_buildObjectKey4564);
			child_buildObjectKey4564?0;
			for40_end: skip
		};
		for40_exit: skip
	:: else -> 
		do
		:: true -> 
			for41: skip;
			run buildObjectKey456(table_dbSnapshotsMtx,table_dbsMtx,table_dbUploadTimeMtx,child_buildObjectKey4565);
			child_buildObjectKey4565?0;
			for41_end: skip
		:: true -> 
			break
		od;
		for41_exit: skip
	fi;
	run Upload320(table_dbSnapshotsMtx,table_dbsMtx,table_dbUploadTimeMtx,child_Upload3206);
	child_Upload3206?0;
	

	if
	:: expectedDBsToUpload-1 != -3 -> 
				for(i : 0.. expectedDBsToUpload-1) {
			for50: skip;
			run buildObjectKey456(table_dbSnapshotsMtx,table_dbsMtx,table_dbUploadTimeMtx,child_buildObjectKey4567);
			child_buildObjectKey4567?0;
			for50_end: skip
		};
		for50_exit: skip
	:: else -> 
		do
		:: true -> 
			for51: skip;
			run buildObjectKey456(table_dbSnapshotsMtx,table_dbsMtx,table_dbUploadTimeMtx,child_buildObjectKey4568);
			child_buildObjectKey4568?0;
			for51_end: skip
		:: true -> 
			break
		od;
		for51_exit: skip
	fi;
	run Upload320(table_dbSnapshotsMtx,table_dbsMtx,table_dbUploadTimeMtx,child_Upload3209);
	child_Upload3209?0;
	

	if
	:: expectedDBsToUpload-1 != -3 -> 
				for(i : 0.. expectedDBsToUpload-1) {
			for70: skip;
			run buildObjectKey456(table_dbSnapshotsMtx,table_dbsMtx,table_dbUploadTimeMtx,child_buildObjectKey45610);
			child_buildObjectKey45610?0;
			for70_end: skip
		};
		for70_exit: skip
	:: else -> 
		do
		:: true -> 
			for71: skip;
			run buildObjectKey456(table_dbSnapshotsMtx,table_dbsMtx,table_dbUploadTimeMtx,child_buildObjectKey45611);
			child_buildObjectKey45611?0;
			for71_end: skip
		:: true -> 
			break
		od;
		for71_exit: skip
	fi;
		defer2: skip;
	run Stop263(table_dbSnapshotsMtx,table_dbsMtx,table_dbUploadTimeMtx,child_Stop2632);
	child_Stop2632?0;
		defer1: skip;
	run Stop263(boltDBIndexClient_wait,boltDBIndexClient_dbsMtx,child_Stop2630);
	child_Stop2630?0;
	stop_process: skip;
	child!0
}
proctype Stop263(Wgdef lt_wait;Mutexdef lt_dbsMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int lt_dbs = -2; // opt lt_dbs
	lt_dbsMtx.Lock!false;
		defer1: skip;
	lt_dbsMtx.Unlock!false;
	stop_process: skip;
	child!0
}
proctype LoadTable85(Wgdef boltdbIndexClient_wait;Mutexdef boltdbIndexClient_dbsMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newTableWithDBs981 = [1] of {int};
	

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
	run newTableWithDBs98(boltdbIndexClient_wait,boltdbIndexClient_dbsMtx,child_newTableWithDBs981);
	child_newTableWithDBs981?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newTableWithDBs98(Wgdef boltdbIndexClient_wait;Mutexdef boltdbIndexClient_dbsMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Upload320(Mutexdef lt_dbSnapshotsMtx;Mutexdef lt_dbsMtx;Mutexdef lt_dbUploadTimeMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_uploadDB3683 = [1] of {int};
	chan child_uploadDB3684 = [1] of {int};
	int lt_dbs = -2; // opt lt_dbs
	lt_dbsMtx.RLock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: lt_dbs-1 != -3 -> 
				for(i : 0.. lt_dbs-1) {
			for30: skip;
			

			if
			:: true -> 
				goto for30_end
			:: true;
			fi;
			lt_dbUploadTimeMtx.RLock!false;
			lt_dbUploadTimeMtx.RUnlock!false;
			

			if
			:: true -> 
				goto for30_end
			:: true;
			fi;
			run uploadDB368(lt_dbSnapshotsMtx,lt_dbsMtx,lt_dbUploadTimeMtx,child_uploadDB3683);
			child_uploadDB3683?0;
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi;
			lt_dbUploadTimeMtx.Lock!false;
			lt_dbUploadTimeMtx.Unlock!false;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for31: skip;
			

			if
			:: true -> 
				goto for31_end
			:: true;
			fi;
			lt_dbUploadTimeMtx.RLock!false;
			lt_dbUploadTimeMtx.RUnlock!false;
			

			if
			:: true -> 
				goto for31_end
			:: true;
			fi;
			run uploadDB368(lt_dbSnapshotsMtx,lt_dbsMtx,lt_dbUploadTimeMtx,child_uploadDB3684);
			child_uploadDB3684?0;
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi;
			lt_dbUploadTimeMtx.Lock!false;
			lt_dbUploadTimeMtx.Unlock!false;
			for31_end: skip
		:: true -> 
			break
		od;
		for31_exit: skip
	fi;
	goto defer1;
		defer1: skip;
	lt_dbsMtx.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype uploadDB368(Mutexdef lt_dbSnapshotsMtx;Mutexdef lt_dbsMtx;Mutexdef lt_dbUploadTimeMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_buildObjectKey4563 = [1] of {int};
	

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
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run buildObjectKey456(lt_dbSnapshotsMtx,lt_dbsMtx,lt_dbUploadTimeMtx,child_buildObjectKey4563);
	child_buildObjectKey4563?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype buildObjectKey456(Mutexdef lt_dbSnapshotsMtx;Mutexdef lt_dbsMtx;Mutexdef lt_dbUploadTimeMtx;chan child) {
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
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

