// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/p2p/discover/v4_udp_test.go#L460
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
	chan child_TestUDPv4_EIP8684600 = [1] of {int};
	run TestUDPv4_EIP868460(child_TestUDPv4_EIP8684600);
	run receiver(child_TestUDPv4_EIP8684600)
stop_process:skip
}

proctype TestUDPv4_EIP868460(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_close820 = [1] of {int};
	chan child_waitPacketOut1106 = [1] of {int};
	chan child_packetIn885 = [1] of {int};
	chan child_waitPacketOut1104 = [1] of {int};
	chan child_waitPacketOut1103 = [1] of {int};
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
	run waitPacketOut110(test_udp_wg,test_pipe_mu,test_table_mutex,child_waitPacketOut1103);
	child_waitPacketOut1103?0;
	run waitPacketOut110(test_udp_wg,test_pipe_mu,test_table_mutex,child_waitPacketOut1104);
	child_waitPacketOut1104?0;
	run packetIn88(test_udp_wg,test_pipe_mu,test_table_mutex,child_packetIn885);
	child_packetIn885?0;
	run waitPacketOut110(test_udp_wg,test_pipe_mu,test_table_mutex,child_waitPacketOut1106);
	child_waitPacketOut1106?0;
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
proctype waitPacketOut110(Wgdef test_udp_wg;Mutexdef test_pipe_mu;Mutexdef test_table_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_receive6403 = [1] of {int};
	run receive640(test_pipe_mu,child_receive6403);
	child_receive6403?0;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	

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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype receive640(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mu.Lock!false;
	

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
	c_mu.Unlock!false;
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

