
// https://github.com/istio/istio/blob/master/pilot/pkg/trustbundle/trustbundle_test.go#L158
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUpdateTrustAnchor1580 = [1] of {int};
	run TestUpdateTrustAnchor158(child_TestUpdateTrustAnchor1580)
stop_process:skip
}

proctype TestUpdateTrustAnchor158(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetTrustBundle11013 = [1] of {int};
	chan child_UpdateTrustAnchor15412 = [1] of {int};
	chan child_UpdateTrustAnchor15411 = [1] of {int};
	chan child_GetTrustBundle11010 = [1] of {int};
	chan child_UpdateTrustAnchor1549 = [1] of {int};
	chan child_GetTrustBundle1108 = [1] of {int};
	chan child_UpdateTrustAnchor1547 = [1] of {int};
	chan child_GetTrustBundle1106 = [1] of {int};
	chan child_UpdateTrustAnchor1545 = [1] of {int};
	chan child_GetTrustBundle1104 = [1] of {int};
	chan child_UpdateTrustAnchor1543 = [1] of {int};
	chan child_GetTrustBundle1102 = [1] of {int};
	chan child_UpdateTrustAnchor1541 = [1] of {int};
	chan child_UpdateCb1050 = [1] of {int};
	Mutexdef tb_endpointMutex;
	Mutexdef tb_mutex;
	run mutexMonitor(tb_mutex);
	run mutexMonitor(tb_endpointMutex);
	run UpdateCb105(tb_mutex,tb_endpointMutex,child_UpdateCb1050);
	child_UpdateCb1050?0;
	run UpdateTrustAnchor154(tb_mutex,tb_endpointMutex,child_UpdateTrustAnchor1541);
	child_UpdateTrustAnchor1541?0;
	run GetTrustBundle110(tb_mutex,tb_endpointMutex,child_GetTrustBundle1102);
	child_GetTrustBundle1102?0;
	run UpdateTrustAnchor154(tb_mutex,tb_endpointMutex,child_UpdateTrustAnchor1543);
	child_UpdateTrustAnchor1543?0;
	run GetTrustBundle110(tb_mutex,tb_endpointMutex,child_GetTrustBundle1104);
	child_GetTrustBundle1104?0;
	run UpdateTrustAnchor154(tb_mutex,tb_endpointMutex,child_UpdateTrustAnchor1545);
	child_UpdateTrustAnchor1545?0;
	run GetTrustBundle110(tb_mutex,tb_endpointMutex,child_GetTrustBundle1106);
	child_GetTrustBundle1106?0;
	run UpdateTrustAnchor154(tb_mutex,tb_endpointMutex,child_UpdateTrustAnchor1547);
	child_UpdateTrustAnchor1547?0;
	run GetTrustBundle110(tb_mutex,tb_endpointMutex,child_GetTrustBundle1108);
	child_GetTrustBundle1108?0;
	run UpdateTrustAnchor154(tb_mutex,tb_endpointMutex,child_UpdateTrustAnchor1549);
	child_UpdateTrustAnchor1549?0;
	run GetTrustBundle110(tb_mutex,tb_endpointMutex,child_GetTrustBundle11010);
	child_GetTrustBundle11010?0;
	run UpdateTrustAnchor154(tb_mutex,tb_endpointMutex,child_UpdateTrustAnchor15411);
	child_UpdateTrustAnchor15411?0;
	run UpdateTrustAnchor154(tb_mutex,tb_endpointMutex,child_UpdateTrustAnchor15412);
	child_UpdateTrustAnchor15412?0;
	run GetTrustBundle110(tb_mutex,tb_endpointMutex,child_GetTrustBundle11013);
	child_GetTrustBundle11013?0;
	stop_process: skip;
	child!0
}
proctype UpdateCb105(Mutexdef tb_mutex;Mutexdef tb_endpointMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype UpdateTrustAnchor154(Mutexdef tb_mutex;Mutexdef tb_endpointMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_mergeInternal1331 = [1] of {int};
	

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
	run mergeInternal133(tb_mutex,tb_endpointMutex,child_mergeInternal1331);
	child_mergeInternal1331?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype mergeInternal133(Mutexdef tb_mutex;Mutexdef tb_endpointMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	tb_mutex.Lock!false;
	stop_process: skip;
		tb_mutex.Unlock!false;
	child!0
}
proctype GetTrustBundle110(Mutexdef tb_mutex;Mutexdef tb_endpointMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	tb_mutex.RLock!false;
	goto stop_process;
	stop_process: skip;
		tb_mutex.RUnlock!false;
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

