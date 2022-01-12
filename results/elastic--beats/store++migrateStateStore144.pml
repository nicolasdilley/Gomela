// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//x-pack/elastic-agent/pkg/agent/storage/store/state_store.go#L144
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_migrateStateStore1440 = [1] of {int};
	run migrateStateStore144(child_migrateStateStore1440);
	run receiver(child_migrateStateStore1440)
stop_process:skip
}

proctype migrateStateStore144(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Save2411 = [1] of {int};
	chan child_Add2130 = [1] of {int};
	Mutexdef stateStore_mx;
	

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
	run mutexMonitor(stateStore_mx);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Add213(stateStore_mx,child_Add2130);
	child_Add2130?0;
	run Save241(stateStore_mx,child_Save2411);
	child_Save2411?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Add213(Mutexdef s_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mx.Lock!false;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	fi;
		defer1: skip;
	s_mx.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Save241(Mutexdef s_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mx.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto defer1
			fi
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	s_mx.Unlock!false;
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

