// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/dapr/dapr/blob/ab83d3535478699a2f2707d9ed9008f78c155d6d/pkg/http/server.go#L56
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_StartNonBlocking560 = [1] of {int};
	run StartNonBlocking56(child_StartNonBlocking560);
	run receiver(child_StartNonBlocking560)
stop_process:skip
}

proctype StartNonBlocking56(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousStartNonBlocking76661 = [1] of {int};
	chan child_AnonymousStartNonBlocking71660 = [1] of {int};
	Mutexdef customServer_mu;
	Mutexdef customServer_perIPConnCounter_lock;
	Mutexdef customServer_tlsConfig_mutex;
	run mutexMonitor(customServer_tlsConfig_mutex);
	run mutexMonitor(customServer_perIPConnCounter_lock);
	run mutexMonitor(customServer_mu);
	run AnonymousStartNonBlocking7166(customServer_tlsConfig_mutex,customServer_perIPConnCounter_lock,customServer_mu,child_AnonymousStartNonBlocking71660);
	run receiver(child_AnonymousStartNonBlocking71660);
	

	if
	:: true -> 
		run AnonymousStartNonBlocking7666(customServer_tlsConfig_mutex,customServer_perIPConnCounter_lock,customServer_mu,child_AnonymousStartNonBlocking76661);
		run receiver(child_AnonymousStartNonBlocking76661)
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousStartNonBlocking7166(Mutexdef customServer_tlsConfig_mutex;Mutexdef customServer_perIPConnCounter_lock;Mutexdef customServer_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype AnonymousStartNonBlocking7666(Mutexdef customServer_tlsConfig_mutex;Mutexdef customServer_perIPConnCounter_lock;Mutexdef customServer_mu;chan child) {
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

proctype receiver(chan c) {
c?0
}

