// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/tal-tech/go-zero/blob//core/hash/consistenthash_test.go#L139
#define def_var_h_replicas  -2 // opt replicas line 68
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_getKeysBeforeAndAfterFailure1390 = [1] of {int};
	run getKeysBeforeAndAfterFailure139(child_getKeysBeforeAndAfterFailure1390);
	run receiver(child_getKeysBeforeAndAfterFailure1390)
stop_process:skip
}

proctype getKeysBeforeAndAfterFailure139(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get1016 = [1] of {int};
	chan child_Get1015 = [1] of {int};
	chan child_Remove1284 = [1] of {int};
	chan child_Get1013 = [1] of {int};
	chan child_Get1012 = [1] of {int};
	chan child_Add611 = [1] of {int};
	chan child_Add610 = [1] of {int};
	Mutexdef ch_lock;
	run mutexMonitor(ch_lock);
	

	if
	:: 0 != -2 && 20-1 != -3 -> 
				for(i : 0.. 20-1) {
			for17: skip;
			run Add61(ch_lock,child_Add611);
			child_Add611?0;
			for17_end: skip
		};
		for17_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Add61(ch_lock,child_Add610);
			child_Add610?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: 0 != -2 && 1000-1 != -3 -> 
				for(i : 0.. 1000-1) {
			for21: skip;
			run Get101(ch_lock,child_Get1013);
			child_Get1013?0;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run Get101(ch_lock,child_Get1012);
			child_Get1012?0;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	run Remove128(ch_lock,child_Remove1284);
	child_Remove1284?0;
	

	if
	:: 0 != -2 && 1000-1 != -3 -> 
				for(i : 0.. 1000-1) {
			for31: skip;
			run Get101(ch_lock,child_Get1016);
			child_Get1016?0;
			for31_end: skip
		};
		for31_exit: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			run Get101(ch_lock,child_Get1015);
			child_Get1015?0;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Add61(Mutexdef h_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AddWithReplicas680 = [1] of {int};
	int var_h_replicas = def_var_h_replicas;
	run AddWithReplicas68(h_lock,var_h_replicas,child_AddWithReplicas680);
	child_AddWithReplicas680?0;
	stop_process: skip;
	child!0
}
proctype AddWithReplicas68(Mutexdef h_lock;int var_replicas;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_addNode1681 = [1] of {int};
	chan child_Remove1280 = [1] of {int};
	run Remove128(h_lock,child_Remove1280);
	child_Remove1280?0;
	h_lock.Lock!false;
	run addNode168(h_lock,child_addNode1681);
	child_addNode1681?0;
		defer1: skip;
	h_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Remove128(Mutexdef h_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_removeNode1773 = [1] of {int};
	chan child_removeRingNode1522 = [1] of {int};
	chan child_removeRingNode1521 = [1] of {int};
	chan child_containsNode1720 = [1] of {int};
	int var_h_replicas = -2; // opt var_h_replicas
	h_lock.Lock!false;
	run containsNode172(h_lock,child_containsNode1720);
	child_containsNode1720?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: 0 != -2 && var_h_replicas-1 != -3 -> 
				for(i : 0.. var_h_replicas-1) {
			for14: skip;
			run removeRingNode152(h_lock,child_removeRingNode1522);
			child_removeRingNode1522?0;
			for14_end: skip
		};
		for14_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run removeRingNode152(h_lock,child_removeRingNode1521);
			child_removeRingNode1521?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	run removeNode177(h_lock,child_removeNode1773);
	child_removeNode1773?0;
		defer1: skip;
	h_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype containsNode172(Mutexdef h_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype removeRingNode152(Mutexdef h_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_nodes = -2; // opt var_nodes
	stop_process: skip;
	child!0
}
proctype removeNode177(Mutexdef h_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype addNode168(Mutexdef h_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Get101(Mutexdef h_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	h_lock.RLock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true -> 
		goto defer1
	:: true -> 
		goto defer1
	fi;
		defer1: skip;
	h_lock.RUnlock!false;
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

