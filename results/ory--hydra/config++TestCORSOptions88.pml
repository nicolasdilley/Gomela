// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ory/hydra/blob//driver/config/provider_test.go#L88
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCORSOptions880 = [1] of {int};
	run TestCORSOptions88(child_TestCORSOptions880);
	run receiver(child_TestCORSOptions880)
stop_process:skip
}

proctype TestCORSOptions88(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CORS621 = [1] of {int};
	chan child_MustSet1080 = [1] of {int};
	Mutexdef p_p_l;
	run mutexMonitor(p_p_l);
	run MustSet108(p_p_l,child_MustSet1080);
	child_MustSet1080?0;
	run CORS62(p_p_l,child_CORS621);
	child_CORS621?0;
	stop_process: skip;
	child!0
}
proctype MustSet108(Mutexdef p_p_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Set1040 = [1] of {int};
	run Set104(p_p_l,child_Set1040);
	child_Set1040?0;
	stop_process: skip;
	child!0
}
proctype Set104(Mutexdef p_p_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype CORS62(Mutexdef p_p_l;chan child) {
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

