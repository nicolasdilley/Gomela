// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/rpc/server_test.go#L576
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_countMallocs5760 = [1] of {int};
	run countMallocs576(child_countMallocs5760);
	run receiver(child_countMallocs5760)
stop_process:skip
}

proctype countMallocs576(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close2830 = [1] of {int};
	Mutexdef client_mutex;
	Mutexdef client_reqMutex;
	run mutexMonitor(client_reqMutex);
	run mutexMonitor(client_mutex);
	goto defer1;
		defer1: skip;
	run Close283(client_mutex,client_reqMutex,child_Close2830);
	child_Close2830?0;
	stop_process: skip;
	child!0
}
proctype Close283(Mutexdef client_mutex;Mutexdef client_reqMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	client_mutex.Lock!false;
	

	if
	:: true -> 
		client_mutex.Unlock!false;
		goto stop_process
	:: true;
	fi;
	client_mutex.Unlock!false;
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

