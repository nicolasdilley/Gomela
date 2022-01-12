// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//expvar/expvar_test.go#L445
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHandler4450 = [1] of {int};
	run TestHandler445(child_TestHandler4450);
	run receiver(child_TestHandler4450)
stop_process:skip
}

proctype TestHandler445(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Add1753 = [1] of {int};
	chan child_Add1752 = [1] of {int};
	Mutexdef m2_keysMu;
	Mutexdef m2_m_mu;
	chan child_Add1751 = [1] of {int};
	chan child_Add1750 = [1] of {int};
	Mutexdef m_keysMu;
	Mutexdef m_m_mu;
	run mutexMonitor(m_m_mu);
	run mutexMonitor(m_keysMu);
	run Add175(m_keysMu,m_m_mu,child_Add1750);
	child_Add1750?0;
	run Add175(m_keysMu,m_m_mu,child_Add1751);
	child_Add1751?0;
	run mutexMonitor(m2_m_mu);
	run mutexMonitor(m2_keysMu);
	

	if
	:: 0 != -2 && 9-1 != -3 -> 
				for(i : 0.. 9-1) {
			for11: skip;
			run Add175(m2_keysMu,m2_m_mu,child_Add1753);
			child_Add1753?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Add175(m2_keysMu,m2_m_mu,child_Add1752);
			child_Add1752?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype Add175(Mutexdef v_keysMu;Mutexdef v_m_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_addKey1410 = [1] of {int};
	

	if
	:: true -> 
		

		if
		:: true -> 
			run addKey141(v_keysMu,v_m_mu,child_addKey1410);
			child_addKey1410?0
		:: true;
		fi
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype addKey141(Mutexdef v_keysMu;Mutexdef v_m_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	v_keysMu.Lock!false;
		defer1: skip;
	v_keysMu.Unlock!false;
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

