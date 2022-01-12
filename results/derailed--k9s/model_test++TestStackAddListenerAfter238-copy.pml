// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/model/stack_test.go#L238
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStackAddListenerAfter2380 = [1] of {int};
	run TestStackAddListenerAfter238(child_TestStackAddListenerAfter2380);
	run receiver(child_TestStackAddListenerAfter2380)
stop_process:skip
}

proctype TestStackAddListenerAfter238(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AddListener812 = [1] of {int};
	chan child_Push890 = [1] of {int};
	chan child_Push891 = [1] of {int};
	Mutexdef s_mx;
	int var_items = -2; // opt var_items
	run mutexMonitor(s_mx);
	

	if
	:: var_items-1 != -3 -> 
				for(i : 0.. var_items-1) {
			for10: skip;
			run Push89(s_mx,child_Push890);
			child_Push890?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			run Push89(s_mx,child_Push891);
			child_Push891?0;
			for13_end: skip
		:: true -> 
			break
		od;
		for13_exit: skip
	fi;
	run AddListener81(s_mx,child_AddListener812);
	child_AddListener812?0;
	stop_process: skip;
	child!0
}
proctype Push89(Mutexdef s_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_notify1691 = [1] of {int};
	chan child_Top1610 = [1] of {int};
	run Top161(s_mx,child_Top1610);
	child_Top1610?0;
	s_mx.Lock!false;
	s_mx.Unlock!false;
	run notify169(s_mx,child_notify1691);
	child_notify1691?0;
	stop_process: skip;
	child!0
}
proctype Top161(Mutexdef s_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Empty1360 = [1] of {int};
	run Empty136(s_mx,child_Empty1360);
	child_Empty1360?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Empty136(Mutexdef s_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mx.RLock!false;
	goto defer1;
		defer1: skip;
	s_mx.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype notify169(Mutexdef s_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Top1611 = [1] of {int};
	chan child_Top1612 = [1] of {int};
	int var_s_listeners = -2; // opt var_s_listeners
	

	if
	:: var_s_listeners-1 != -3 -> 
				for(i : 0.. var_s_listeners-1) {
			for11: skip;
			

			if
			:: true;
			:: true -> 
				run Top161(s_mx,child_Top1611);
				child_Top1611?0
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for12: skip;
			

			if
			:: true;
			:: true -> 
				run Top161(s_mx,child_Top1612);
				child_Top1612?0
			fi;
			for12_end: skip
		:: true -> 
			break
		od;
		for12_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype AddListener81(Mutexdef s_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Top1613 = [1] of {int};
	chan child_Empty1362 = [1] of {int};
	run Empty136(s_mx,child_Empty1362);
	child_Empty1362?0;
	

	if
	:: true -> 
		run Top161(s_mx,child_Top1613);
		child_Top1613?0
	:: true;
	fi;
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

