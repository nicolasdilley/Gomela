// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ipfs/go-ipfs/blob//repo/fsrepo/migrations/ipfsfetcher/ipfsfetcher_test.go#L22
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestIpfsFetcher220 = [1] of {int};
	run TestIpfsFetcher22(child_TestIpfsFetcher220);
	run receiver(child_TestIpfsFetcher220)
stop_process:skip
}

proctype TestIpfsFetcher22(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close1320 = [1] of {int};
	chan child_Fetch902 = [1] of {int};
	chan child_Fetch901 = [1] of {int};
	Mutexdef fetcher_mutex;
	Mutexdef fetcher_closeOnce_m;
	Mutexdef fetcher_openOnce_m;
	run mutexMonitor(fetcher_openOnce_m);
	run mutexMonitor(fetcher_closeOnce_m);
	run mutexMonitor(fetcher_mutex);
	run Fetch90(fetcher_closeOnce_m,fetcher_mutex,fetcher_openOnce_m,child_Fetch901);
	child_Fetch901?0;
	run Fetch90(fetcher_closeOnce_m,fetcher_mutex,fetcher_openOnce_m,child_Fetch902);
	child_Fetch902?0;
		defer1: skip;
	run Close132(fetcher_closeOnce_m,fetcher_mutex,fetcher_openOnce_m,child_Close1320);
	child_Close1320?0;
	stop_process: skip;
	child!0
}
proctype Close132(Mutexdef f_closeOnce_m;Mutexdef f_mutex;Mutexdef f_openOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Fetch90(Mutexdef f_closeOnce_m;Mutexdef f_mutex;Mutexdef f_openOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_recordFetched1581 = [1] of {int};
	

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
	run recordFetched158(f_closeOnce_m,f_mutex,f_openOnce_m,child_recordFetched1581);
	child_recordFetched1581?0;
	

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
proctype recordFetched158(Mutexdef f_closeOnce_m;Mutexdef f_mutex;Mutexdef f_openOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	f_mutex.Lock!false;
		defer1: skip;
	f_mutex.Unlock!false;
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

