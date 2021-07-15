
// https://github.com/hashicorp/packer/blob/master/builder/yandex/artifact_test.go#L45
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestArtifactState450 = [1] of {int};
	run TestArtifactState45(child_TestArtifactState450)
stop_process:skip
}

proctype TestArtifactState45(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_State372 = [1] of {int};
	chan child_State371 = [1] of {int};
	chan child_State370 = [1] of {int};
	Mutexdef artifact_Image_Os_state_atomicMessageInfo_initMu;
	Mutexdef artifact_Image_CreatedAt_state_atomicMessageInfo_initMu;
	Mutexdef artifact_Image_state_atomicMessageInfo_initMu;
	run mutexMonitor(artifact_Image_state_atomicMessageInfo_initMu);
	run mutexMonitor(artifact_Image_CreatedAt_state_atomicMessageInfo_initMu);
	run mutexMonitor(artifact_Image_Os_state_atomicMessageInfo_initMu);
	run State37(artifact_Image_state_atomicMessageInfo_initMu,artifact_Image_CreatedAt_state_atomicMessageInfo_initMu,artifact_Image_Os_state_atomicMessageInfo_initMu,child_State370);
	child_State370?0;
	run State37(artifact_Image_state_atomicMessageInfo_initMu,artifact_Image_CreatedAt_state_atomicMessageInfo_initMu,artifact_Image_Os_state_atomicMessageInfo_initMu,child_State371);
	child_State371?0;
	run State37(artifact_Image_state_atomicMessageInfo_initMu,artifact_Image_CreatedAt_state_atomicMessageInfo_initMu,artifact_Image_Os_state_atomicMessageInfo_initMu,child_State372);
	child_State372?0;
	stop_process: skip;
	child!0
}
proctype State37(Mutexdef a_Image_state_atomicMessageInfo_initMu;Mutexdef a_Image_CreatedAt_state_atomicMessageInfo_initMu;Mutexdef a_Image_Os_state_atomicMessageInfo_initMu;chan child) {
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
	:: true -> 
		goto stop_process
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

