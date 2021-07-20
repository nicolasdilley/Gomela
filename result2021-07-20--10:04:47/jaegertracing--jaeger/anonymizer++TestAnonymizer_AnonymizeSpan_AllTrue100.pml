// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/jaegertracing/jaeger/blob/12bba8c9b91cf4a29d314934bc08f4a80e43c042/cmd/anonymizer/app/anonymizer/anonymizer_test.go#L100
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAnonymizer_AnonymizeSpan_AllTrue1000 = [1] of {int};
	run TestAnonymizer_AnonymizeSpan_AllTrue100(child_TestAnonymizer_AnonymizeSpan_AllTrue1000);
	run receiver(child_TestAnonymizer_AnonymizeSpan_AllTrue1000)
stop_process:skip
}

proctype TestAnonymizer_AnonymizeSpan_AllTrue100(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymizeSpan1450 = [1] of {int};
	Mutexdef anonymizer_lock;
	run mutexMonitor(anonymizer_lock);
	run AnonymizeSpan145(anonymizer_lock,child_AnonymizeSpan1450);
	child_AnonymizeSpan1450?0;
	stop_process: skip;
	child!0
}
proctype AnonymizeSpan145(Mutexdef a_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_mapServiceName1181 = [1] of {int};
	chan child_mapOperationName1220 = [1] of {int};
	int var_span_Logsspan_Logs = -2; // opt var_span_Logsspan_Logs
	run mapOperationName122(a_lock,child_mapOperationName1220);
	child_mapOperationName1220?0;
	run mapServiceName118(a_lock,child_mapServiceName1181);
	child_mapServiceName1181?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype mapOperationName122(Mutexdef a_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_mapString1270 = [1] of {int};
	run mapString127(a_lock,child_mapString1270);
	child_mapString1270?0;
	goto stop_process;
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
proctype mapServiceName118(Mutexdef a_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_mapString1271 = [1] of {int};
	run mapString127(a_lock,child_mapString1271);
	child_mapString1271?0;
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

