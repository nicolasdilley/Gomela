// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//log/syslog/syslog.go#L313
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewLogger3130 = [1] of {int};
	run NewLogger313(child_NewLogger3130);
	run receiver(child_NewLogger3130)
stop_process:skip
}

proctype NewLogger313(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_New650 = [1] of {int};
	Mutexdef s_mu;
	run mutexMonitor(s_mu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run New65(s_mu,child_New650);
	child_New650?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype New65(Mutexdef out_mu;chan child) {
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

