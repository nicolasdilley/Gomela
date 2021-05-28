// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/p2p/discover/v4_udp_test.go#L135
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
	chan child_TestUDPv4_packetErrors1350 = [1] of {int};
	run TestUDPv4_packetErrors135(child_TestUDPv4_packetErrors1350);
	run receiver(child_TestUDPv4_packetErrors1350)
stop_process:skip
}

proctype TestUDPv4_packetErrors135(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_close820 = [1] of {int};
	chan child_packetIn884 = [1] of {int};
	chan child_packetIn883 = [1] of {int};
	chan child_packetIn882 = [1] of {int};
	chan child_packetIn881 = [1] of {int};
	Wgdef test_udp_wg;
	Mutexdef test_table_mutex;
	Mutexdef test_pipe_mu;
	run mutexMonitor(test_pipe_mu);
	run mutexMonitor(test_table_mutex);
	run wgMonitor(test_udp_wg);
	run packetIn88(test_udp_wg,test_pipe_mu,test_table_mutex,child_packetIn881);
	child_packetIn881?0;
	run packetIn88(test_udp_wg,test_pipe_mu,test_table_mutex,child_packetIn882);
	child_packetIn882?0;
	run packetIn88(test_udp_wg,test_pipe_mu,test_table_mutex,child_packetIn883);
	child_packetIn883?0;
	run packetIn88(test_udp_wg,test_pipe_mu,test_table_mutex,child_packetIn884);
	child_packetIn884?0;
		defer1: skip;
	run close82(test_udp_wg,test_pipe_mu,test_table_mutex,child_close820);
	child_close820?0;
	stop_process: skip;
	child!0
}
proctype close82(Wgdef test_udp_wg;Mutexdef test_pipe_mu;Mutexdef test_table_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close1650 = [1] of {int};
	run Close165(test_udp_wg,child_Close1650);
	child_Close1650?0;
	stop_process: skip;
	child!0
}
proctype Close165(Wgdef t_wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype packetIn88(Wgdef test_udp_wg;Mutexdef test_pipe_mu;Mutexdef test_table_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_packetInFrom951 = [1] of {int};
	run packetInFrom95(test_udp_wg,test_pipe_mu,test_table_mutex,child_packetInFrom951);
	child_packetInFrom951?0;
	stop_process: skip;
	child!0
}
proctype packetInFrom95(Wgdef test_udp_wg;Mutexdef test_pipe_mu;Mutexdef test_table_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_handlePacket5451 = [1] of {int};
	run handlePacket545(test_udp_wg,child_handlePacket5451);
	child_handlePacket5451?0;
	stop_process: skip;
	child!0
}
proctype handlePacket545(Wgdef t_wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_wrapPacket6091 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wrapPacket609(t_wg,child_wrapPacket6091);
	child_wrapPacket6091?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype wrapPacket609(Wgdef t_wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
	goto stop_process;
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

