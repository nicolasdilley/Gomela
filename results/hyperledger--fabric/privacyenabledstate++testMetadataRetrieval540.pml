// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/ledger/kvledger/txmgmt/privacyenabledstate/db_test.go#L540
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testMetadataRetrieval5400 = [1] of {int};
	run testMetadataRetrieval540(child_testMetadataRetrieval5400);
	run receiver(child_testMetadataRetrieval5400)
stop_process:skip
}

proctype testMetadataRetrieval540(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetPrivateDataMetadataByHash2846 = [1] of {int};
	chan child_GetPrivateDataMetadataByHash2845 = [1] of {int};
	chan child_GetPrivateDataMetadataByHash2844 = [1] of {int};
	chan child_GetStateMetadata2713 = [1] of {int};
	chan child_GetStateMetadata2712 = [1] of {int};
	chan child_GetStateMetadata2711 = [1] of {int};
	chan child_ApplyPrivacyAwareUpdates2550 = [1] of {int};
	Mutexdef db_metadataHint_bookkeeper_db_mutex;
	run mutexMonitor(db_metadataHint_bookkeeper_db_mutex);
	run ApplyPrivacyAwareUpdates255(db_metadataHint_bookkeeper_db_mutex,child_ApplyPrivacyAwareUpdates2550);
	child_ApplyPrivacyAwareUpdates2550?0;
	run GetStateMetadata271(db_metadataHint_bookkeeper_db_mutex,child_GetStateMetadata2711);
	child_GetStateMetadata2711?0;
	run GetStateMetadata271(db_metadataHint_bookkeeper_db_mutex,child_GetStateMetadata2712);
	child_GetStateMetadata2712?0;
	run GetStateMetadata271(db_metadataHint_bookkeeper_db_mutex,child_GetStateMetadata2713);
	child_GetStateMetadata2713?0;
	run GetPrivateDataMetadataByHash284(db_metadataHint_bookkeeper_db_mutex,child_GetPrivateDataMetadataByHash2844);
	child_GetPrivateDataMetadataByHash2844?0;
	run GetPrivateDataMetadataByHash284(db_metadataHint_bookkeeper_db_mutex,child_GetPrivateDataMetadataByHash2845);
	child_GetPrivateDataMetadataByHash2845?0;
	run GetPrivateDataMetadataByHash284(db_metadataHint_bookkeeper_db_mutex,child_GetPrivateDataMetadataByHash2846);
	child_GetPrivateDataMetadataByHash2846?0;
	stop_process: skip;
	child!0
}
proctype ApplyPrivacyAwareUpdates255(Mutexdef s_metadataHint_bookkeeper_db_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_setMetadataUsedFlag360 = [1] of {int};
	run setMetadataUsedFlag36(s_metadataHint_bookkeeper_db_mutex,child_setMetadataUsedFlag360);
	child_setMetadataUsedFlag360?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype setMetadataUsedFlag36(Mutexdef h_bookkeeper_db_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_filterNamespacesThatHasMetadata = -2; // opt var_filterNamespacesThatHasMetadata
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetStateMetadata271(Mutexdef s_metadataHint_bookkeeper_db_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_metadataEverUsedFor321 = [1] of {int};
	run metadataEverUsedFor32(s_metadataHint_bookkeeper_db_mutex,child_metadataEverUsedFor321);
	child_metadataEverUsedFor321?0;
	

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
proctype metadataEverUsedFor32(Mutexdef h_bookkeeper_db_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetPrivateDataMetadataByHash284(Mutexdef s_metadataHint_bookkeeper_db_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetValueHash2015 = [1] of {int};
	chan child_metadataEverUsedFor324 = [1] of {int};
	run metadataEverUsedFor32(s_metadataHint_bookkeeper_db_mutex,child_metadataEverUsedFor324);
	child_metadataEverUsedFor324?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run GetValueHash201(s_metadataHint_bookkeeper_db_mutex,child_GetValueHash2015);
	child_GetValueHash2015?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetValueHash201(Mutexdef s_metadataHint_bookkeeper_db_mutex;chan child) {
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

