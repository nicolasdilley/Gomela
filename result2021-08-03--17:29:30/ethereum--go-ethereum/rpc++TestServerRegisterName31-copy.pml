// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/rpc/server_test.go#L31
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestServerRegisterName310 = [1] of {int};
	run TestServerRegisterName31(child_TestServerRegisterName310);
	run receiver(child_TestServerRegisterName310)
stop_process:skip
}

proctype TestServerRegisterName31(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RegisterName650 = [1] of {int};
	Mutexdef server_services_mu;
	run mutexMonitor(server_services_mu);
	run RegisterName65(server_services_mu,child_RegisterName650);
	child_RegisterName650?0;
	stop_process: skip;
	child!0
}
proctype RegisterName65(Mutexdef s_services_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_registerName610 = [1] of {int};
	run registerName61(s_services_mu,child_registerName610);
	child_registerName610?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype registerName61(Mutexdef r_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_callbacks = -2; // opt var_callbacks
	

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
	r_mu.Lock!false;
	goto defer1;
		defer1: skip;
	r_mu.Unlock!false;
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

