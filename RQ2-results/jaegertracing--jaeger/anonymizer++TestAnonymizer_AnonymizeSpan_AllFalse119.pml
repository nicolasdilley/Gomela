
// https://github.com/jaegertracing/jaeger/blob/master/cmd/anonymizer/app/anonymizer/anonymizer_test.go#L119
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAnonymizer_AnonymizeSpan_AllFalse1190 = [1] of {int};
	run TestAnonymizer_AnonymizeSpan_AllFalse119(child_TestAnonymizer_AnonymizeSpan_AllFalse1190)
stop_process:skip
}

proctype TestAnonymizer_AnonymizeSpan_AllFalse119(chan child) {
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
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		a_lock.Unlock!false;
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

