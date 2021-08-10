// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-delve/delve/blob/9ed4ba0c49d916bf128ecf69fcc109235aeed075/service/test/integration2_test.go#L2018
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUnknownMethodCall20180 = [1] of {int};
	run TestUnknownMethodCall2018(child_TestUnknownMethodCall20180);
	run receiver(child_TestUnknownMethodCall20180)
stop_process:skip
}

proctype TestUnknownMethodCall2018(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Detach20081 = [1] of {int};
	chan child_call20142 = [1] of {int};
	chan child_call20140 = [1] of {int};
	Mutexdef client_client_mutex;
	Mutexdef client_client_reqMutex;
	run mutexMonitor(client_client_reqMutex);
	run mutexMonitor(client_client_mutex);
	run call2014(client_client_mutex,client_client_reqMutex,child_call20140);
	child_call20140?0;
	run call2014(client_client_mutex,client_client_reqMutex,child_call20142);
	child_call20142?0;
		defer1: skip;
	run Detach2008(client_client_mutex,client_client_reqMutex,child_Detach20081);
	child_Detach20081?0;
	stop_process: skip;
	child!0
}
proctype call2014(Mutexdef c_client_mutex;Mutexdef c_client_reqMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Detach2008(Mutexdef c_client_mutex;Mutexdef c_client_reqMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_call20141 = [1] of {int};
	run call2014(c_client_mutex,c_client_reqMutex,child_call20141);
	child_call20141?0;
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

