
// https://github.com/mattermost/mattermost-server/blob/master/model/integration_action_test.go#L110
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPostActionIntegrationResponseFromJsonError1100 = [1] of {int};
	run TestPostActionIntegrationResponseFromJsonError110(child_TestPostActionIntegrationResponseFromJsonError1100)
stop_process:skip
}

proctype TestPostActionIntegrationResponseFromJsonError110(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ro_Update_propsMu;
	run mutexMonitor(ro_Update_propsMu);
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

