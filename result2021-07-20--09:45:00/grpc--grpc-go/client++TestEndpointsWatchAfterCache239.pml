// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/grpc/grpc-go/blob/ebd6aba6754d073a696e5727158cd0c917ce1019/xds/internal/client/watchers_endpoints_test.go#L239
#define not_found_266  -2 // opt updates line 237
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEndpointsWatchAfterCache2390 = [1] of {int};
	run TestEndpointsWatchAfterCache239(child_TestEndpointsWatchAfterCache2390);
	run receiver(child_TestEndpointsWatchAfterCache2390)
stop_process:skip
}

proctype TestEndpointsWatchAfterCache239(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close6210 = [1] of {int};
	chan child_WatchEndpoints2873 = [1] of {int};
	chan child_NewEndpoints2372 = [1] of {int};
	chan child_WatchEndpoints2871 = [1] of {int};
	Mutexdef client_lrsMu;
	Mutexdef client_mu;
	Mutexdef client_updateCh_mu;
	Mutexdef client_cc_lceMu;
	Mutexdef client_cc_mu;
	run mutexMonitor(client_cc_mu);
	run mutexMonitor(client_cc_lceMu);
	run mutexMonitor(client_updateCh_mu);
	run mutexMonitor(client_mu);
	run mutexMonitor(client_lrsMu);
	run WatchEndpoints287(client_cc_lceMu,client_cc_mu,client_lrsMu,client_mu,client_updateCh_mu,child_WatchEndpoints2871);
	child_WatchEndpoints2871?0;
	run NewEndpoints237(client_cc_lceMu,client_cc_mu,client_lrsMu,client_mu,client_updateCh_mu,not_found_266,child_NewEndpoints2372);
	child_NewEndpoints2372?0;
	run WatchEndpoints287(client_cc_lceMu,client_cc_mu,client_lrsMu,client_mu,client_updateCh_mu,child_WatchEndpoints2873);
	child_WatchEndpoints2873?0;
		defer1: skip;
	run Close621(client_cc_lceMu,client_cc_mu,client_lrsMu,client_mu,client_updateCh_mu,child_Close6210);
	child_Close6210?0;
	stop_process: skip;
	child!0
}
proctype Close621(Mutexdef c_cc_lceMu;Mutexdef c_cc_mu;Mutexdef c_lrsMu;Mutexdef c_mu;Mutexdef c_updateCh_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close6210 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Close621(c_cc_lceMu,c_cc_mu,child_Close6210);
	child_Close6210?0;
	stop_process: skip;
	child!0
}
proctype WatchEndpoints287(Mutexdef c_cc_lceMu;Mutexdef c_cc_mu;Mutexdef c_lrsMu;Mutexdef c_mu;Mutexdef c_updateCh_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_watch1161 = [1] of {int};
	Mutexdef wi_mu;
	Mutexdef wi_c_lrsMu;
	Mutexdef wi_c_mu;
	run mutexMonitor(wi_c_mu);
	run mutexMonitor(wi_c_lrsMu);
	run mutexMonitor(wi_mu);
	run watch116(c_cc_lceMu,c_cc_mu,c_lrsMu,c_mu,c_updateCh_mu,wi_c_lrsMu,wi_c_mu,wi_mu,child_watch1161);
	child_watch1161?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype watch116(Mutexdef c_cc_lceMu;Mutexdef c_cc_mu;Mutexdef c_lrsMu;Mutexdef c_mu;Mutexdef c_updateCh_mu;Mutexdef wi_c_lrsMu;Mutexdef wi_c_mu;Mutexdef wi_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newUpdate561 = [1] of {int};
	chan child_newUpdate562 = [1] of {int};
	chan child_newUpdate563 = [1] of {int};
	chan child_newUpdate564 = [1] of {int};
	c_mu.Lock!false;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
		goto defer1
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run newUpdate56(wi_c_lrsMu,wi_c_mu,wi_mu,child_newUpdate561);
			child_newUpdate561?0
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			run newUpdate56(wi_c_lrsMu,wi_c_mu,wi_mu,child_newUpdate562);
			child_newUpdate562?0
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			run newUpdate56(wi_c_lrsMu,wi_c_mu,wi_mu,child_newUpdate563);
			child_newUpdate563?0
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			run newUpdate56(wi_c_lrsMu,wi_c_mu,wi_mu,child_newUpdate564);
			child_newUpdate564?0
		:: true;
		fi
	fi;
	goto defer1;
		defer1: skip;
	c_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype newUpdate56(Mutexdef wi_c_lrsMu;Mutexdef wi_c_mu;Mutexdef wi_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_scheduleCallback291 = [1] of {int};
	wi_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run scheduleCallback29(wi_c_lrsMu,wi_c_mu,wi_c_lrsMu,wi_c_mu,wi_mu,child_scheduleCallback291);
	child_scheduleCallback291?0;
		defer1: skip;
	wi_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype scheduleCallback29(Mutexdef c_lrsMu;Mutexdef c_mu;Mutexdef wi_c_lrsMu;Mutexdef wi_c_mu;Mutexdef wi_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype NewEndpoints237(Mutexdef c_cc_lceMu;Mutexdef c_cc_mu;Mutexdef c_lrsMu;Mutexdef c_mu;Mutexdef c_updateCh_mu;int updates;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_ss = -2; // opt var_ss
	c_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
		defer1: skip;
	c_mu.Unlock!false;
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

