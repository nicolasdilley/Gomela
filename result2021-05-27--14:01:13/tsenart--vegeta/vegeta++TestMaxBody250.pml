// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/tsenart/vegeta/blob/d73edf2bc2663d83848da2a97a8401a7ed1440bc/lib/attack_test.go#L250
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMaxBody2500 = [1] of {int};
	run TestMaxBody250(child_TestMaxBody2500);
	run receiver(child_TestMaxBody2500)
stop_process:skip
}

proctype TestMaxBody250(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close900 = [1] of {int};
	Mutexdef server_mu;
	Wgdef server_wg;
	Mutexdef server_Config_mu;
	Mutexdef server_TLS_mutex;
	int DefaultMaxBody = -2; // opt DefaultMaxBody
	int int64_len_body__ = -2; // opt int64_len_body__
	run mutexMonitor(server_TLS_mutex);
	run mutexMonitor(server_Config_mu);
	run wgMonitor(server_wg);
	run mutexMonitor(server_mu);
		defer1: skip;
	run Close90(server_wg,server_Config_mu,server_mu,server_TLS_mutex,child_Close900);
	child_Close900?0;
	stop_process: skip;
	child!0
}
proctype Close90(Wgdef m_wg;Mutexdef m_Config_mu;Mutexdef m_mu;Mutexdef m_TLS_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_init1170 = [1] of {int};
	run init117(m_wg,m_Config_mu,m_mu,m_TLS_mutex,child_init1170);
	child_init1170?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype init117(Wgdef m_wg;Mutexdef m_Config_mu;Mutexdef m_mu;Mutexdef m_TLS_mutex;chan child) {
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
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

