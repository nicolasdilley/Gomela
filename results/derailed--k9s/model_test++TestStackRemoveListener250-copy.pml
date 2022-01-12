// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/model/stack_test.go#L250
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStackRemoveListener2500 = [1] of {int};
	run TestStackRemoveListener250(child_TestStackRemoveListener2500);
	run receiver(child_TestStackRemoveListener2500)
stop_process:skip
}

proctype TestStackRemoveListener250(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Push895 = [1] of {int};
	chan child_RemoveListener664 = [1] of {int};
	chan child_RemoveListener663 = [1] of {int};
	chan child_RemoveListener662 = [1] of {int};
	chan child_AddListener811 = [1] of {int};
	chan child_AddListener810 = [1] of {int};
	Mutexdef s_mx;
	run mutexMonitor(s_mx);
	run AddListener81(s_mx,child_AddListener810);
	child_AddListener810?0;
	run AddListener81(s_mx,child_AddListener811);
	child_AddListener811?0;
	run RemoveListener66(s_mx,child_RemoveListener662);
	child_RemoveListener662?0;
	run RemoveListener66(s_mx,child_RemoveListener663);
	child_RemoveListener663?0;
	run RemoveListener66(s_mx,child_RemoveListener664);
	child_RemoveListener664?0;
	run Push89(s_mx,child_Push895);
	child_Push895?0;
	stop_process: skip;
	child!0
}
proctype AddListener81(Mutexdef s_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Top1611 = [1] of {int};
	chan child_Empty1360 = [1] of {int};
	run Empty136(s_mx,child_Empty1360);
	child_Empty1360?0;
	

	if
	:: true -> 
		run Top161(s_mx,child_Top1611);
		child_Top1611?0
	:: true;
	fi;
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
proctype Top161(Mutexdef s_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Empty1361 = [1] of {int};
	run Empty136(s_mx,child_Empty1361);
	child_Empty1361?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype RemoveListener66(Mutexdef s_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_s_listeners = -2; // opt var_s_listeners
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype Push89(Mutexdef s_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_notify1696 = [1] of {int};
	chan child_Top1615 = [1] of {int};
	run Top161(s_mx,child_Top1615);
	child_Top1615?0;
	s_mx.Lock!false;
	s_mx.Unlock!false;
	run notify169(s_mx,child_notify1696);
	child_notify1696?0;
	stop_process: skip;
	child!0
}
proctype notify169(Mutexdef s_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Top1616 = [1] of {int};
	chan child_Top1617 = [1] of {int};
	int var_s_listeners = -2; // opt var_s_listeners
	

	if
	:: var_s_listeners-1 != -3 -> 
				for(i : 0.. var_s_listeners-1) {
			for20: skip;
			

			if
			:: true;
			:: true -> 
				run Top161(s_mx,child_Top1616);
				child_Top1616?0
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			

			if
			:: true;
			:: true -> 
				run Top161(s_mx,child_Top1617);
				child_Top1617?0
			fi;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
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

