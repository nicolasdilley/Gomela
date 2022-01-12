// num_comm_params=3
// num_mand_comm_params=0
// num_opt_comm_params=3

// git_link=https://github.com/hyperledger/fabric/blob//gossip/privdata/reconcile_test.go#L435
#define def_var_missingPvtDataInfo  -2 // opt missingPvtDataInfo line 193
#define def_var_elements  -2 // opt elements line 294
#define def_var_pvtdataHashMismatch  -2 // opt pvtdataMismatched line 284
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestReconciliationFailedToCommit4350 = [1] of {int};
	run TestReconciliationFailedToCommit435(child_TestReconciliationFailedToCommit4350);
	run receiver(child_TestReconciliationFailedToCommit4350)
stop_process:skip
}

proctype TestReconciliationFailedToCommit435(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_reconcile1280 = [1] of {int};
	Mutexdef r_stopOnce_m;
	Mutexdef r_startOnce_m;
	int var_dig2CollectionConfig = -2; // opt var_dig2CollectionConfig
	run mutexMonitor(r_startOnce_m);
	run mutexMonitor(r_stopOnce_m);
	run reconcile128(r_startOnce_m,r_stopOnce_m,child_reconcile1280);
	child_reconcile1280?0;
	stop_process: skip;
	child!0
}
proctype reconcile128(Mutexdef r_startOnce_m;Mutexdef r_stopOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_reportReconciliationDuration1840 = [1] of {int};
	chan child_logMismatched2843 = [1] of {int};
	int var_pvtdataHashMismatch = def_var_pvtdataHashMismatch;
	chan child_preparePvtDataToCommit2602 = [1] of {int};
	chan child_getDig2CollectionConfig1931 = [1] of {int};
	int var_missingPvtDataInfo = def_var_missingPvtDataInfo;
	

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
	do
	:: true -> 
		for10: skip;
		

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
		run getDig2CollectionConfig193(r_startOnce_m,r_stopOnce_m,var_missingPvtDataInfo,child_getDig2CollectionConfig1931);
		child_getDig2CollectionConfig1931?0;
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi;
		run preparePvtDataToCommit260(r_startOnce_m,r_stopOnce_m,child_preparePvtDataToCommit2602);
		child_preparePvtDataToCommit2602?0;
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi;
		run logMismatched284(r_startOnce_m,r_stopOnce_m,var_pvtdataHashMismatch,child_logMismatched2843);
		child_logMismatched2843?0;
		for10_end: skip
	od;
	for10_exit: skip;
		defer1: skip;
	run reportReconciliationDuration184(r_startOnce_m,r_stopOnce_m,child_reportReconciliationDuration1840);
	child_reportReconciliationDuration1840?0;
	stop_process: skip;
	child!0
}
proctype reportReconciliationDuration184(Mutexdef r_startOnce_m;Mutexdef r_stopOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype getDig2CollectionConfig193(Mutexdef r_startOnce_m;Mutexdef r_stopOnce_m;int var_missingPvtDataInfo;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getMostRecentCollectionConfig2341 = [1] of {int};
	chan child_getMostRecentCollectionConfig2342 = [1] of {int};
	chan child_getMostRecentCollectionConfig2343 = [1] of {int};
	chan child_getMostRecentCollectionConfig2344 = [1] of {int};
	chan child_getMostRecentCollectionConfig2345 = [1] of {int};
	chan child_getMostRecentCollectionConfig2346 = [1] of {int};
	chan child_getMostRecentCollectionConfig2347 = [1] of {int};
	chan child_getMostRecentCollectionConfig2348 = [1] of {int};
	int var_collectionPvtDataInfo = -2; // opt var_collectionPvtDataInfo
	int var_blockPvtDataInfo = -2; // opt var_blockPvtDataInfo
	

	if
	:: var_missingPvtDataInfo-1 != -3 -> 
				for(i : 0.. var_missingPvtDataInfo-1) {
			for11: skip;
			

			if
			:: var_blockPvtDataInfo-1 != -3 -> 
								for(i : 0.. var_blockPvtDataInfo-1) {
					for12: skip;
					

					if
					:: var_collectionPvtDataInfo-1 != -3 -> 
												for(i : 0.. var_collectionPvtDataInfo-1) {
							for13: skip;
							

							if
							:: true -> 
								run getMostRecentCollectionConfig234(r_startOnce_m,r_stopOnce_m,child_getMostRecentCollectionConfig2341);
								child_getMostRecentCollectionConfig2341?0;
								

								if
								:: true -> 
									goto for13_end
								:: true;
								fi
							:: true;
							fi;
							for13_end: skip
						};
						for13_exit: skip
					:: else -> 
						do
						:: true -> 
							for14: skip;
							

							if
							:: true -> 
								run getMostRecentCollectionConfig234(r_startOnce_m,r_stopOnce_m,child_getMostRecentCollectionConfig2342);
								child_getMostRecentCollectionConfig2342?0;
								

								if
								:: true -> 
									goto for14_end
								:: true;
								fi
							:: true;
							fi;
							for14_end: skip
						:: true -> 
							break
						od;
						for14_exit: skip
					fi;
					for12_end: skip
				};
				for12_exit: skip
			:: else -> 
				do
				:: true -> 
					for15: skip;
					

					if
					:: var_collectionPvtDataInfo-1 != -3 -> 
												for(i : 0.. var_collectionPvtDataInfo-1) {
							for16: skip;
							

							if
							:: true -> 
								run getMostRecentCollectionConfig234(r_startOnce_m,r_stopOnce_m,child_getMostRecentCollectionConfig2343);
								child_getMostRecentCollectionConfig2343?0;
								

								if
								:: true -> 
									goto for16_end
								:: true;
								fi
							:: true;
							fi;
							for16_end: skip
						};
						for16_exit: skip
					:: else -> 
						do
						:: true -> 
							for17: skip;
							

							if
							:: true -> 
								run getMostRecentCollectionConfig234(r_startOnce_m,r_stopOnce_m,child_getMostRecentCollectionConfig2344);
								child_getMostRecentCollectionConfig2344?0;
								

								if
								:: true -> 
									goto for17_end
								:: true;
								fi
							:: true;
							fi;
							for17_end: skip
						:: true -> 
							break
						od;
						for17_exit: skip
					fi;
					for15_end: skip
				:: true -> 
					break
				od;
				for15_exit: skip
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for18: skip;
			

			if
			:: var_blockPvtDataInfo-1 != -3 -> 
								for(i : 0.. var_blockPvtDataInfo-1) {
					for19: skip;
					

					if
					:: var_collectionPvtDataInfo-1 != -3 -> 
												for(i : 0.. var_collectionPvtDataInfo-1) {
							for110: skip;
							

							if
							:: true -> 
								run getMostRecentCollectionConfig234(r_startOnce_m,r_stopOnce_m,child_getMostRecentCollectionConfig2345);
								child_getMostRecentCollectionConfig2345?0;
								

								if
								:: true -> 
									goto for110_end
								:: true;
								fi
							:: true;
							fi;
							for110_end: skip
						};
						for110_exit: skip
					:: else -> 
						do
						:: true -> 
							for111: skip;
							

							if
							:: true -> 
								run getMostRecentCollectionConfig234(r_startOnce_m,r_stopOnce_m,child_getMostRecentCollectionConfig2346);
								child_getMostRecentCollectionConfig2346?0;
								

								if
								:: true -> 
									goto for111_end
								:: true;
								fi
							:: true;
							fi;
							for111_end: skip
						:: true -> 
							break
						od;
						for111_exit: skip
					fi;
					for19_end: skip
				};
				for19_exit: skip
			:: else -> 
				do
				:: true -> 
					for112: skip;
					

					if
					:: var_collectionPvtDataInfo-1 != -3 -> 
												for(i : 0.. var_collectionPvtDataInfo-1) {
							for113: skip;
							

							if
							:: true -> 
								run getMostRecentCollectionConfig234(r_startOnce_m,r_stopOnce_m,child_getMostRecentCollectionConfig2347);
								child_getMostRecentCollectionConfig2347?0;
								

								if
								:: true -> 
									goto for113_end
								:: true;
								fi
							:: true;
							fi;
							for113_end: skip
						};
						for113_exit: skip
					:: else -> 
						do
						:: true -> 
							for114: skip;
							

							if
							:: true -> 
								run getMostRecentCollectionConfig234(r_startOnce_m,r_stopOnce_m,child_getMostRecentCollectionConfig2348);
								child_getMostRecentCollectionConfig2348?0;
								

								if
								:: true -> 
									goto for114_end
								:: true;
								fi
							:: true;
							fi;
							for114_end: skip
						:: true -> 
							break
						od;
						for114_exit: skip
					fi;
					for112_end: skip
				:: true -> 
					break
				od;
				for112_exit: skip
			fi;
			for18_end: skip
		:: true -> 
			break
		od;
		for18_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getMostRecentCollectionConfig234(Mutexdef r_startOnce_m;Mutexdef r_stopOnce_m;chan child) {
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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype preparePvtDataToCommit260(Mutexdef r_startOnce_m;Mutexdef r_stopOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_groupRwsetByBlock2942 = [1] of {int};
	int var_elements = def_var_elements;
	int var_rwSetKeys_bySeqsInBlock = -2; // opt var_rwSetKeys_bySeqsInBlock
	int var_rwSetByBlockByKeys = -2; // opt var_rwSetByBlockByKeys
	run groupRwsetByBlock294(r_startOnce_m,r_stopOnce_m,var_elements,child_groupRwsetByBlock2942);
	child_groupRwsetByBlock2942?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype groupRwsetByBlock294(Mutexdef r_startOnce_m;Mutexdef r_stopOnce_m;int var_elements;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_element_Payload = -2; // opt var_element_Payload
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype logMismatched284(Mutexdef r_startOnce_m;Mutexdef r_stopOnce_m;int var_pvtdataMismatched;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

