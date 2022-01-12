// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob//planner/optimize.go#L344
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_getBindRecord3440 = [1] of {int};
	run getBindRecord344(child_getBindRecord3440);
	run receiver(child_getBindRecord3440)
stop_process:skip
}

proctype getBindRecord344(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetBindRecord4840 = [1] of {int};
	Mutexdef globalHandle_bindInfo;
	Mutexdef globalHandle_sctx;
	

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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(globalHandle_sctx);
	run mutexMonitor(globalHandle_bindInfo);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run GetBindRecord484(globalHandle_bindInfo,globalHandle_sctx,child_GetBindRecord4840);
	child_GetBindRecord4840?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetBindRecord484(Mutexdef h_bindInfo;Mutexdef h_sctx;chan child) {
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

proctype receiver(chan c) {
c?0
}

