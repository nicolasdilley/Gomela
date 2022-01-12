// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/model/cmd_buff_test.go#L84
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCmdBuffAdd840 = [1] of {int};
	run TestCmdBuffAdd84(child_TestCmdBuffAdd840);
	run receiver(child_TestCmdBuffAdd840)
stop_process:skip
}

proctype TestCmdBuffAdd84(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Reset1463 = [1] of {int};
	chan child_GetText752 = [1] of {int};
	chan child_Add860 = [1] of {int};
	chan child_Add861 = [1] of {int};
	chan child_Reset1467 = [1] of {int};
	chan child_GetText756 = [1] of {int};
	chan child_Add864 = [1] of {int};
	chan child_Add865 = [1] of {int};
	Mutexdef b_mx;
	int var_u_runes = -2; // opt var_u_runes
	int var_uu = -2; // opt var_uu
	run mutexMonitor(b_mx);
	

	if
	:: var_uu-1 != -3 -> 
				for(i : 0.. var_uu-1) {
			for10: skip;
			

			if
			:: var_u_runes-1 != -3 -> 
								for(i : 0.. var_u_runes-1) {
					for11: skip;
					run Add86(b_mx,child_Add860);
					child_Add860?0;
					for11_end: skip
				};
				for11_exit: skip
			:: else -> 
				do
				:: true -> 
					for14: skip;
					run Add86(b_mx,child_Add861);
					child_Add861?0;
					for14_end: skip
				:: true -> 
					break
				od;
				for14_exit: skip
			fi;
			run GetText75(b_mx,child_GetText752);
			child_GetText752?0;
			run Reset146(b_mx,child_Reset1463);
			child_Reset1463?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for19: skip;
			

			if
			:: var_u_runes-1 != -3 -> 
								for(i : 0.. var_u_runes-1) {
					for110: skip;
					run Add86(b_mx,child_Add864);
					child_Add864?0;
					for110_end: skip
				};
				for110_exit: skip
			:: else -> 
				do
				:: true -> 
					for111: skip;
					run Add86(b_mx,child_Add865);
					child_Add865?0;
					for111_end: skip
				:: true -> 
					break
				od;
				for111_exit: skip
			fi;
			run GetText75(b_mx,child_GetText756);
			child_GetText756?0;
			run Reset146(b_mx,child_Reset1467);
			child_Reset1467?0;
			for19_end: skip
		:: true -> 
			break
		od;
		for19_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype Add86(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousAdd9701 = [1] of {int};
	chan child_fireBufferChanged1930 = [1] of {int};
	c_mx.Lock!false;
	run fireBufferChanged193(c_mx,child_fireBufferChanged1930);
	child_fireBufferChanged1930?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run AnonymousAdd970(c_mx,child_AnonymousAdd9701);
	run receiver(child_AnonymousAdd9701);
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
	chan child_GetText750 = [1] of {int};
	int var_c_listeners = -2; // opt var_c_listeners
	run GetText75(c_mx,child_GetText750);
	child_GetText750?0;
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
proctype Reset146(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireBufferCompleted1865 = [1] of {int};
	chan child_SetActive694 = [1] of {int};
	chan child_ClearText1363 = [1] of {int};
	run ClearText136(c_mx,child_ClearText1363);
	child_ClearText1363?0;
	run SetActive69(c_mx,child_SetActive694);
	child_SetActive694?0;
	run fireBufferCompleted186(c_mx,child_fireBufferCompleted1865);
	child_fireBufferCompleted1865?0;
	stop_process: skip;
	child!0
}
proctype ClearText136(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireBufferCompleted1863 = [1] of {int};
	c_mx.Lock!false;
	

	if
	:: true -> 
		run fireBufferCompleted186(c_mx,child_fireBufferCompleted1863);
		child_fireBufferCompleted1863?0
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
	chan child_GetText753 = [1] of {int};
	int var_c_listeners = -2; // opt var_c_listeners
	run GetText75(c_mx,child_GetText753);
	child_GetText753?0;
	stop_process: skip;
	child!0
}
proctype SetActive69(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireActive2004 = [1] of {int};
	run fireActive200(c_mx,child_fireActive2004);
	child_fireActive2004?0;
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

