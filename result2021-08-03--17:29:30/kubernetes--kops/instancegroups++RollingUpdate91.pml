// num_comm_params=2
// num_mand_comm_params=1
// num_opt_comm_params=1

// git_link=https://github.com/kubernetes/kops/blob/e3fbc2ad043e58cfdcf934e015ef8d5d9e42273e/pkg/instancegroups/rollingupdate.go#L91
#define def_var_groups  -2 // opt groups line 91
#define def_var_sortGroups123  ?? // mand sortGroups(bastionGroups) line 123
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_RollingUpdate910 = [1] of {int};
	run RollingUpdate91(def_var_groups,child_RollingUpdate910);
	run receiver(child_RollingUpdate910)
stop_process:skip
}

proctype RollingUpdate91(int var_groups;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef resultsMutex;
	int var_nodeGroups = -2; // opt var_nodeGroups
	int var_apiServerGroups = -2; // opt var_apiServerGroups
	int var_results = -2; // opt var_results
	int var_sortGroups = def_var_sortGroups123; // mand var_sortGroups
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(resultsMutex);
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

