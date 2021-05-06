
// https://github.com/mattermost/mattermost-server/blob/master/model/post_test.go#L89
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPostPreSave890 = [1] of {int};
	run TestPostPreSave89(child_TestPostPreSave890)
stop_process:skip
}

proctype TestPostPreSave89(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Etag2712 = [1] of {int};
	chan child_PreSave3851 = [1] of {int};
	chan child_PreSave3850 = [1] of {int};
	Mutexdef o_propsMu;
	run mutexMonitor(o_propsMu);
	run PreSave385(o_propsMu,child_PreSave3850);
	child_PreSave3850?0;
	run PreSave385(o_propsMu,child_PreSave3851);
	child_PreSave3851?0;
	run Etag271(o_propsMu,child_Etag2712);
	child_Etag2712?0;
	stop_process: skip;
	child!0
}
proctype PreSave385(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PreCommit4000 = [1] of {int};
	run PreCommit400(o_propsMu,child_PreCommit4000);
	child_PreCommit4000?0;
	stop_process: skip;
	child!0
}
proctype PreCommit400(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GenerateActionIds4052 = [1] of {int};
	chan child_SetProps4531 = [1] of {int};
	chan child_GetProps4470 = [1] of {int};
	run GetProps447(o_propsMu,child_GetProps4470);
	child_GetProps4470?0;
	

	if
	:: true -> 
		run SetProps453(o_propsMu,child_SetProps4531);
		child_SetProps4531?0
	:: true;
	fi;
	run GenerateActionIds405(o_propsMu,child_GenerateActionIds4052);
	child_GenerateActionIds4052?0;
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
proctype SetProps453(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	o_propsMu.Lock!false;
	stop_process: skip;
		o_propsMu.Unlock!false;
	child!0
}
proctype GenerateActionIds405(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetProp4594 = [1] of {int};
	chan child_AddProp4363 = [1] of {int};
	chan child_GetProp4592 = [1] of {int};
	run GetProp459(o_propsMu,child_GetProp4592);
	child_GetProp4592?0;
	

	if
	:: true -> 
		run AddProp436(o_propsMu,child_AddProp4363);
		child_AddProp4363?0
	:: true;
	fi;
	run GetProp459(o_propsMu,child_GetProp4594);
	child_GetProp4594?0;
	stop_process: skip;
	child!0
}
proctype GetProp459(Mutexdef o_propsMu;chan child) {
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
proctype AddProp436(Mutexdef o_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	o_propsMu.Lock!false;
	stop_process: skip;
		o_propsMu.Unlock!false;
	child!0
}
proctype Etag271(Mutexdef o_propsMu;chan child) {
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

