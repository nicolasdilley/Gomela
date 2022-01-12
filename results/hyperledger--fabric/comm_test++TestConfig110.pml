// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//internal/pkg/comm/creds_test.go#L110
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig1100 = [1] of {int};
	run TestConfig110(child_TestConfig1100);
	run receiver(child_TestConfig1100)
stop_process:skip
}

proctype TestConfig110(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Config712 = [1] of {int};
	chan child_SetClientCAs891 = [1] of {int};
	chan child_Config710 = [1] of {int};
	Mutexdef configCopy_mutex;
	Mutexdef config_lock;
	Mutexdef config_config_mutex;
	run mutexMonitor(config_config_mutex);
	run mutexMonitor(config_lock);
	run mutexMonitor(configCopy_mutex);
	run Config71(config_config_mutex,config_lock,child_Config710);
	child_Config710?0;
	run SetClientCAs89(config_config_mutex,config_lock,child_SetClientCAs891);
	child_SetClientCAs891?0;
	run Config71(config_config_mutex,config_lock,child_Config712);
	child_Config712?0;
	stop_process: skip;
	child!0
}
proctype Config71(Mutexdef t_config_mutex;Mutexdef t_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	t_lock.RLock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	t_lock.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype SetClientCAs89(Mutexdef t_config_mutex;Mutexdef t_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	t_lock.Lock!false;
		defer1: skip;
	t_lock.Unlock!false;
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

