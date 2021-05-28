// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/sync/map_test.go#L176
#define ub_for188_2  -2
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestIssue409991760 = [1] of {int};
	run TestIssue40999176(child_TestIssue409991760);
	run receiver(child_TestIssue409991760)
stop_process:skip
}

proctype TestIssue40999176(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Delete724 = [1] of {int};
	chan child_Store373 = [1] of {int};
	chan child_Delete722 = [1] of {int};
	chan child_Store371 = [1] of {int};
	chan child_Store370 = [1] of {int};
	Mutexdef m_mu;
	run mutexMonitor(m_mu);
	run Store37(m_mu,child_Store370);
	child_Store370?0;
	

	if
	:: 0 != -2 && ub_for188_2 != -2 -> 
				for(i : 0.. ub_for188_2) {
			for11: skip;
			run Store37(m_mu,child_Store373);
			child_Store373?0;
			run Delete72(m_mu,child_Delete724);
			child_Delete724?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Store37(m_mu,child_Store371);
			child_Store371?0;
			run Delete72(m_mu,child_Delete722);
			child_Delete722?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype Store37(Mutexdef m_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	m_mu.Lock!false;
	m_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Delete72(Mutexdef m_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	m_mu.Lock!false;
	m_mu.Unlock!false;
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

