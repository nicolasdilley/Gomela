// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kops/blob/e3fbc2ad043e58cfdcf934e015ef8d5d9e42273e/pkg/instancegroups/rollingupdate_os_test.go#L105
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRollingUpdateDisabledSurgeOS1050 = [1] of {int};
	run TestRollingUpdateDisabledSurgeOS105(child_TestRollingUpdateDisabledSurgeOS1050);
	run receiver(child_TestRollingUpdateDisabledSurgeOS1050)
stop_process:skip
}

proctype TestRollingUpdateDisabledSurgeOS105(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_assertGroupInstanceCountOS2093 = [1] of {int};
	chan child_assertGroupInstanceCountOS2092 = [1] of {int};
	chan child_assertGroupInstanceCountOS2091 = [1] of {int};
	chan child_assertGroupInstanceCountOS2090 = [1] of {int};
	Mutexdef cloud_MockImageClient_mutex;
	Mutexdef cloud_MockLBClient_mutex;
	Mutexdef cloud_MockDNSClient_mutex;
	Mutexdef cloud_MockNovaClient_mutex;
	Mutexdef cloud_MockNeutronClient_mutex;
	Mutexdef cloud_MockCinderClient_mutex;
	run mutexMonitor(cloud_MockCinderClient_mutex);
	run mutexMonitor(cloud_MockNeutronClient_mutex);
	run mutexMonitor(cloud_MockNovaClient_mutex);
	run mutexMonitor(cloud_MockDNSClient_mutex);
	run mutexMonitor(cloud_MockLBClient_mutex);
	run mutexMonitor(cloud_MockImageClient_mutex);
	run assertGroupInstanceCountOS209(cloud_MockCinderClient_mutex,cloud_MockDNSClient_mutex,cloud_MockImageClient_mutex,cloud_MockLBClient_mutex,cloud_MockNeutronClient_mutex,cloud_MockNovaClient_mutex,child_assertGroupInstanceCountOS2090);
	child_assertGroupInstanceCountOS2090?0;
	run assertGroupInstanceCountOS209(cloud_MockCinderClient_mutex,cloud_MockDNSClient_mutex,cloud_MockImageClient_mutex,cloud_MockLBClient_mutex,cloud_MockNeutronClient_mutex,cloud_MockNovaClient_mutex,child_assertGroupInstanceCountOS2091);
	child_assertGroupInstanceCountOS2091?0;
	run assertGroupInstanceCountOS209(cloud_MockCinderClient_mutex,cloud_MockDNSClient_mutex,cloud_MockImageClient_mutex,cloud_MockLBClient_mutex,cloud_MockNeutronClient_mutex,cloud_MockNovaClient_mutex,child_assertGroupInstanceCountOS2092);
	child_assertGroupInstanceCountOS2092?0;
	run assertGroupInstanceCountOS209(cloud_MockCinderClient_mutex,cloud_MockDNSClient_mutex,cloud_MockImageClient_mutex,cloud_MockLBClient_mutex,cloud_MockNeutronClient_mutex,cloud_MockNovaClient_mutex,child_assertGroupInstanceCountOS2093);
	child_assertGroupInstanceCountOS2093?0;
	stop_process: skip;
	child!0
}
proctype assertGroupInstanceCountOS209(Mutexdef cloud_MockCinderClient_mutex;Mutexdef cloud_MockDNSClient_mutex;Mutexdef cloud_MockImageClient_mutex;Mutexdef cloud_MockLBClient_mutex;Mutexdef cloud_MockNeutronClient_mutex;Mutexdef cloud_MockNovaClient_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_groups = -2; // opt var_groups
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

