// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/grafana/loki/blob/aa544a9dffdb8e78f7d7ed8edafce466d333b0a8/pkg/ingester/flush_test.go#L57
#define not_found_61  -2 // opt testData line 392
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
	chan child_TestChunkFlushingShutdown570 = [1] of {int};
	run TestChunkFlushingShutdown57(child_TestChunkFlushingShutdown570);
	run receiver(child_TestChunkFlushingShutdown570)
stop_process:skip
}

proctype TestChunkFlushingShutdown57(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkData3921 = [1] of {int};
	chan child_pushTestSamples3460 = [1] of {int};
	Mutexdef ing_limiter_mtx;
	Wgdef ing_flushQueuesDone;
	Wgdef ing_loopDone;
	Mutexdef ing_lifecycler_countersLock;
	Mutexdef ing_lifecycler_readyLock;
	Mutexdef ing_lifecycler_stateMtx;
	Mutexdef ing_instancesMtx;
	Mutexdef ing_shutdownMtx;
	Mutexdef store_mtx;
	run mutexMonitor(store_mtx);
	run mutexMonitor(ing_shutdownMtx);
	run mutexMonitor(ing_instancesMtx);
	run mutexMonitor(ing_lifecycler_stateMtx);
	run mutexMonitor(ing_lifecycler_readyLock);
	run mutexMonitor(ing_lifecycler_countersLock);
	run wgMonitor(ing_loopDone);
	run wgMonitor(ing_flushQueuesDone);
	run mutexMonitor(ing_limiter_mtx);
	run pushTestSamples346(ing_flushQueuesDone,ing_loopDone,ing_instancesMtx,ing_lifecycler_countersLock,ing_lifecycler_readyLock,ing_lifecycler_stateMtx,ing_limiter_mtx,ing_shutdownMtx,child_pushTestSamples3460);
	child_pushTestSamples3460?0;
	run checkData392(store_mtx,not_found_61,child_checkData3921);
	child_checkData3921?0;
	stop_process: skip;
	child!0
}
proctype pushTestSamples346(Wgdef ing_flushQueuesDone;Wgdef ing_loopDone;Mutexdef ing_instancesMtx;Mutexdef ing_lifecycler_countersLock;Mutexdef ing_lifecycler_readyLock;Mutexdef ing_lifecycler_stateMtx;Mutexdef ing_limiter_mtx;Mutexdef ing_shutdownMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_userIDs = -2; // opt var_userIDs
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype checkData392(Mutexdef s_mtx;int var_testData;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getStreamsForUser3991 = [1] of {int};
	chan child_getStreamsForUser3992 = [1] of {int};
	

	if
	:: var_testData-1 != -3 -> 
				for(i : 0.. var_testData-1) {
			for30: skip;
			run getStreamsForUser399(s_mtx,child_getStreamsForUser3991);
			child_getStreamsForUser3991?0;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for33: skip;
			run getStreamsForUser399(s_mtx,child_getStreamsForUser3992);
			child_getStreamsForUser3992?0;
			for33_end: skip
		:: true -> 
			break
		od;
		for33_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype getStreamsForUser399(Mutexdef s_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_s_getChunksForUser = -2; // opt var_s_getChunksForUser
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

