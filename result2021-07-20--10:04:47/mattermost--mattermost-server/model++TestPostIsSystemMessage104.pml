// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/mattermost/mattermost-server/blob/5c16de58a02099df38e1e8486df148d1b798460a/model/post_test.go#L104
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPostIsSystemMessage1040 = [1] of {int};
	run TestPostIsSystemMessage104(child_TestPostIsSystemMessage1040);
	run receiver(child_TestPostIsSystemMessage1040)
stop_process:skip
}

proctype TestPostIsSystemMessage104(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IsSystemMessage4663 = [1] of {int};
	chan child_PreSave3862 = [1] of {int};
	Mutexdef post2_propsMu;
	chan child_IsSystemMessage4661 = [1] of {int};
	chan child_PreSave3860 = [1] of {int};
	Mutexdef post1_propsMu;
	run mutexMonitor(post1_propsMu);
	run PreSave386(post1_propsMu,child_PreSave3860);
	child_PreSave3860?0;
	run IsSystemMessage466(post1_propsMu,child_IsSystemMessage4661);
	child_IsSystemMessage4661?0;
	run mutexMonitor(post2_propsMu);
	run PreSave386(post2_propsMu,child_PreSave3862);
	child_PreSave3862?0;
	run IsSystemMessage466(post2_propsMu,child_IsSystemMessage4663);
	child_IsSystemMessage4663?0;
	stop_process: skip;
	child!0
}
proctype PreSave386(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PreCommit4010 = [1] of {int};
	run PreCommit401(o_propsMu,child_PreCommit4010);
	child_PreCommit4010?0;
	stop_process: skip;
	child!0
}
proctype PreCommit401(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GenerateActionIds4052 = [1] of {int};
	chan child_SetProps4541 = [1] of {int};
	chan child_GetProps4480 = [1] of {int};
	run GetProps448(o_propsMu,child_GetProps4480);
	child_GetProps4480?0;
	

	if
	:: true -> 
		run SetProps454(o_propsMu,child_SetProps4541);
		child_SetProps4541?0
	:: true;
	fi;
	run GenerateActionIds405(o_propsMu,child_GenerateActionIds4052);
	child_GenerateActionIds4052?0;
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
proctype SetProps454(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	o_propsMu.Lock!false;
		defer1: skip;
	o_propsMu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype GenerateActionIds405(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetProp4604 = [1] of {int};
	chan child_AddProp4373 = [1] of {int};
	chan child_GetProp4602 = [1] of {int};
	int var_attachment_Actionsattachment_Actions = -2; // opt var_attachment_Actionsattachment_Actions
	int var_attachmentsattachments = -2; // opt var_attachmentsattachments
	run GetProp460(o_propsMu,child_GetProp4602);
	child_GetProp4602?0;
	

	if
	:: true -> 
		run AddProp437(o_propsMu,child_AddProp4373);
		child_AddProp4373?0
	:: true;
	fi;
	run GetProp460(o_propsMu,child_GetProp4604);
	child_GetProp4604?0;
	stop_process: skip;
	child!0
}
proctype GetProp460(Mutexdef o_propsMu;chan child) {
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
proctype AddProp437(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_o_Propso_Props = -2; // opt var_o_Propso_Props
	o_propsMu.Lock!false;
		defer1: skip;
	o_propsMu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype IsSystemMessage466(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

