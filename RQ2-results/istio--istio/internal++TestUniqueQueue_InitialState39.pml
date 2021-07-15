
// https://github.com/istio/istio/blob/master/pkg/mcp/internal/queue_test.go#L39
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUniqueQueue_InitialState390 = [1] of {int};
	run TestUniqueQueue_InitialState39(child_TestUniqueQueue_InitialState390)
stop_process:skip
}

proctype TestUniqueQueue_InitialState39(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Dequeue1612 = [1] of {int};
	chan child_Full1061 = [1] of {int};
	chan child_Empty900 = [1] of {int};
	Mutexdef q_mu;
	run mutexMonitor(q_mu);
	run Empty90(q_mu,child_Empty900);
	child_Empty900?0;
	run Full106(q_mu,child_Full1061);
	child_Full1061?0;
	run Dequeue161(q_mu,child_Dequeue1612);
	child_Dequeue1612?0;
	stop_process: skip;
	child!0
}
proctype Empty90(Mutexdef q_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	q_mu.Lock!false;
	goto stop_process;
	stop_process: skip;
		q_mu.Unlock!false;
	child!0
}
proctype Full106(Mutexdef q_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_full1001 = [1] of {int};
	q_mu.Lock!false;
	run full100(q_mu,child_full1001);
	child_full1001?0;
	goto stop_process;
	stop_process: skip;
		q_mu.Unlock!false;
	child!0
}
proctype full100(Mutexdef q_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_inc851 = [1] of {int};
	run inc85(q_mu,child_inc851);
	child_inc851?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype inc85(Mutexdef q_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Dequeue161(Mutexdef q_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_inc852 = [1] of {int};
	q_mu.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run inc85(q_mu,child_inc852);
	child_inc852?0;
	goto stop_process;
	stop_process: skip;
		q_mu.Unlock!false;
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

