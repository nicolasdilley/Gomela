// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//packetbeat/protos/memcache/text_test.go#L70
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test_TextParseMultiGetCommand700 = [1] of {int};
	run Test_TextParseMultiGetCommand70(child_Test_TextParseMultiGetCommand700);
	run receiver(child_Test_TextParseMultiGetCommand700)
stop_process:skip
}

proctype Test_TextParseMultiGetCommand70(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_textNoFail1141 = [1] of {int};
	chan child_textNoFail1140 = [1] of {int};
	Mutexdef p_testing_context_mu;
	Mutexdef p_testing_context_match_mu;
	run mutexMonitor(p_testing_context_match_mu);
	run mutexMonitor(p_testing_context_mu);
	run textNoFail114(p_testing_context_match_mu,p_testing_context_mu,child_textNoFail1140);
	child_textNoFail1140?0;
	run textNoFail114(p_testing_context_match_mu,p_testing_context_mu,child_textNoFail1141);
	child_textNoFail1141?0;
	stop_process: skip;
	child!0
}
proctype textNoFail114(Mutexdef tp_testing_context_match_mu;Mutexdef tp_testing_context_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_parseNoFail1010 = [1] of {int};
	run parseNoFail101(tp_testing_context_match_mu,tp_testing_context_mu,child_parseNoFail1010);
	child_parseNoFail1010?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype parseNoFail101(Mutexdef tp_testing_context_match_mu;Mutexdef tp_testing_context_mu;chan child) {
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
