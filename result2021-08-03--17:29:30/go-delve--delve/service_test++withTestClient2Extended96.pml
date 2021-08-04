// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-delve/delve/blob/9ed4ba0c49d916bf128ecf69fcc109235aeed075/service/test/integration2_test.go#L96
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_withTestClient2Extended960 = [1] of {int};
	run withTestClient2Extended96(child_withTestClient2Extended960);
	run receiver(child_withTestClient2Extended960)
stop_process:skip
}

proctype withTestClient2Extended96(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Detach570 = [1] of {int};
	Mutexdef client_client_mutex;
	Mutexdef client_client_reqMutex;
	run mutexMonitor(client_client_reqMutex);
	run mutexMonitor(client_client_mutex);
		defer1: skip;
	run Detach57(client_client_mutex,client_client_reqMutex,child_Detach570);
	child_Detach570?0;
	stop_process: skip;
	child!0
}
proctype Detach57(Mutexdef c_client_mutex;Mutexdef c_client_reqMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_call4870 = [1] of {int};
	run call487(c_client_mutex,c_client_reqMutex,child_call4870);
	child_call4870?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype call487(Mutexdef c_client_mutex;Mutexdef c_client_reqMutex;chan child) {
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

