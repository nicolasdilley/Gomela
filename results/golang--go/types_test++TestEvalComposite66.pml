// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//go/types/eval_test.go#L66
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEvalComposite660 = [1] of {int};
	run TestEvalComposite66(child_TestEvalComposite660);
	run receiver(child_TestEvalComposite660)
stop_process:skip
}

proctype TestEvalComposite66(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_testEval220 = [1] of {int};
	chan child_testEval221 = [1] of {int};
	Mutexdef fset_last_mutex;
	Mutexdef fset_mutex;
	int var_independentTestTypes = -2; // opt var_independentTestTypes
	run mutexMonitor(fset_mutex);
	run mutexMonitor(fset_last_mutex);
	

	if
	:: var_independentTestTypes-1 != -3 -> 
				for(i : 0.. var_independentTestTypes-1) {
			for10: skip;
			run testEval22(fset_last_mutex,fset_mutex,child_testEval220);
			child_testEval220?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run testEval22(fset_last_mutex,fset_mutex,child_testEval221);
			child_testEval221?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype testEval22(Mutexdef fset_last_mutex;Mutexdef fset_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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

proctype receiver(chan c) {
c?0
}

