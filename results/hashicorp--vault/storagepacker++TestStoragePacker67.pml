
// https://github.com/hashicorp/vault/blob/master/helper/storagepacker/storagepacker_test.go#L67
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStoragePacker670 = [1] of {int};
	run TestStoragePacker67(child_TestStoragePacker670)
stop_process:skip
}

proctype TestStoragePacker67(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef fetchedItem_Message_state_atomicMessageInfo_initMu;
	Mutexdef fetchedItem_state_atomicMessageInfo_initMu;
	chan child_PutItem3000 = [1] of {int};
	Mutexdef item1_Message_state_atomicMessageInfo_initMu;
	Mutexdef item1_state_atomicMessageInfo_initMu;
	run mutexMonitor(item1_state_atomicMessageInfo_initMu);
	run mutexMonitor(item1_Message_state_atomicMessageInfo_initMu);
	run PutItem300(item1_state_atomicMessageInfo_initMu,item1_Message_state_atomicMessageInfo_initMu,child_PutItem3000);
	child_PutItem3000?0;
	run mutexMonitor(fetchedItem_state_atomicMessageInfo_initMu);
	run mutexMonitor(fetchedItem_Message_state_atomicMessageInfo_initMu);
	stop_process: skip;
	child!0
}
proctype PutItem300(Mutexdef item_state_atomicMessageInfo_initMu;Mutexdef item_Message_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_putBucket2311 = [1] of {int};
	chan child_upsert810 = [1] of {int};
	Mutexdef bucket_state_atomicMessageInfo_initMu;
	

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
	run mutexMonitor(bucket_state_atomicMessageInfo_initMu);
	

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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run upsert81(bucket_state_atomicMessageInfo_initMu,item_state_atomicMessageInfo_initMu,item_Message_state_atomicMessageInfo_initMu,child_upsert810);
		child_upsert810?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	run putBucket231(bucket_state_atomicMessageInfo_initMu,child_putBucket2311);
	child_putBucket2311?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype upsert81(Mutexdef s_state_atomicMessageInfo_initMu;Mutexdef item_state_atomicMessageInfo_initMu;Mutexdef item_Message_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype putBucket231(Mutexdef bucket_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

