// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/pools/numbered_test.go#L29
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNumberedGeneral290 = [1] of {int};
	run TestNumberedGeneral29(child_TestNumberedGeneral290);
	run receiver(child_TestNumberedGeneral290)
stop_process:skip
}

proctype TestNumberedGeneral29(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WaitForEmpty21324 = [1] of {int};
	chan child_AnonymousTestNumberedGeneral1003123 = [1] of {int};
	chan child_Size22722 = [1] of {int};
	chan child_Size22721 = [1] of {int};
	chan child_Unregister8720 = [1] of {int};
	chan child_Get11219 = [1] of {int};
	chan child_GetIdle19518 = [1] of {int};
	chan child_Put13217 = [1] of {int};
	chan child_Put13215 = [1] of {int};
	chan child_Put13216 = [1] of {int};
	chan child_Get11214 = [1] of {int};
	chan child_GetOutdated17513 = [1] of {int};
	chan child_Register6512 = [1] of {int};
	chan child_Register6511 = [1] of {int};
	chan child_Register6510 = [1] of {int};
	chan child_Register659 = [1] of {int};
	chan child_Get1128 = [1] of {int};
	chan child_Unregister877 = [1] of {int};
	chan child_Unregister876 = [1] of {int};
	chan child_Get1125 = [1] of {int};
	chan child_Put1324 = [1] of {int};
	chan child_Get1123 = [1] of {int};
	chan child_Get1122 = [1] of {int};
	chan child_Register651 = [1] of {int};
	chan child_Register650 = [1] of {int};
	Mutexdef p_recentlyUnregistered_mu;
	Mutexdef p_mu;
	int var_vals = -2; // opt var_vals
	run mutexMonitor(p_mu);
	run mutexMonitor(p_recentlyUnregistered_mu);
	run Register65(p_mu,p_recentlyUnregistered_mu,child_Register650);
	child_Register650?0;
	run Register65(p_mu,p_recentlyUnregistered_mu,child_Register651);
	child_Register651?0;
	run Get112(p_mu,p_recentlyUnregistered_mu,child_Get1122);
	child_Get1122?0;
	run Get112(p_mu,p_recentlyUnregistered_mu,child_Get1123);
	child_Get1123?0;
	run Put132(p_mu,p_recentlyUnregistered_mu,child_Put1324);
	child_Put1324?0;
	run Get112(p_mu,p_recentlyUnregistered_mu,child_Get1125);
	child_Get1125?0;
	run Unregister87(p_mu,p_recentlyUnregistered_mu,child_Unregister876);
	child_Unregister876?0;
	run Unregister87(p_mu,p_recentlyUnregistered_mu,child_Unregister877);
	child_Unregister877?0;
	run Get112(p_mu,p_recentlyUnregistered_mu,child_Get1128);
	child_Get1128?0;
	run Register65(p_mu,p_recentlyUnregistered_mu,child_Register659);
	child_Register659?0;
	run Register65(p_mu,p_recentlyUnregistered_mu,child_Register6510);
	child_Register6510?0;
	run Register65(p_mu,p_recentlyUnregistered_mu,child_Register6511);
	child_Register6511?0;
	run Register65(p_mu,p_recentlyUnregistered_mu,child_Register6512);
	child_Register6512?0;
	run GetOutdated175(p_mu,p_recentlyUnregistered_mu,child_GetOutdated17513);
	child_GetOutdated17513?0;
	run Get112(p_mu,p_recentlyUnregistered_mu,child_Get11214);
	child_Get11214?0;
	

	if
	:: var_vals-1 != -3 -> 
				for(i : 0.. var_vals-1) {
			for20: skip;
			run Put132(p_mu,p_recentlyUnregistered_mu,child_Put13215);
			child_Put13215?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			run Put132(p_mu,p_recentlyUnregistered_mu,child_Put13216);
			child_Put13216?0;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	run Put132(p_mu,p_recentlyUnregistered_mu,child_Put13217);
	child_Put13217?0;
	run GetIdle195(p_mu,p_recentlyUnregistered_mu,child_GetIdle19518);
	child_GetIdle19518?0;
	run Get112(p_mu,p_recentlyUnregistered_mu,child_Get11219);
	child_Get11219?0;
	run Unregister87(p_mu,p_recentlyUnregistered_mu,child_Unregister8720);
	child_Unregister8720?0;
	run Size227(p_mu,p_recentlyUnregistered_mu,child_Size22721);
	child_Size22721?0;
	

	if
	:: true -> 
		run Size227(p_mu,p_recentlyUnregistered_mu,child_Size22722);
		child_Size22722?0
	:: true;
	fi;
	run AnonymousTestNumberedGeneral10031(p_mu,p_recentlyUnregistered_mu,child_AnonymousTestNumberedGeneral1003123);
	run receiver(child_AnonymousTestNumberedGeneral1003123);
	run WaitForEmpty213(p_mu,p_recentlyUnregistered_mu,child_WaitForEmpty21324);
	child_WaitForEmpty21324?0;
	stop_process: skip;
	child!0
}
proctype Register65(Mutexdef nu_mu;Mutexdef nu_recentlyUnregistered_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	nu_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	nu_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Get112(Mutexdef nu_mu;Mutexdef nu_recentlyUnregistered_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	nu_mu.Lock!false;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi;
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	nu_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Put132(Mutexdef nu_mu;Mutexdef nu_recentlyUnregistered_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	nu_mu.Lock!false;
		defer1: skip;
	nu_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Unregister87(Mutexdef nu_mu;Mutexdef nu_recentlyUnregistered_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_unregister976 = [1] of {int};
	run unregister97(nu_mu,nu_recentlyUnregistered_mu,child_unregister976);
	child_unregister976?0;
	stop_process: skip;
	child!0
}
proctype unregister97(Mutexdef nu_mu;Mutexdef nu_recentlyUnregistered_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	nu_mu.Lock!false;
	goto defer1;
		defer1: skip;
	nu_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype GetOutdated175(Mutexdef nu_mu;Mutexdef nu_recentlyUnregistered_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_nu_resources = -2; // opt var_nu_resources
	nu_mu.Lock!false;
	goto defer1;
		defer1: skip;
	nu_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype GetIdle195(Mutexdef nu_mu;Mutexdef nu_recentlyUnregistered_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_nu_resources = -2; // opt var_nu_resources
	nu_mu.Lock!false;
	goto defer1;
		defer1: skip;
	nu_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Size227(Mutexdef nu_mu;Mutexdef nu_recentlyUnregistered_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	nu_mu.Lock!false;
	goto defer1;
		defer1: skip;
	nu_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype AnonymousTestNumberedGeneral10031(Mutexdef p_mu;Mutexdef p_recentlyUnregistered_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Unregister8725 = [1] of {int};
	chan child_Unregister8724 = [1] of {int};
	chan child_Unregister8723 = [1] of {int};
	run Unregister87(p_mu,p_recentlyUnregistered_mu,child_Unregister8723);
	child_Unregister8723?0;
	run Unregister87(p_mu,p_recentlyUnregistered_mu,child_Unregister8724);
	child_Unregister8724?0;
	run Unregister87(p_mu,p_recentlyUnregistered_mu,child_Unregister8725);
	child_Unregister8725?0;
	stop_process: skip;
	child!0
}
proctype WaitForEmpty213(Mutexdef nu_mu;Mutexdef nu_recentlyUnregistered_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	nu_mu.Lock!false;
		defer1: skip;
	nu_mu.Unlock!false;
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

