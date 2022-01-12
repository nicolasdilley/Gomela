// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//filebeat/input/mqtt/input_test.go#L220
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRun_Twice2200 = [1] of {int};
	run TestRun_Twice220(child_TestRun_Twice2200);
	run receiver(child_TestRun_Twice2200)
stop_process:skip
}

proctype TestRun_Twice220(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Run1751 = [1] of {int};
	chan child_Run1750 = [1] of {int};
	Wgdef input_inflightMessages;
	Wgdef input_clientDisconnected;
	Mutexdef input_once_m;
	run mutexMonitor(input_once_m);
	run wgMonitor(input_clientDisconnected);
	run wgMonitor(input_inflightMessages);
	run Run175(input_clientDisconnected,input_inflightMessages,input_once_m,child_Run1750);
	child_Run1750?0;
	run Run175(input_clientDisconnected,input_inflightMessages,input_once_m,child_Run1751);
	child_Run1751?0;
	stop_process: skip;
	child!0
}
proctype Run175(Wgdef mi_clientDisconnected;Wgdef mi_inflightMessages;Mutexdef mi_once_m;chan child) {
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
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

