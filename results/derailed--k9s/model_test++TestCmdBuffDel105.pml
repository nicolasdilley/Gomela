// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/model/cmd_buff_test.go#L105
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCmdBuffDel1050 = [1] of {int};
	run TestCmdBuffDel105(child_TestCmdBuffDel1050);
	run receiver(child_TestCmdBuffDel1050)
stop_process:skip
}

proctype TestCmdBuffDel105(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Reset1464 = [1] of {int};
	chan child_GetText753 = [1] of {int};
	chan child_Delete1092 = [1] of {int};
	chan child_Add860 = [1] of {int};
	chan child_Add861 = [1] of {int};
	chan child_Reset1469 = [1] of {int};
	chan child_GetText758 = [1] of {int};
	chan child_Delete1097 = [1] of {int};
	chan child_Add865 = [1] of {int};
	chan child_Add866 = [1] of {int};
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
			run Delete109(b_mx,child_Delete1092);
			child_Delete1092?0;
			run GetText75(b_mx,child_GetText753);
			child_GetText753?0;
			run Reset146(b_mx,child_Reset1464);
			child_Reset1464?0;
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
					run Add86(b_mx,child_Add865);
					child_Add865?0;
					for110_end: skip
				};
				for110_exit: skip
			:: else -> 
				do
				:: true -> 
					for111: skip;
					run Add86(b_mx,child_Add866);
					child_Add866?0;
					for111_end: skip
				:: true -> 
					break
				od;
				for111_exit: skip
			fi;
			run Delete109(b_mx,child_Delete1097);
			child_Delete1097?0;
			run GetText75(b_mx,child_GetText758);
			child_GetText758?0;
			run Reset146(b_mx,child_Reset1469);
			child_Reset1469?0;
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
proctype Delete109(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousDelete12404 = [1] of {int};
	chan child_fireBufferChanged1933 = [1] of {int};
	chan child_Empty1532 = [1] of {int};
	c_mx.Lock!false;
	run Empty153(c_mx,child_Empty1532);
	child_Empty1532?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run fireBufferChanged193(c_mx,child_fireBufferChanged1933);
	child_fireBufferChanged1933?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run AnonymousDelete1240(c_mx,child_AnonymousDelete12404);
	run receiver(child_AnonymousDelete12404);
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
proctype Reset146(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireBufferCompleted1866 = [1] of {int};
	chan child_SetActive695 = [1] of {int};
	chan child_ClearText1364 = [1] of {int};
	run ClearText136(c_mx,child_ClearText1364);
	child_ClearText1364?0;
	run SetActive69(c_mx,child_SetActive695);
	child_SetActive695?0;
	run fireBufferCompleted186(c_mx,child_fireBufferCompleted1866);
	child_fireBufferCompleted1866?0;
	stop_process: skip;
	child!0
}
proctype ClearText136(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireBufferCompleted1864 = [1] of {int};
	c_mx.Lock!false;
	

	if
	:: true -> 
		run fireBufferCompleted186(c_mx,child_fireBufferCompleted1864);
		child_fireBufferCompleted1864?0
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
	chan child_GetText754 = [1] of {int};
	int var_c_listeners = -2; // opt var_c_listeners
	run GetText75(c_mx,child_GetText754);
	child_GetText754?0;
	stop_process: skip;
	child!0
}
proctype SetActive69(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fireActive2005 = [1] of {int};
	run fireActive200(c_mx,child_fireActive2005);
	child_fireActive2005?0;
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

