
// https://github.com/kubernetes/kubernetes/blob/master/pkg/volume/azure_file/azure_file_test.go#L118
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPluginWithOtherCloudProvider1180 = [1] of {int};
	run TestPluginWithOtherCloudProvider118(child_TestPluginWithOtherCloudProvider1180)
stop_process:skip
}

proctype TestPluginWithOtherCloudProvider118(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cloud_addCallLock;
	Mutexdef cloud_Lock;
	Mutexdef cloud_addressesMux;
	run mutexMonitor(cloud_addressesMux);
	run mutexMonitor(cloud_Lock);
	run mutexMonitor(cloud_addCallLock);
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

