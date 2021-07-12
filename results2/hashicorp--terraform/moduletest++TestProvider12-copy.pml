// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/internal/moduletest/provider_test.go#L12
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestProvider120 = [1] of {int};
	run TestProvider12(child_TestProvider120);
	run receiver(child_TestProvider120)
stop_process:skip
}

proctype TestProvider12(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TestResults675 = [1] of {int};
	chan child_ApplyResourceChange3684 = [1] of {int};
	chan child_TestResults673 = [1] of {int};
	chan child_PlanResourceChange2432 = [1] of {int};
	chan child_ValidateResourceConfig1231 = [1] of {int};
	chan child_ConfigureProvider1080 = [1] of {int};
	Mutexdef p_mutex;
	int var_assertionConfig_Type___TestConformance_testAssertionsSchema_Block_ImpliedType___assertionConfig_Type___TestConformance_testAssertionsSchema_Block_ImpliedType___ = -2; // opt var_assertionConfig_Type___TestConformance_testAssertionsSchema_Block_ImpliedType___assertionConfig_Type___TestConformance_testAssertionsSchema_Block_ImpliedType___
	run mutexMonitor(p_mutex);
	run ConfigureProvider108(p_mutex,child_ConfigureProvider1080);
	child_ConfigureProvider1080?0;
	run ValidateResourceConfig123(p_mutex,child_ValidateResourceConfig1231);
	child_ValidateResourceConfig1231?0;
	run PlanResourceChange243(p_mutex,child_PlanResourceChange2432);
	child_PlanResourceChange2432?0;
	run TestResults67(p_mutex,child_TestResults673);
	child_TestResults673?0;
	run ApplyResourceChange368(p_mutex,child_ApplyResourceChange3684);
	child_ApplyResourceChange3684?0;
	run TestResults67(p_mutex,child_TestResults675);
	child_TestResults675?0;
	stop_process: skip;
	child!0
}
proctype ConfigureProvider108(Mutexdef p_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ValidateResourceConfig123(Mutexdef p_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype PlanResourceChange243(Mutexdef p_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	p_mutex.Lock!false;
	goto defer1;
		defer1: skip;
	p_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype TestResults67(Mutexdef p_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ApplyResourceChange368(Mutexdef p_mutex;chan child) {
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
	p_mutex.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	p_mutex.Unlock!false;
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

