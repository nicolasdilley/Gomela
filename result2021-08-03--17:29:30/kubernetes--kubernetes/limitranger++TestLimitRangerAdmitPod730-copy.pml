// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/plugin/pkg/admission/limitranger/admission_test.go#L730
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLimitRangerAdmitPod7300 = [1] of {int};
	run TestLimitRangerAdmitPod730(child_TestLimitRangerAdmitPod7300);
	run receiver(child_TestLimitRangerAdmitPod7300)
stop_process:skip
}

proctype TestLimitRangerAdmitPod730(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Validate1113 = [1] of {int};
	chan child_Validate1112 = [1] of {int};
	chan child_Validate1111 = [1] of {int};
	chan child_Validate1110 = [1] of {int};
	Mutexdef handler_liveLookupCache_lock;
	run mutexMonitor(handler_liveLookupCache_lock);
	run Validate111(handler_liveLookupCache_lock,child_Validate1110);
	child_Validate1110?0;
	run Validate111(handler_liveLookupCache_lock,child_Validate1111);
	child_Validate1111?0;
	run Validate111(handler_liveLookupCache_lock,child_Validate1112);
	child_Validate1112?0;
	run Validate111(handler_liveLookupCache_lock,child_Validate1113);
	child_Validate1113?0;
	stop_process: skip;
	child!0
}
proctype Validate111(Mutexdef l_liveLookupCache_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runLimitFunc1150 = [1] of {int};
	run runLimitFunc115(l_liveLookupCache_lock,child_runLimitFunc1150);
	child_runLimitFunc1150?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype runLimitFunc115(Mutexdef l_liveLookupCache_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetLimitRanges1550 = [1] of {int};
	int var_items = -2; // opt var_items
	

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
		fi
	:: true;
	fi;
	run GetLimitRanges155(l_liveLookupCache_lock,child_GetLimitRanges1550);
	child_GetLimitRanges1550?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetLimitRanges155(Mutexdef l_liveLookupCache_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_lruEntry_items = -2; // opt var_lruEntry_items
	int var_liveList_Items = -2; // opt var_liveList_Items
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
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

proctype receiver(chan c) {
c?0
}

