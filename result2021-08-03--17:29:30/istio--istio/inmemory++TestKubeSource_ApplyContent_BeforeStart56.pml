// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/galley/pkg/config/source/kube/inmemory/kubesource_test.go#L56
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestKubeSource_ApplyContent_BeforeStart560 = [1] of {int};
	run TestKubeSource_ApplyContent_BeforeStart56(child_TestKubeSource_ApplyContent_BeforeStart560);
	run receiver(child_TestKubeSource_ApplyContent_BeforeStart560)
stop_process:skip
}

proctype TestKubeSource_ApplyContent_BeforeStart56(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stop1070 = [1] of {int};
	chan child_Start1022 = [1] of {int};
	chan child_ApplyContent1461 = [1] of {int};
	Mutexdef acc_mu;
	Mutexdef s_source_mu;
	Mutexdef s_mu;
	run mutexMonitor(s_mu);
	run mutexMonitor(s_source_mu);
	run mutexMonitor(acc_mu);
	run ApplyContent146(s_mu,s_source_mu,child_ApplyContent1461);
	child_ApplyContent1461?0;
	run Start102(s_mu,s_source_mu,child_Start1022);
	child_Start1022?0;
		defer1: skip;
	run Stop107(s_mu,s_source_mu,child_Stop1070);
	child_Stop1070?0;
	stop_process: skip;
	child!0
}
proctype Stop107(Mutexdef s_mu;Mutexdef s_source_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype ApplyContent146(Mutexdef s_mu;Mutexdef s_source_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_parseContent2011 = [1] of {int};
	int var_oldKeys = -2; // opt var_oldKeys
	int var_resources = -2; // opt var_resources
	s_mu.Lock!false;
	run parseContent201(s_mu,s_source_mu,child_parseContent2011);
	child_parseContent2011?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	s_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype parseContent201(Mutexdef s_mu;Mutexdef s_source_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_parseChunk2551 = [1] of {int};
	do
	:: true -> 
		for10: skip;
		

		if
		:: true -> 
			break
		:: true;
		fi;
		

		if
		:: true -> 
			break
		:: true;
		fi;
		run parseChunk255(s_mu,s_source_mu,child_parseChunk2551);
		child_parseChunk2551?0;
		

		if
		:: true -> 
			goto for10_end
		:: true;
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype parseChunk255(Mutexdef s_mu;Mutexdef s_source_mu;chan child) {
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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Start102(Mutexdef s_mu;Mutexdef s_source_mu;chan child) {
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
