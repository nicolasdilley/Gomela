// num_comm_params=7
// num_mand_comm_params=0
// num_opt_comm_params=7

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/eth/filters/filter_test.go#L98
#define not_found_171  -2 // opt addresses line 66
#define not_found_178  -2 // opt addresses line 66
#define not_found_187  -2 // opt addresses line 66
#define not_found_196  -2 // opt addresses line 66
#define not_found_204  -2 // opt addresses line 66
#define not_found_212  -2 // opt addresses line 66
#define not_found_219  -2 // opt addresses line 66
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFilters980 = [1] of {int};
	run TestFilters98(child_TestFilters980);
	run receiver(child_TestFilters980)
stop_process:skip
}

proctype TestFilters98(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewRangeFilter666 = [1] of {int};
	chan child_NewRangeFilter665 = [1] of {int};
	chan child_NewRangeFilter664 = [1] of {int};
	chan child_NewRangeFilter663 = [1] of {int};
	chan child_NewRangeFilter662 = [1] of {int};
	chan child_NewRangeFilter661 = [1] of {int};
	chan child_NewRangeFilter660 = [1] of {int};
	Mutexdef backend_chainFeed_mu;
	Mutexdef backend_pendingLogsFeed_mu;
	Mutexdef backend_rmLogsFeed_mu;
	Mutexdef backend_logsFeed_mu;
	Mutexdef backend_txFeed_mu;
	Mutexdef backend_mux_mutex;
	int var_chainchain = -2; // opt var_chainchain
	run mutexMonitor(backend_mux_mutex);
	run mutexMonitor(backend_txFeed_mu);
	run mutexMonitor(backend_logsFeed_mu);
	run mutexMonitor(backend_rmLogsFeed_mu);
	run mutexMonitor(backend_pendingLogsFeed_mu);
	run mutexMonitor(backend_chainFeed_mu);
	run NewRangeFilter66(backend_chainFeed_mu,backend_logsFeed_mu,backend_mux_mutex,backend_pendingLogsFeed_mu,backend_rmLogsFeed_mu,backend_txFeed_mu,not_found_171,not_found_171,child_NewRangeFilter660);
	child_NewRangeFilter660?0;
	run NewRangeFilter66(backend_chainFeed_mu,backend_logsFeed_mu,backend_mux_mutex,backend_pendingLogsFeed_mu,backend_rmLogsFeed_mu,backend_txFeed_mu,not_found_178,not_found_178,child_NewRangeFilter661);
	child_NewRangeFilter661?0;
	run NewRangeFilter66(backend_chainFeed_mu,backend_logsFeed_mu,backend_mux_mutex,backend_pendingLogsFeed_mu,backend_rmLogsFeed_mu,backend_txFeed_mu,not_found_187,not_found_187,child_NewRangeFilter662);
	child_NewRangeFilter662?0;
	run NewRangeFilter66(backend_chainFeed_mu,backend_logsFeed_mu,backend_mux_mutex,backend_pendingLogsFeed_mu,backend_rmLogsFeed_mu,backend_txFeed_mu,not_found_196,not_found_196,child_NewRangeFilter663);
	child_NewRangeFilter663?0;
	run NewRangeFilter66(backend_chainFeed_mu,backend_logsFeed_mu,backend_mux_mutex,backend_pendingLogsFeed_mu,backend_rmLogsFeed_mu,backend_txFeed_mu,not_found_204,not_found_204,child_NewRangeFilter664);
	child_NewRangeFilter664?0;
	run NewRangeFilter66(backend_chainFeed_mu,backend_logsFeed_mu,backend_mux_mutex,backend_pendingLogsFeed_mu,backend_rmLogsFeed_mu,backend_txFeed_mu,not_found_212,not_found_212,child_NewRangeFilter665);
	child_NewRangeFilter665?0;
	run NewRangeFilter66(backend_chainFeed_mu,backend_logsFeed_mu,backend_mux_mutex,backend_pendingLogsFeed_mu,backend_rmLogsFeed_mu,backend_txFeed_mu,not_found_219,not_found_219,child_NewRangeFilter666);
	child_NewRangeFilter666?0;
	stop_process: skip;
	child!0
}
proctype NewRangeFilter66(Mutexdef backend_chainFeed_mu;Mutexdef backend_logsFeed_mu;Mutexdef backend_mux_mutex;Mutexdef backend_pendingLogsFeed_mu;Mutexdef backend_rmLogsFeed_mu;Mutexdef backend_txFeed_mu;int addresses;int topics;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newFilter1081 = [1] of {int};
	chan child_BloomStatus1290 = [1] of {int};
	int var_topicListtopicList = -2; // opt var_topicListtopicList
	run BloomStatus129(backend_chainFeed_mu,backend_logsFeed_mu,backend_mux_mutex,backend_pendingLogsFeed_mu,backend_rmLogsFeed_mu,backend_txFeed_mu,child_BloomStatus1290);
	child_BloomStatus1290?0;
	run newFilter108(backend_chainFeed_mu,backend_logsFeed_mu,backend_mux_mutex,backend_pendingLogsFeed_mu,backend_rmLogsFeed_mu,backend_txFeed_mu,child_newFilter1081);
	child_newFilter1081?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype BloomStatus129(Mutexdef b_chainFeed_mu;Mutexdef b_logsFeed_mu;Mutexdef b_mux_mutex;Mutexdef b_pendingLogsFeed_mu;Mutexdef b_rmLogsFeed_mu;Mutexdef b_txFeed_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newFilter108(Mutexdef backend_chainFeed_mu;Mutexdef backend_logsFeed_mu;Mutexdef backend_mux_mutex;Mutexdef backend_pendingLogsFeed_mu;Mutexdef backend_rmLogsFeed_mu;Mutexdef backend_txFeed_mu;chan child) {
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

