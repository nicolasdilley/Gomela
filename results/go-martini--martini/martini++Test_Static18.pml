// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-martini/martini/blob//static_test.go#L18
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test_Static180 = [1] of {int};
	run Test_Static18(child_Test_Static180);
	run receiver(child_Test_Static180)
stop_process:skip
}

proctype Test_Static18(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ServeHTTP742 = [1] of {int};
	chan child_Action551 = [1] of {int};
	chan child_Use670 = [1] of {int};
	Mutexdef m_logger_mu;
	run mutexMonitor(m_logger_mu);
	run Use67(m_logger_mu,child_Use670);
	child_Use670?0;
	run Action55(m_logger_mu,child_Action551);
	child_Action551?0;
	run ServeHTTP74(m_logger_mu,child_ServeHTTP742);
	child_ServeHTTP742?0;
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

