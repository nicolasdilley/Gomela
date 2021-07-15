
// https://github.com/hashicorp/packer/blob/master/builder/yandex/artifact_test.go#L29
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestArtifact_String290 = [1] of {int};
	run TestArtifact_String29(child_TestArtifact_String290)
stop_process:skip
}

proctype TestArtifact_String29(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_String330 = [1] of {int};
	Mutexdef a_Image_Os_state_atomicMessageInfo_initMu;
	Mutexdef a_Image_CreatedAt_state_atomicMessageInfo_initMu;
	Mutexdef a_Image_state_atomicMessageInfo_initMu;
	Mutexdef i_Os_state_atomicMessageInfo_initMu;
	Mutexdef i_CreatedAt_state_atomicMessageInfo_initMu;
	Mutexdef i_state_atomicMessageInfo_initMu;
	run mutexMonitor(i_state_atomicMessageInfo_initMu);
	run mutexMonitor(i_CreatedAt_state_atomicMessageInfo_initMu);
	run mutexMonitor(i_Os_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Image_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Image_CreatedAt_state_atomicMessageInfo_initMu);
	run mutexMonitor(a_Image_Os_state_atomicMessageInfo_initMu);
	run String33(a_Image_state_atomicMessageInfo_initMu,a_Image_CreatedAt_state_atomicMessageInfo_initMu,a_Image_Os_state_atomicMessageInfo_initMu,child_String330);
	child_String330?0;
	stop_process: skip;
	child!0
}
proctype String33(Mutexdef a_Image_state_atomicMessageInfo_initMu;Mutexdef a_Image_CreatedAt_state_atomicMessageInfo_initMu;Mutexdef a_Image_Os_state_atomicMessageInfo_initMu;chan child) {
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

