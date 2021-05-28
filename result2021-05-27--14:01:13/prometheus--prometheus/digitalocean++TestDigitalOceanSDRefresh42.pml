// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/prometheus/prometheus/blob/27b78c336e436e9eed8b55ab0b162b888ec641d8/discovery/digitalocean/digitalocean_test.go#L42
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDigitalOceanSDRefresh420 = [1] of {int};
	run TestDigitalOceanSDRefresh42(child_TestDigitalOceanSDRefresh420);
	run receiver(child_TestDigitalOceanSDRefresh420)
stop_process:skip
}

proctype TestDigitalOceanSDRefresh42(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_refresh1360 = [1] of {int};
	Mutexdef d_client_ratemtx;
	run mutexMonitor(d_client_ratemtx);
	run refresh136(d_client_ratemtx,child_refresh1360);
	child_refresh1360?0;
	stop_process: skip;
	child!0
}
proctype refresh136(Mutexdef d_client_ratemtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_listDroplets1990 = [1] of {int};
	int droplets = -2; // opt droplets
	run listDroplets199(d_client_ratemtx,child_listDroplets1990);
	child_listDroplets1990?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype listDroplets199(Mutexdef d_client_ratemtx;chan child) {
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

