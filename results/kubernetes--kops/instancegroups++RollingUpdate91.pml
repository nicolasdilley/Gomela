#define groups91  -2
#define RollingUpdate_sortGroups_bastionGroups_  0

// https://github.com/kubernetes/kops/blob/master/pkg/instancegroups/rollingupdate.go#L91
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_RollingUpdate910 = [1] of {int};
	run RollingUpdate91(groups91,child_RollingUpdate910)
stop_process:skip
}

proctype RollingUpdate91(int groups;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef resultsMutex;
	int sortGroups_bastionGroups_ = RollingUpdate_sortGroups_bastionGroups_;
	

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

