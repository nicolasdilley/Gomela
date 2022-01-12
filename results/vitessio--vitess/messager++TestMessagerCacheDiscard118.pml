// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vttablet/tabletserver/messager/cache_test.go#L118
#define not_found_127  -2 // opt ids line 170
#define not_found_153  -2 // opt ids line 170
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMessagerCacheDiscard1180 = [1] of {int};
	run TestMessagerCacheDiscard118(child_TestMessagerCacheDiscard1180);
	run receiver(child_TestMessagerCacheDiscard1180)
stop_process:skip
}

proctype TestMessagerCacheDiscard118(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Pop1479 = [1] of {int};
	chan child_Add1238 = [1] of {int};
	chan child_Discard1707 = [1] of {int};
	chan child_Pop1476 = [1] of {int};
	chan child_Add1235 = [1] of {int};
	chan child_Pop1474 = [1] of {int};
	chan child_Add1233 = [1] of {int};
	chan child_Pop1472 = [1] of {int};
	chan child_Discard1701 = [1] of {int};
	chan child_Add1230 = [1] of {int};
	Mutexdef mc_mu;
	run mutexMonitor(mc_mu);
	run Add123(mc_mu,child_Add1230);
	child_Add1230?0;
	run Discard170(mc_mu,not_found_127,child_Discard1701);
	child_Discard1701?0;
	run Pop147(mc_mu,child_Pop1472);
	child_Pop1472?0;
	run Add123(mc_mu,child_Add1233);
	child_Add1233?0;
	run Pop147(mc_mu,child_Pop1474);
	child_Pop1474?0;
	run Add123(mc_mu,child_Add1235);
	child_Add1235?0;
	run Pop147(mc_mu,child_Pop1476);
	child_Pop1476?0;
	run Discard170(mc_mu,not_found_153,child_Discard1707);
	child_Discard1707?0;
	run Add123(mc_mu,child_Add1238);
	child_Add1238?0;
	run Pop147(mc_mu,child_Pop1479);
	child_Pop1479?0;
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
proctype Discard170(Mutexdef mc_mu;int var_ids;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	mc_mu.Lock!false;
		defer1: skip;
	mc_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Pop147(Mutexdef mc_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	mc_mu.Lock!false;
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

