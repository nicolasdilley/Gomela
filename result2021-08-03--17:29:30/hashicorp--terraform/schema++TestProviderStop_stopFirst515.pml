// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/internal/legacy/helper/schema/provider_test.go#L515
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestProviderStop_stopFirst5150 = [1] of {int};
	run TestProviderStop_stopFirst515(child_TestProviderStop_stopFirst5150);
	run receiver(child_TestProviderStop_stopFirst5150)
stop_process:skip
}

proctype TestProviderStop_stopFirst515(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stopped1531 = [1] of {int};
	chan child_Stop1810 = [1] of {int};
	Mutexdef p_stopOnce_m;
	Mutexdef p_stopMu;
	run mutexMonitor(p_stopMu);
	run mutexMonitor(p_stopOnce_m);
	run Stop181(p_stopMu,p_stopOnce_m,child_Stop1810);
	child_Stop1810?0;
	run Stopped153(p_stopMu,p_stopOnce_m,child_Stopped1531);
	child_Stopped1531?0;
	do
	:: true -> 
		break
	:: true -> 
		break
	od;
	for20_exit: skip;
	for20_end: skip;
	stop_process: skip;
	child!0
}
proctype Stop181(Mutexdef p_stopMu;Mutexdef p_stopOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	p_stopMu.Lock!false;
	goto defer1;
		defer1: skip;
	p_stopMu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Stopped153(Mutexdef p_stopMu;Mutexdef p_stopOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_StopContext1641 = [1] of {int};
	run StopContext164(p_stopMu,p_stopOnce_m,child_StopContext1641);
	child_StopContext1641?0;
	do
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od;
	for10_exit: skip;
	for10_end: skip;
	stop_process: skip;
	child!0
}
proctype StopContext164(Mutexdef p_stopMu;Mutexdef p_stopOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	p_stopMu.Lock!false;
	goto defer1;
		defer1: skip;
	p_stopMu.Unlock!false;
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

