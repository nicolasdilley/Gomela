// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/mattermost/mattermost-server/blob/5c16de58a02099df38e1e8486df148d1b798460a/model/post_test.go#L30
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPostIsValid300 = [1] of {int};
	run TestPostIsValid30(child_TestPostIsValid300);
	run receiver(child_TestPostIsValid300)
stop_process:skip
}

proctype TestPostIsValid30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IsValid27612 = [1] of {int};
	chan child_IsValid27611 = [1] of {int};
	chan child_IsValid27610 = [1] of {int};
	chan child_IsValid2769 = [1] of {int};
	chan child_IsValid2768 = [1] of {int};
	chan child_IsValid2767 = [1] of {int};
	chan child_IsValid2766 = [1] of {int};
	chan child_IsValid2765 = [1] of {int};
	chan child_IsValid2764 = [1] of {int};
	chan child_IsValid2763 = [1] of {int};
	chan child_IsValid2762 = [1] of {int};
	chan child_IsValid2761 = [1] of {int};
	chan child_IsValid2760 = [1] of {int};
	Mutexdef o_propsMu;
	run mutexMonitor(o_propsMu);
	run IsValid276(o_propsMu,child_IsValid2760);
	child_IsValid2760?0;
	run IsValid276(o_propsMu,child_IsValid2761);
	child_IsValid2761?0;
	run IsValid276(o_propsMu,child_IsValid2762);
	child_IsValid2762?0;
	run IsValid276(o_propsMu,child_IsValid2763);
	child_IsValid2763?0;
	run IsValid276(o_propsMu,child_IsValid2764);
	child_IsValid2764?0;
	run IsValid276(o_propsMu,child_IsValid2765);
	child_IsValid2765?0;
	run IsValid276(o_propsMu,child_IsValid2766);
	child_IsValid2766?0;
	run IsValid276(o_propsMu,child_IsValid2767);
	child_IsValid2767?0;
	run IsValid276(o_propsMu,child_IsValid2768);
	child_IsValid2768?0;
	run IsValid276(o_propsMu,child_IsValid2769);
	child_IsValid2769?0;
	run IsValid276(o_propsMu,child_IsValid27610);
	child_IsValid27610?0;
	run IsValid276(o_propsMu,child_IsValid27611);
	child_IsValid27611?0;
	run IsValid276(o_propsMu,child_IsValid27612);
	child_IsValid27612?0;
	stop_process: skip;
	child!0
}
proctype IsValid276(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetProps4480 = [1] of {int};
	

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
	run GetProps448(o_propsMu,child_GetProps4480);
	child_GetProps4480?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetProps448(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	o_propsMu.RLock!false;
	goto defer1;
		defer1: skip;
	o_propsMu.RUnlock!false;
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

