
// https://github.com/kubernetes/kops/blob/master/pkg/resources/spotinst/spotinst.go#L36
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewCloud360 = [1] of {int};
	run NewCloud36(child_NewCloud360)
stop_process:skip
}

proctype NewCloud36(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef oc_Client_config_Credentials_mu;
	Mutexdef eg_Client_config_Credentials_mu;
	Mutexdef sess_Config_Credentials_mu;
	run mutexMonitor(sess_Config_Credentials_mu);
	run mutexMonitor(eg_Client_config_Credentials_mu);
	run mutexMonitor(oc_Client_config_Credentials_mu);
	

	if
	:: true;
	:: true -> 
		goto stop_process
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

