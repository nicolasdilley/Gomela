// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vttablet/tabletserver/query_list_test.go#L45
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestQueryList450 = [1] of {int};
	run TestQueryList45(child_TestQueryList450);
	run receiver(child_TestQueryList450)
stop_process:skip
}

proctype TestQueryList45(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Remove753 = [1] of {int};
	chan child_AppendQueryzRows1212 = [1] of {int};
	chan child_Add681 = [1] of {int};
	chan child_Add680 = [1] of {int};
	Mutexdef ql_mu;
	run mutexMonitor(ql_mu);
	run Add68(ql_mu,child_Add680);
	child_Add680?0;
	run Add68(ql_mu,child_Add681);
	child_Add681?0;
	run AppendQueryzRows121(ql_mu,child_AppendQueryzRows1212);
	child_AppendQueryzRows1212?0;
	run Remove75(ql_mu,child_Remove753);
	child_Remove753?0;
	stop_process: skip;
	child!0
}
proctype Add68(Mutexdef ql_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ql_mu.Lock!false;
		defer1: skip;
	ql_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype AppendQueryzRows121(Mutexdef ql_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_ql_queryDetails = -2; // opt var_ql_queryDetails
	ql_mu.Lock!false;
	ql_mu.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Remove75(Mutexdef ql_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ql_mu.Lock!false;
		defer1: skip;
	ql_mu.Unlock!false;
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

