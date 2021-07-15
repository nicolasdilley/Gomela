
// https://github.com/mattermost/mattermost-server/blob/master/app/busy_test.go#L90
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBusyRace900 = [1] of {int};
	run TestBusyRace90(child_TestBusyRace900)
stop_process:skip
}

proctype TestBusyRace90(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Set461 = [1] of {int};
	chan child_NewBusy330 = [1] of {int};
	Mutexdef busy_mux;
	Mutexdef cluster_Busy_mux;
	run mutexMonitor(cluster_Busy_mux);
	run mutexMonitor(busy_mux);
	run NewBusy33(cluster_Busy_mux,child_NewBusy330);
	child_NewBusy330?0;
	run Set46(busy_mux,child_Set461);
	child_Set461?0;
	stop_process: skip;
	child!0
}
proctype NewBusy33(Mutexdef cluster_Busy_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Set46(Mutexdef b_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_notifyServerBusyChange1082 = [1] of {int};
	chan child_setWithoutNotify641 = [1] of {int};
	b_mux.Lock!false;
	run setWithoutNotify64(b_mux,child_setWithoutNotify641);
	child_setWithoutNotify641?0;
	

	if
	:: true -> 
		run notifyServerBusyChange108(b_mux,child_notifyServerBusyChange1082);
		child_notifyServerBusyChange1082?0
	:: true;
	fi;
	stop_process: skip;
		b_mux.Unlock!false;
	child!0
}
proctype setWithoutNotify64(Mutexdef b_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_clearWithoutNotify891 = [1] of {int};
	run clearWithoutNotify89(b_mux,child_clearWithoutNotify891);
	child_clearWithoutNotify891?0;
	stop_process: skip;
	child!0
}
proctype clearWithoutNotify89(Mutexdef b_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype notifyServerBusyChange108(Mutexdef b_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

