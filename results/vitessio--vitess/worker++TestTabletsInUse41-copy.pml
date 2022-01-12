// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/vitessio/vitess/blob//go/vt/worker/tablet_tracker_test.go#L41
#define not_found_44  -2 // opt stats line 53
#define not_found_49  -2 // opt stats line 53
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTabletsInUse410 = [1] of {int};
	run TestTabletsInUse41(child_TestTabletsInUse410);
	run receiver(child_TestTabletsInUse410)
stop_process:skip
}

proctype TestTabletsInUse41(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TabletsInUse1033 = [1] of {int};
	chan child_Track532 = [1] of {int};
	chan child_TabletsInUse1031 = [1] of {int};
	chan child_Track530 = [1] of {int};
	Mutexdef tt_mu;
	run mutexMonitor(tt_mu);
	run Track53(tt_mu,not_found_44,child_Track530);
	child_Track530?0;
	run TabletsInUse103(tt_mu,child_TabletsInUse1031);
	child_TabletsInUse1031?0;
	run Track53(tt_mu,not_found_49,child_Track532);
	child_Track532?0;
	run TabletsInUse103(tt_mu,child_TabletsInUse1033);
	child_TabletsInUse1033?0;
	stop_process: skip;
	child!0
}
proctype Track53(Mutexdef t_mu;int var_stats;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_t_tabletsByUsage = -2; // opt var_t_tabletsByUsage
	t_mu.Lock!false;
		defer1: skip;
	t_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype TabletsInUse103(Mutexdef t_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_t_usedTablets = -2; // opt var_t_usedTablets
	t_mu.Lock!false;
	goto defer1;
		defer1: skip;
	t_mu.Unlock!false;
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

