// num_comm_params=7
// num_mand_comm_params=1
// num_opt_comm_params=6

// git_link=https://github.com/kubernetes/kops/blob/e3fbc2ad043e58cfdcf934e015ef8d5d9e42273e/pkg/instancegroups/rollingupdate.go#L91
#define groups91  -2 // opt groups91
#define RollingUpdate_sortGroups_bastionGroups_  ??
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_RollingUpdate910 = [1] of {int};
	run RollingUpdate91(groups91,child_RollingUpdate910);
	run receiver(child_RollingUpdate910)
stop_process:skip
}

proctype RollingUpdate91(int groups;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef resultsMutex;
	int sortGroups_nodeGroups_ = -2; // opt sortGroups_nodeGroups_
	int nodeGroups = -2; // opt nodeGroups
	int sortGroups_apiServerGroups_ = -2; // opt sortGroups_apiServerGroups_
	int apiServerGroups = -2; // opt apiServerGroups
	int sortGroups_masterGroups_ = -2; // opt sortGroups_masterGroups_
	int results = -2; // opt results
	int sortGroups_bastionGroups_ = RollingUpdate_sortGroups_bastionGroups_; // mand sortGroups_bastionGroups_
	

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

