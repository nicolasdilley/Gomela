// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/jaegertracing/jaeger/blob/12bba8c9b91cf4a29d314934bc08f4a80e43c042/cmd/anonymizer/app/anonymizer/anonymizer_test.go#L138
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAnonymizer_MapString_Present1380 = [1] of {int};
	run TestAnonymizer_MapString_Present138(child_TestAnonymizer_MapString_Present1380);
	run receiver(child_TestAnonymizer_MapString_Present1380)
stop_process:skip
}

proctype TestAnonymizer_MapString_Present138(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_mapString1270 = [1] of {int};
	Mutexdef anonymizer_lock;
	run mutexMonitor(anonymizer_lock);
	run mapString127(anonymizer_lock,child_mapString1270);
	child_mapString1270?0;
	stop_process: skip;
	child!0
}
proctype mapString127(Mutexdef a_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	a_lock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	a_lock.Unlock!false;
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
