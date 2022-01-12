// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vttablet/tabletserver/messager/cache_test.go#L26
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMessagerCacheOrder260 = [1] of {int};
	run TestMessagerCacheOrder26(child_TestMessagerCacheOrder260);
	run receiver(child_TestMessagerCacheOrder260)
stop_process:skip
}

proctype TestMessagerCacheOrder26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Add1234 = [1] of {int};
	chan child_Add1233 = [1] of {int};
	chan child_Add1232 = [1] of {int};
	chan child_Add1231 = [1] of {int};
	chan child_Add1230 = [1] of {int};
	Mutexdef mc_mu;
	run mutexMonitor(mc_mu);
	run Add123(mc_mu,child_Add1230);
	child_Add1230?0;
	run Add123(mc_mu,child_Add1231);
	child_Add1231?0;
	run Add123(mc_mu,child_Add1232);
	child_Add1232?0;
	run Add123(mc_mu,child_Add1233);
	child_Add1233?0;
	run Add123(mc_mu,child_Add1234);
	child_Add1234?0;
	stop_process: skip;
	child!0
}
proctype Add123(Mutexdef mc_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	mc_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
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
	mc_mu.Unlock!false;
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

