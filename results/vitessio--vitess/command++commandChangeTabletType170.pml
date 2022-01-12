// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/cmd/vtctldclient/command/tablets.go#L170
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_commandChangeTabletType1700 = [1] of {int};
	run commandChangeTabletType170(child_commandChangeTabletType1700);
	run receiver(child_commandChangeTabletType1700)
stop_process:skip
}

proctype commandChangeTabletType170(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MarshalTabletAWK501 = [1] of {int};
	chan child_MarshalTabletAWK500 = [1] of {int};
	Mutexdef resp_AfterTablet_state_atomicMessageInfo_initMu;
	Mutexdef resp_BeforeTablet_state_atomicMessageInfo_initMu;
	Mutexdef resp_state_atomicMessageInfo_initMu;
	Mutexdef alias_state_atomicMessageInfo_initMu;
	run mutexMonitor(alias_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(resp_state_atomicMessageInfo_initMu);
	run mutexMonitor(resp_BeforeTablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(resp_AfterTablet_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run MarshalTabletAWK50(resp_BeforeTablet_state_atomicMessageInfo_initMu,child_MarshalTabletAWK500);
	child_MarshalTabletAWK500?0;
	run MarshalTabletAWK50(resp_AfterTablet_state_atomicMessageInfo_initMu,child_MarshalTabletAWK501);
	child_MarshalTabletAWK501?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype MarshalTabletAWK50(Mutexdef t_state_atomicMessageInfo_initMu;chan child) {
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

proctype receiver(chan c) {
c?0
}

