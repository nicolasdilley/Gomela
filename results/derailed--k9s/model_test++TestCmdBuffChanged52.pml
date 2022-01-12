// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/model/cmd_buff_test.go#L52
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCmdBuffChanged520 = [1] of {int};
	run TestCmdBuffChanged52(child_TestCmdBuffChanged520);
	run receiver(child_TestCmdBuffChanged520)
stop_process:skip
}

proctype TestCmdBuffChanged52(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Empty15311 = [1] of {int};
	chan child_GetText7510 = [1] of {int};
	chan child_Reset1469 = [1] of {int};
	chan child_Add868 = [1] of {int};
	chan child_GetText757 = [1] of {int};
	chan child_ClearText1366 = [1] of {int};
	chan child_Add865 = [1] of {int};
	chan child_GetText754 = [1] of {int};
	chan child_Delete1093 = [1] of {int};
	chan child_GetText752 = [1] of {int};
	chan child_Add861 = [1] of {int};
	chan child_AddListener1610 = [1] of {int};
	Mutexdef b_mx;
	run mutexMonitor(b_mx);
	run AddListener161(b_mx,child_AddListener1610);
	child_AddListener1610?0;
	run Add86(b_mx,child_Add861);
	child_Add861?0;
	run GetText75(b_mx,child_GetText752);
	child_GetText752?0;
	run Delete109(b_mx,child_Delete1093);
	child_Delete1093?0;
	run GetText75(b_mx,child_GetText754);
	child_GetText754?0;
	run Add86(b_mx,child_Add865);
	child_Add865?0;
	run ClearText136(b_mx,child_ClearText1366);
	child_ClearText1366?0;
	run GetText75(b_mx,child_GetText757);
	child_GetText757?0;
	run Add86(b_mx,child_Add868);
	child_Add868?0;
	run Reset146(b_mx,child_Reset1469);
	child_Reset1469?0;
	run GetText75(b_mx,child_GetText7510);
	child_GetText7510?0;
	run Empty153(b_mx,child_Empty15311);
	child_Empty15311?0;
	stop_process: skip;
	child!0
}
proctype AddListener161(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mx.Lock!false;
		defer1: skip;
	c_mx.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Add86(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousAdd9702 = [1] of {int};
	chan child_fireBufferChanged1931 = [1] of {int};
	c_mx.Lock!false;
	run fireBufferChanged193(c_mx,child_fireBufferChanged1931);
	child_fireBufferChanged1931?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run AnonymousAdd970(c_mx,child_AnonymousAdd9702);
	run receiver(child_AnonymousAdd9702);
		defer1: skip;
	c_mx.Unlock!false;
	stop_process: skip;
	child!0
}
proctype fireBufferChanged193(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetText751 = [1] of {int};
	int var_c_listeners = -2; // opt var_c_listeners
	run GetText75(c_mx,child_GetText751);
	child_GetText751?0;
	stop_process: skip;
	child!0
}
proctype GetText75(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousAdd970(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mx.Lock!false;
	c_mx.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Delete109(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousDelete12405 = [1] of {int};
	chan child_fireBufferChanged1934 = [1] of {int};
	chan child_Empty1533 = [1] of {int};
	c_mx.Lock!false;
	run Empty153(c_mx,child_Empty1533);
	child_Empty1533?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run fireBufferChanged193(c_mx,child_fireBufferChanged1934);
	child_fireBufferChanged1934?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run AnonymousDelete1240(c_mx,child_AnonymousDelete12405);
	run receiver(child_AnonymousDelete12405);
		defer1: skip;
	c_mx.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Empty153(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousDelete1240(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mx.Lock!false;
	c_mx.Unlock!false;
	stop_process: skip;
	child!0
}
proctype ClearText136(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireBufferCompleted1866 = [1] of {int};
	c_mx.Lock!false;
	

	if
	:: true -> 
		run fireBufferCompleted186(c_mx,child_fireBufferCompleted1866);
		child_fireBufferCompleted1866?0
	:: true;
	fi;
		defer1: skip;
	c_mx.Unlock!false;
	stop_process: skip;
	child!0
}
proctype fireBufferCompleted186(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetText756 = [1] of {int};
	int var_c_listeners = -2; // opt var_c_listeners
	run GetText75(c_mx,child_GetText756);
	child_GetText756?0;
	stop_process: skip;
	child!0
}
proctype Reset146(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireBufferCompleted18611 = [1] of {int};
	chan child_SetActive6910 = [1] of {int};
	chan child_ClearText1369 = [1] of {int};
	run ClearText136(c_mx,child_ClearText1369);
	child_ClearText1369?0;
	run SetActive69(c_mx,child_SetActive6910);
	child_SetActive6910?0;
	run fireBufferCompleted186(c_mx,child_fireBufferCompleted18611);
	child_fireBufferCompleted18611?0;
	stop_process: skip;
	child!0
}
proctype SetActive69(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireActive20010 = [1] of {int};
	run fireActive200(c_mx,child_fireActive20010);
	child_fireActive20010?0;
	stop_process: skip;
	child!0
}
proctype fireActive200(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_c_listeners = -2; // opt var_c_listeners
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

