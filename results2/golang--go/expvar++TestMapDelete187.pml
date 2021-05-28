// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/expvar/expvar_test.go#L187
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMapDelete1870 = [1] of {int};
	run TestMapDelete187(child_TestMapDelete1870);
	run receiver(child_TestMapDelete1870)
stop_process:skip
}

proctype TestMapDelete187(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Do22210 = [1] of {int};
	chan child_Delete2099 = [1] of {int};
	chan child_Delete2098 = [1] of {int};
	chan child_Do2227 = [1] of {int};
	chan child_Delete2096 = [1] of {int};
	chan child_Do2225 = [1] of {int};
	chan child_Delete2094 = [1] of {int};
	chan child_Do2223 = [1] of {int};
	chan child_Add1752 = [1] of {int};
	chan child_Add1751 = [1] of {int};
	chan child_Add1750 = [1] of {int};
	Mutexdef colors_keysMu;
	Mutexdef colors_m_mu;
	run mutexMonitor(colors_m_mu);
	run mutexMonitor(colors_keysMu);
	run Add175(colors_keysMu,colors_m_mu,child_Add1750);
	child_Add1750?0;
	run Add175(colors_keysMu,colors_m_mu,child_Add1751);
	child_Add1751?0;
	run Add175(colors_keysMu,colors_m_mu,child_Add1752);
	child_Add1752?0;
	run Do222(colors_keysMu,colors_m_mu,child_Do2223);
	child_Do2223?0;
	run Delete209(colors_keysMu,colors_m_mu,child_Delete2094);
	child_Delete2094?0;
	run Do222(colors_keysMu,colors_m_mu,child_Do2225);
	child_Do2225?0;
	run Delete209(colors_keysMu,colors_m_mu,child_Delete2096);
	child_Delete2096?0;
	run Do222(colors_keysMu,colors_m_mu,child_Do2227);
	child_Do2227?0;
	run Delete209(colors_keysMu,colors_m_mu,child_Delete2098);
	child_Delete2098?0;
	run Delete209(colors_keysMu,colors_m_mu,child_Delete2099);
	child_Delete2099?0;
	run Do222(colors_keysMu,colors_m_mu,child_Do22210);
	child_Do22210?0;
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
proctype Do222(Mutexdef v_keysMu;Mutexdef v_m_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int v_keys = -2; // opt v_keys
	v_keysMu.RLock!false;
		defer1: skip;
	v_keysMu.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype Delete209(Mutexdef v_keysMu;Mutexdef v_m_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Delete2094 = [1] of {int};
	v_keysMu.Lock!false;
	

	if
	:: true -> 
		run Delete209(v_m_mu,child_Delete2094);
		child_Delete2094?0
	:: true;
	fi;
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

