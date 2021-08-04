// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/moby/moby/blob/5a82cee6d499e51bc903a743e4f0f205adb161a9/daemon/logger/splunk/splunk_test.go#L949
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestOneMessagePerRequest9490 = [1] of {int};
	run TestOneMessagePerRequest949(child_TestOneMessagePerRequest9490);
	run receiver(child_TestOneMessagePerRequest9490)
stop_process:skip
}

proctype TestOneMessagePerRequest949(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close821 = [1] of {int};
	chan child_Serve780 = [1] of {int};
	Mutexdef hec_mu;
	int var_hec_messages = -2; // opt var_hec_messages
	run mutexMonitor(hec_mu);
	run Serve78(hec_mu,child_Serve780);
	run receiver(child_Serve780);
	run Close82(hec_mu,child_Close821);
	child_Close821?0;
	stop_process: skip;
	child!0
}
proctype Serve78(Mutexdef hec_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Close82(Mutexdef hec_mu;chan child) {
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

