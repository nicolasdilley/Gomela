// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtctl/fakevtctlclient/fake_loggerevent_streamingclient_test.go#L118
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNoResultRegistered1180 = [1] of {int};
	run TestNoResultRegistered118(child_TestNoResultRegistered1180);
	run receiver(child_TestNoResultRegistered1180)
stop_process:skip
}

proctype TestNoResultRegistered118(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_StreamResult1310 = [1] of {int};
	Mutexdef fake_mu;
	run mutexMonitor(fake_mu);
	run StreamResult131(fake_mu,child_StreamResult1310);
	child_StreamResult1310?0;
	stop_process: skip;
	child!0
}
proctype StreamResult131(Mutexdef f_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	f_mu.Lock!false;
	

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
	f_mu.Unlock!false;
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

