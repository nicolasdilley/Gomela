
// https://github.com/hashicorp/terraform/blob/master/plugin/ui_output_test.go#L14
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUIOutput_input140 = [1] of {int};
	run TestUIOutput_input14(child_TestUIOutput_input140)
stop_process:skip
}

proctype TestUIOutput_input14(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close5840 = [1] of {int};
	chan child_Output151 = [1] of {int};
	Mutexdef output_Client_mutex;
	Mutexdef output_Client_reqMutex;
	Mutexdef server_respLock;
	Mutexdef server_reqLock;
	Mutexdef server_serviceMap_mu;
	Mutexdef client_mutex;
	Mutexdef client_reqMutex;
	run mutexMonitor(client_reqMutex);
	run mutexMonitor(client_mutex);
	run mutexMonitor(server_serviceMap_mu);
	run mutexMonitor(server_reqLock);
	run mutexMonitor(server_respLock);
	run mutexMonitor(output_Client_reqMutex);
	run mutexMonitor(output_Client_mutex);
	run Output15(output_Client_reqMutex,output_Client_mutex,child_Output151);
	child_Output151?0;
	stop_process: skip;
		run Close584(client_reqMutex,client_mutex,child_Close5840);
	child_Close5840?0;
	child!0
}
proctype Close584(Mutexdef p_reqMutex;Mutexdef p_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Output15(Mutexdef o_Client_reqMutex;Mutexdef o_Client_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

