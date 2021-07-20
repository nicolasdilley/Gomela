// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pkg/kube/inject/inject_test.go#L422
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testInjectionTemplate4220 = [1] of {int};
	run testInjectionTemplate422(child_testInjectionTemplate4220);
	run receiver(child_testInjectionTemplate4220)
stop_process:skip
}

proctype testInjectionTemplate422(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runWebhook5550 = [1] of {int};
	Mutexdef webhook_mu;
	run mutexMonitor(webhook_mu);
	run runWebhook555(webhook_mu,child_runWebhook5550);
	child_runWebhook5550?0;
	stop_process: skip;
	child!0
}
proctype runWebhook555(Mutexdef webhook_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_inject7060 = [1] of {int};
	run inject706(webhook_mu,child_inject7060);
	child_inject7060?0;
	stop_process: skip;
	child!0
}
proctype inject706(Mutexdef wh_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wh_mu.RLock!false;
	

	if
	:: true -> 
		wh_mu.RUnlock!false;
		goto stop_process
	:: true;
	fi;
	wh_mu.RUnlock!false;
	

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

