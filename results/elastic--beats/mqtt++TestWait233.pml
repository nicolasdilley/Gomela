// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//filebeat/input/mqtt/input_test.go#L233
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
	chan child_TestWait2330 = [1] of {int};
	run TestWait233(child_TestWait2330);
	run receiver(child_TestWait2330)
stop_process:skip
}

proctype TestWait233(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Wait1940 = [1] of {int};
	Wgdef input_inflightMessages;
	Wgdef input_clientDisconnected;
	Mutexdef input_once_m;
	Wgdef inflightMessages;
	Wgdef clientDisconnected;
	run wgMonitor(clientDisconnected);
	run wgMonitor(inflightMessages);
	run mutexMonitor(input_once_m);
	run wgMonitor(input_clientDisconnected);
	run wgMonitor(input_inflightMessages);
	run Wait194(input_clientDisconnected,input_inflightMessages,input_once_m,child_Wait1940);
	child_Wait1940?0;
	stop_process: skip;
	child!0
}
proctype Wait194(Wgdef mi_clientDisconnected;Wgdef mi_inflightMessages;Mutexdef mi_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stop1830 = [1] of {int};
	run Stop183(mi_clientDisconnected,mi_inflightMessages,mi_once_m,child_Stop1830);
	child_Stop1830?0;
	mi_clientDisconnected.wait?0;
	mi_inflightMessages.wait?0;
	stop_process: skip;
	child!0
}
proctype Stop183(Wgdef mi_clientDisconnected;Wgdef mi_inflightMessages;Mutexdef mi_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousStop18700 = [1] of {int};
	mi_clientDisconnected.update!1;
	run AnonymousStop1870(mi_clientDisconnected,mi_inflightMessages,mi_once_m,child_AnonymousStop18700);
	run receiver(child_AnonymousStop18700);
	stop_process: skip;
	child!0
}
proctype AnonymousStop1870(Wgdef mi_clientDisconnected;Wgdef mi_inflightMessages;Mutexdef mi_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	mi_clientDisconnected.update!-1;
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

