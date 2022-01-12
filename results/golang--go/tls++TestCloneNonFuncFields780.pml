// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//crypto/tls/tls_test.go#L780
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCloneNonFuncFields7800 = [1] of {int};
	run TestCloneNonFuncFields780(child_TestCloneNonFuncFields7800);
	run receiver(child_TestCloneNonFuncFields7800)
stop_process:skip
}

proctype TestCloneNonFuncFields780(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DeepEqual2091 = [1] of {int};
	chan child_Clone7680 = [1] of {int};
	Mutexdef c2_mutex;
	Mutexdef c1_mutex;
	int var_typ_NumField = -2; // opt var_typ_NumField
	run mutexMonitor(c1_mutex);
	run mutexMonitor(c2_mutex);
	run Clone768(c1_mutex,child_Clone7680);
	child_Clone7680?0;
	run DeepEqual209(c2_mutex,child_DeepEqual2091);
	child_DeepEqual2091?0;
	stop_process: skip;
	child!0
}
proctype Clone768(Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	c_mutex.RLock!false;
	goto defer1;
		defer1: skip;
	c_mutex.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype DeepEqual209(Mutexdef y_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ValueOf26641 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run ValueOf2664(y_mutex,child_ValueOf26641);
	child_ValueOf26641?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ValueOf2664(Mutexdef i_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_unpackEface1442 = [1] of {int};
	chan child_escapes32001 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run escapes3200(i_mutex,child_escapes32001);
	child_escapes32001?0;
	run unpackEface144(i_mutex,child_unpackEface1442);
	child_unpackEface1442?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype escapes3200(Mutexdef x_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype unpackEface144(Mutexdef i_mutex;chan child) {
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

