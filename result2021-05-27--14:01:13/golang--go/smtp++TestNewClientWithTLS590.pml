// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/smtp/smtp_test.go#L590
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNewClientWithTLS5900 = [1] of {int};
	run TestNewClientWithTLS590(child_TestNewClientWithTLS5900);
	run receiver(child_TestNewClientWithTLS5900)
stop_process:skip
}

proctype TestNewClientWithTLS590(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close751 = [1] of {int};
	chan child_NewClient622 = [1] of {int};
	Mutexdef conn_config_mutex;
	Mutexdef conn_handshakeMutex;
	chan child_AnonymousTestNewClientWithTLS6065960 = [1] of {int};
	Mutexdef config_mutex;
	run mutexMonitor(config_mutex);
	run AnonymousTestNewClientWithTLS606596(config_mutex,child_AnonymousTestNewClientWithTLS6065960);
	run receiver(child_AnonymousTestNewClientWithTLS6065960);
	run mutexMonitor(conn_handshakeMutex);
	run mutexMonitor(conn_config_mutex);
	run NewClient62(conn_config_mutex,conn_handshakeMutex,child_NewClient622);
	child_NewClient622?0;
		defer1: skip;
	run Close75(conn_config_mutex,conn_handshakeMutex,child_Close751);
	child_Close751?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestNewClientWithTLS606596(Mutexdef config_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype Close75(Mutexdef c_config_mutex;Mutexdef c_handshakeMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewClient62(Mutexdef conn_config_mutex;Mutexdef conn_handshakeMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewConn662 = [1] of {int};
	run NewConn66(conn_config_mutex,conn_handshakeMutex,child_NewConn662);
	child_NewConn662?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewConn66(Mutexdef conn_config_mutex;Mutexdef conn_handshakeMutex;chan child) {
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

