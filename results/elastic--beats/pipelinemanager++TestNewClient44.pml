// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//x-pack/dockerlogbeat/pipelinemanager/clientLogReader_test.go#L44
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNewClient440 = [1] of {int};
	run TestNewClient44(child_TestNewClient440);
	run receiver(child_TestNewClient440)
stop_process:skip
}

proctype TestNewClient44(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_testReturn1030 = [1] of {int};
	Mutexdef client_mtx;
	run mutexMonitor(client_mtx);
	run testReturn103(client_mtx,child_testReturn1030);
	child_testReturn1030?0;
	stop_process: skip;
	child!0
}
proctype testReturn103(Mutexdef conn_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetAllEvents630 = [1] of {int};
	do
	:: true -> 
		for10: skip;
		run GetAllEvents63(conn_mtx,child_GetAllEvents630);
		child_GetAllEvents630?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype GetAllEvents63(Mutexdef pc_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_pc_clients = -2; // opt var_pc_clients
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

