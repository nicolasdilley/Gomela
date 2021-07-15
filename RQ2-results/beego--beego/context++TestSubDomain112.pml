
// https://github.com/beego/beego/blob/master/server/web/context/input_test.go#L112
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSubDomain1120 = [1] of {int};
	run TestSubDomain112(child_TestSubDomain1120)
stop_process:skip
}

proctype TestSubDomain112(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SubDomains2548 = [1] of {int};
	chan child_SubDomains2547 = [1] of {int};
	chan child_SubDomains2546 = [1] of {int};
	chan child_SubDomains2545 = [1] of {int};
	chan child_SubDomains2544 = [1] of {int};
	chan child_SubDomains2543 = [1] of {int};
	chan child_SubDomains2542 = [1] of {int};
	chan child_SubDomains2541 = [1] of {int};
	chan child_SubDomains2540 = [1] of {int};
	Mutexdef beegoInput_dataLock;
	run mutexMonitor(beegoInput_dataLock);
	run SubDomains254(beegoInput_dataLock,child_SubDomains2540);
	child_SubDomains2540?0;
	run SubDomains254(beegoInput_dataLock,child_SubDomains2541);
	child_SubDomains2541?0;
	

	if
	:: true -> 
		run SubDomains254(beegoInput_dataLock,child_SubDomains2542);
		child_SubDomains2542?0
	:: true;
	fi;
	run SubDomains254(beegoInput_dataLock,child_SubDomains2543);
	child_SubDomains2543?0;
	

	if
	:: true -> 
		run SubDomains254(beegoInput_dataLock,child_SubDomains2544);
		child_SubDomains2544?0
	:: true;
	fi;
	run SubDomains254(beegoInput_dataLock,child_SubDomains2545);
	child_SubDomains2545?0;
	

	if
	:: true -> 
		run SubDomains254(beegoInput_dataLock,child_SubDomains2546);
		child_SubDomains2546?0
	:: true;
	fi;
	run SubDomains254(beegoInput_dataLock,child_SubDomains2547);
	child_SubDomains2547?0;
	

	if
	:: true -> 
		run SubDomains254(beegoInput_dataLock,child_SubDomains2548);
		child_SubDomains2548?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype SubDomains254(Mutexdef input_dataLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Host1210 = [1] of {int};
	run Host121(input_dataLock,child_Host1210);
	child_Host1210?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Host121(Mutexdef input_dataLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
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

