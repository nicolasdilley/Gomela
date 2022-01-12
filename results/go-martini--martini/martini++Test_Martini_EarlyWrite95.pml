// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-martini/martini/blob//martini_test.go#L95
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test_Martini_EarlyWrite950 = [1] of {int};
	run Test_Martini_EarlyWrite95(child_Test_Martini_EarlyWrite950);
	run receiver(child_Test_Martini_EarlyWrite950)
stop_process:skip
}

proctype Test_Martini_EarlyWrite95(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ServeHTTP743 = [1] of {int};
	chan child_Action552 = [1] of {int};
	chan child_Use671 = [1] of {int};
	chan child_Use670 = [1] of {int};
	Mutexdef m_logger_mu;
	run mutexMonitor(m_logger_mu);
	run Use67(m_logger_mu,child_Use670);
	child_Use670?0;
	run Use67(m_logger_mu,child_Use671);
	child_Use671?0;
	run Action55(m_logger_mu,child_Action552);
	child_Action552?0;
	run ServeHTTP74(m_logger_mu,child_ServeHTTP743);
	child_ServeHTTP743?0;
	stop_process: skip;
	child!0
}
proctype Use67(Mutexdef m_logger_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Action55(Mutexdef m_logger_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype ServeHTTP74(Mutexdef m_logger_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

