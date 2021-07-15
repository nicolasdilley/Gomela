
// https://github.com/mattermost/mattermost-server/blob/master/model/post_test.go#L30
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPostIsValid300 = [1] of {int};
	run TestPostIsValid30(child_TestPostIsValid300)
stop_process:skip
}

proctype TestPostIsValid30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IsValid27512 = [1] of {int};
	chan child_IsValid27511 = [1] of {int};
	chan child_IsValid27510 = [1] of {int};
	chan child_IsValid2759 = [1] of {int};
	chan child_IsValid2758 = [1] of {int};
	chan child_IsValid2757 = [1] of {int};
	chan child_IsValid2756 = [1] of {int};
	chan child_IsValid2755 = [1] of {int};
	chan child_IsValid2754 = [1] of {int};
	chan child_IsValid2753 = [1] of {int};
	chan child_IsValid2752 = [1] of {int};
	chan child_IsValid2751 = [1] of {int};
	chan child_IsValid2750 = [1] of {int};
	Mutexdef o_propsMu;
	run mutexMonitor(o_propsMu);
	run IsValid275(o_propsMu,child_IsValid2750);
	child_IsValid2750?0;
	run IsValid275(o_propsMu,child_IsValid2751);
	child_IsValid2751?0;
	run IsValid275(o_propsMu,child_IsValid2752);
	child_IsValid2752?0;
	run IsValid275(o_propsMu,child_IsValid2753);
	child_IsValid2753?0;
	run IsValid275(o_propsMu,child_IsValid2754);
	child_IsValid2754?0;
	run IsValid275(o_propsMu,child_IsValid2755);
	child_IsValid2755?0;
	run IsValid275(o_propsMu,child_IsValid2756);
	child_IsValid2756?0;
	run IsValid275(o_propsMu,child_IsValid2757);
	child_IsValid2757?0;
	run IsValid275(o_propsMu,child_IsValid2758);
	child_IsValid2758?0;
	run IsValid275(o_propsMu,child_IsValid2759);
	child_IsValid2759?0;
	run IsValid275(o_propsMu,child_IsValid27510);
	child_IsValid27510?0;
	run IsValid275(o_propsMu,child_IsValid27511);
	child_IsValid27511?0;
	run IsValid275(o_propsMu,child_IsValid27512);
	child_IsValid27512?0;
	stop_process: skip;
	child!0
}
proctype IsValid275(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetProps4470 = [1] of {int};
	

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
	fi;
	

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
	run GetProps447(o_propsMu,child_GetProps4470);
	child_GetProps4470?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetProps447(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	o_propsMu.RLock!false;
	goto stop_process;
	stop_process: skip;
		o_propsMu.RUnlock!false;
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

