// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob//p2p/discover/v4_udp_test.go#L377
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
	chan child_TestUDPv4_pingMatchIP3770 = [1] of {int};
	run TestUDPv4_pingMatchIP377(child_TestUDPv4_pingMatchIP3770);
	run receiver(child_TestUDPv4_pingMatchIP3770)
stop_process:skip
}

proctype TestUDPv4_pingMatchIP377(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_close820 = [1] of {int};
	chan child_waitPacketOut1103 = [1] of {int};
	chan child_waitPacketOut1102 = [1] of {int};
	chan child_packetIn881 = [1] of {int};
	Wgdef test_udp_wg;
	Mutexdef test_udp_closeOnce_m;
	Mutexdef test_udp_tab_mutex;
	Mutexdef test_udp_db_runner_m;
	Wgdef test_udp_db_lvl_closeW;
	Mutexdef test_udp_db_lvl_compCommitLk;
	Mutexdef test_udp_db_lvl_snapsMu;
	Mutexdef test_udp_db_lvl_memMu;
	Mutexdef test_udp_localNode_mu;
	Mutexdef test_db_runner_m;
	Wgdef test_db_lvl_closeW;
	Mutexdef test_db_lvl_compStats_lk;
	Mutexdef test_db_lvl_compCommitLk;
	Mutexdef test_db_lvl_tr_lk;
	Mutexdef test_db_lvl_snapsMu;
	Mutexdef test_db_lvl_memMu;
	Mutexdef test_db_lvl_s_vmu;
	Wgdef test_db_lvl_s_closeW;
	Mutexdef test_table_db_runner_m;
	Wgdef test_table_db_lvl_closeW;
	Mutexdef test_table_db_lvl_compCommitLk;
	Mutexdef test_table_db_lvl_snapsMu;
	Mutexdef test_table_db_lvl_memMu;
	Mutexdef test_table_mutex;
	Mutexdef test_pipe_mu;
	Mutexdef test_t_context_mu;
	Mutexdef test_t_context_match_mu;
	run mutexMonitor(test_t_context_match_mu);
	run mutexMonitor(test_t_context_mu);
	run mutexMonitor(test_pipe_mu);
	run mutexMonitor(test_table_mutex);
	run mutexMonitor(test_table_db_lvl_memMu);
	run mutexMonitor(test_table_db_lvl_snapsMu);
	run mutexMonitor(test_table_db_lvl_compCommitLk);
	run wgMonitor(test_table_db_lvl_closeW);
	run mutexMonitor(test_table_db_runner_m);
	run wgMonitor(test_db_lvl_s_closeW);
	run mutexMonitor(test_db_lvl_s_vmu);
	run mutexMonitor(test_db_lvl_memMu);
	run mutexMonitor(test_db_lvl_snapsMu);
	run mutexMonitor(test_db_lvl_tr_lk);
	run mutexMonitor(test_db_lvl_compCommitLk);
	run mutexMonitor(test_db_lvl_compStats_lk);
	run wgMonitor(test_db_lvl_closeW);
	run mutexMonitor(test_db_runner_m);
	run mutexMonitor(test_udp_localNode_mu);
	run mutexMonitor(test_udp_db_lvl_memMu);
	run mutexMonitor(test_udp_db_lvl_snapsMu);
	run mutexMonitor(test_udp_db_lvl_compCommitLk);
	run wgMonitor(test_udp_db_lvl_closeW);
	run mutexMonitor(test_udp_db_runner_m);
	run mutexMonitor(test_udp_tab_mutex);
	run mutexMonitor(test_udp_closeOnce_m);
	run wgMonitor(test_udp_wg);
	run packetIn88(test_db_lvl_closeW,test_db_lvl_s_closeW,test_table_db_lvl_closeW,test_udp_db_lvl_closeW,test_udp_wg,test_db_lvl_compCommitLk,test_db_lvl_compStats_lk,test_db_lvl_memMu,test_db_lvl_s_vmu,test_db_lvl_snapsMu,test_db_lvl_tr_lk,test_db_runner_m,test_pipe_mu,test_t_context_match_mu,test_t_context_mu,test_table_db_lvl_compCommitLk,test_table_db_lvl_memMu,test_table_db_lvl_snapsMu,test_table_db_runner_m,test_table_mutex,test_udp_closeOnce_m,test_udp_db_lvl_compCommitLk,test_udp_db_lvl_memMu,test_udp_db_lvl_snapsMu,test_udp_db_runner_m,test_udp_localNode_mu,test_udp_tab_mutex,child_packetIn881);
	child_packetIn881?0;
	run waitPacketOut110(test_db_lvl_closeW,test_db_lvl_s_closeW,test_table_db_lvl_closeW,test_udp_db_lvl_closeW,test_udp_wg,test_db_lvl_compCommitLk,test_db_lvl_compStats_lk,test_db_lvl_memMu,test_db_lvl_s_vmu,test_db_lvl_snapsMu,test_db_lvl_tr_lk,test_db_runner_m,test_pipe_mu,test_t_context_match_mu,test_t_context_mu,test_table_db_lvl_compCommitLk,test_table_db_lvl_memMu,test_table_db_lvl_snapsMu,test_table_db_runner_m,test_table_mutex,test_udp_closeOnce_m,test_udp_db_lvl_compCommitLk,test_udp_db_lvl_memMu,test_udp_db_lvl_snapsMu,test_udp_db_runner_m,test_udp_localNode_mu,test_udp_tab_mutex,child_waitPacketOut1102);
	child_waitPacketOut1102?0;
	run waitPacketOut110(test_db_lvl_closeW,test_db_lvl_s_closeW,test_table_db_lvl_closeW,test_udp_db_lvl_closeW,test_udp_wg,test_db_lvl_compCommitLk,test_db_lvl_compStats_lk,test_db_lvl_memMu,test_db_lvl_s_vmu,test_db_lvl_snapsMu,test_db_lvl_tr_lk,test_db_runner_m,test_pipe_mu,test_t_context_match_mu,test_t_context_mu,test_table_db_lvl_compCommitLk,test_table_db_lvl_memMu,test_table_db_lvl_snapsMu,test_table_db_runner_m,test_table_mutex,test_udp_closeOnce_m,test_udp_db_lvl_compCommitLk,test_udp_db_lvl_memMu,test_udp_db_lvl_snapsMu,test_udp_db_runner_m,test_udp_localNode_mu,test_udp_tab_mutex,child_waitPacketOut1103);
	child_waitPacketOut1103?0;
		defer1: skip;
	run close82(test_db_lvl_closeW,test_db_lvl_s_closeW,test_table_db_lvl_closeW,test_udp_db_lvl_closeW,test_udp_wg,test_db_lvl_compCommitLk,test_db_lvl_compStats_lk,test_db_lvl_memMu,test_db_lvl_s_vmu,test_db_lvl_snapsMu,test_db_lvl_tr_lk,test_db_runner_m,test_pipe_mu,test_t_context_match_mu,test_t_context_mu,test_table_db_lvl_compCommitLk,test_table_db_lvl_memMu,test_table_db_lvl_snapsMu,test_table_db_runner_m,test_table_mutex,test_udp_closeOnce_m,test_udp_db_lvl_compCommitLk,test_udp_db_lvl_memMu,test_udp_db_lvl_snapsMu,test_udp_db_runner_m,test_udp_localNode_mu,test_udp_tab_mutex,child_close820);
	child_close820?0;
	stop_process: skip;
	child!0
}
proctype close82(Wgdef test_db_lvl_closeW;Wgdef test_db_lvl_s_closeW;Wgdef test_table_db_lvl_closeW;Wgdef test_udp_db_lvl_closeW;Wgdef test_udp_wg;Mutexdef test_db_lvl_compCommitLk;Mutexdef test_db_lvl_compStats_lk;Mutexdef test_db_lvl_memMu;Mutexdef test_db_lvl_s_vmu;Mutexdef test_db_lvl_snapsMu;Mutexdef test_db_lvl_tr_lk;Mutexdef test_db_runner_m;Mutexdef test_pipe_mu;Mutexdef test_t_context_match_mu;Mutexdef test_t_context_mu;Mutexdef test_table_db_lvl_compCommitLk;Mutexdef test_table_db_lvl_memMu;Mutexdef test_table_db_lvl_snapsMu;Mutexdef test_table_db_runner_m;Mutexdef test_table_mutex;Mutexdef test_udp_closeOnce_m;Mutexdef test_udp_db_lvl_compCommitLk;Mutexdef test_udp_db_lvl_memMu;Mutexdef test_udp_db_lvl_snapsMu;Mutexdef test_udp_db_runner_m;Mutexdef test_udp_localNode_mu;Mutexdef test_udp_tab_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close1650 = [1] of {int};
	run Close165(test_udp_db_lvl_closeW,test_udp_wg,test_udp_closeOnce_m,test_udp_db_lvl_compCommitLk,test_udp_db_lvl_memMu,test_udp_db_lvl_snapsMu,test_udp_db_runner_m,test_udp_localNode_mu,test_udp_tab_mutex,child_Close1650);
	child_Close1650?0;
	stop_process: skip;
	child!0
}
proctype Close165(Wgdef t_db_lvl_closeW;Wgdef t_wg;Mutexdef t_closeOnce_m;Mutexdef t_db_lvl_compCommitLk;Mutexdef t_db_lvl_memMu;Mutexdef t_db_lvl_snapsMu;Mutexdef t_db_runner_m;Mutexdef t_localNode_mu;Mutexdef t_tab_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype packetIn88(Wgdef test_db_lvl_closeW;Wgdef test_db_lvl_s_closeW;Wgdef test_table_db_lvl_closeW;Wgdef test_udp_db_lvl_closeW;Wgdef test_udp_wg;Mutexdef test_db_lvl_compCommitLk;Mutexdef test_db_lvl_compStats_lk;Mutexdef test_db_lvl_memMu;Mutexdef test_db_lvl_s_vmu;Mutexdef test_db_lvl_snapsMu;Mutexdef test_db_lvl_tr_lk;Mutexdef test_db_runner_m;Mutexdef test_pipe_mu;Mutexdef test_t_context_match_mu;Mutexdef test_t_context_mu;Mutexdef test_table_db_lvl_compCommitLk;Mutexdef test_table_db_lvl_memMu;Mutexdef test_table_db_lvl_snapsMu;Mutexdef test_table_db_runner_m;Mutexdef test_table_mutex;Mutexdef test_udp_closeOnce_m;Mutexdef test_udp_db_lvl_compCommitLk;Mutexdef test_udp_db_lvl_memMu;Mutexdef test_udp_db_lvl_snapsMu;Mutexdef test_udp_db_runner_m;Mutexdef test_udp_localNode_mu;Mutexdef test_udp_tab_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_packetInFrom951 = [1] of {int};
	run packetInFrom95(test_db_lvl_closeW,test_db_lvl_s_closeW,test_table_db_lvl_closeW,test_udp_db_lvl_closeW,test_udp_wg,test_db_lvl_compCommitLk,test_db_lvl_compStats_lk,test_db_lvl_memMu,test_db_lvl_s_vmu,test_db_lvl_snapsMu,test_db_lvl_tr_lk,test_db_runner_m,test_pipe_mu,test_t_context_match_mu,test_t_context_mu,test_table_db_lvl_compCommitLk,test_table_db_lvl_memMu,test_table_db_lvl_snapsMu,test_table_db_runner_m,test_table_mutex,test_udp_closeOnce_m,test_udp_db_lvl_compCommitLk,test_udp_db_lvl_memMu,test_udp_db_lvl_snapsMu,test_udp_db_runner_m,test_udp_localNode_mu,test_udp_tab_mutex,child_packetInFrom951);
	child_packetInFrom951?0;
	stop_process: skip;
	child!0
}
proctype packetInFrom95(Wgdef test_db_lvl_closeW;Wgdef test_db_lvl_s_closeW;Wgdef test_table_db_lvl_closeW;Wgdef test_udp_db_lvl_closeW;Wgdef test_udp_wg;Mutexdef test_db_lvl_compCommitLk;Mutexdef test_db_lvl_compStats_lk;Mutexdef test_db_lvl_memMu;Mutexdef test_db_lvl_s_vmu;Mutexdef test_db_lvl_snapsMu;Mutexdef test_db_lvl_tr_lk;Mutexdef test_db_runner_m;Mutexdef test_pipe_mu;Mutexdef test_t_context_match_mu;Mutexdef test_t_context_mu;Mutexdef test_table_db_lvl_compCommitLk;Mutexdef test_table_db_lvl_memMu;Mutexdef test_table_db_lvl_snapsMu;Mutexdef test_table_db_runner_m;Mutexdef test_table_mutex;Mutexdef test_udp_closeOnce_m;Mutexdef test_udp_db_lvl_compCommitLk;Mutexdef test_udp_db_lvl_memMu;Mutexdef test_udp_db_lvl_snapsMu;Mutexdef test_udp_db_runner_m;Mutexdef test_udp_localNode_mu;Mutexdef test_udp_tab_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_handlePacket5451 = [1] of {int};
	run handlePacket545(test_udp_db_lvl_closeW,test_udp_wg,test_udp_closeOnce_m,test_udp_db_lvl_compCommitLk,test_udp_db_lvl_memMu,test_udp_db_lvl_snapsMu,test_udp_db_runner_m,test_udp_localNode_mu,test_udp_tab_mutex,child_handlePacket5451);
	child_handlePacket5451?0;
	stop_process: skip;
	child!0
}
proctype handlePacket545(Wgdef t_db_lvl_closeW;Wgdef t_wg;Mutexdef t_closeOnce_m;Mutexdef t_db_lvl_compCommitLk;Mutexdef t_db_lvl_memMu;Mutexdef t_db_lvl_snapsMu;Mutexdef t_db_runner_m;Mutexdef t_localNode_mu;Mutexdef t_tab_mutex;chan child) {
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
	run wrapPacket609(t_db_lvl_closeW,t_wg,t_closeOnce_m,t_db_lvl_compCommitLk,t_db_lvl_memMu,t_db_lvl_snapsMu,t_db_runner_m,t_localNode_mu,t_tab_mutex,child_wrapPacket6091);
	child_wrapPacket6091?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype wrapPacket609(Wgdef t_db_lvl_closeW;Wgdef t_wg;Mutexdef t_closeOnce_m;Mutexdef t_db_lvl_compCommitLk;Mutexdef t_db_lvl_memMu;Mutexdef t_db_lvl_snapsMu;Mutexdef t_db_runner_m;Mutexdef t_localNode_mu;Mutexdef t_tab_mutex;chan child) {
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
proctype waitPacketOut110(Wgdef test_db_lvl_closeW;Wgdef test_db_lvl_s_closeW;Wgdef test_table_db_lvl_closeW;Wgdef test_udp_db_lvl_closeW;Wgdef test_udp_wg;Mutexdef test_db_lvl_compCommitLk;Mutexdef test_db_lvl_compStats_lk;Mutexdef test_db_lvl_memMu;Mutexdef test_db_lvl_s_vmu;Mutexdef test_db_lvl_snapsMu;Mutexdef test_db_lvl_tr_lk;Mutexdef test_db_runner_m;Mutexdef test_pipe_mu;Mutexdef test_t_context_match_mu;Mutexdef test_t_context_mu;Mutexdef test_table_db_lvl_compCommitLk;Mutexdef test_table_db_lvl_memMu;Mutexdef test_table_db_lvl_snapsMu;Mutexdef test_table_db_runner_m;Mutexdef test_table_mutex;Mutexdef test_udp_closeOnce_m;Mutexdef test_udp_db_lvl_compCommitLk;Mutexdef test_udp_db_lvl_memMu;Mutexdef test_udp_db_lvl_snapsMu;Mutexdef test_udp_db_runner_m;Mutexdef test_udp_localNode_mu;Mutexdef test_udp_tab_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_receive6402 = [1] of {int};
	run receive640(test_pipe_mu,child_receive6402);
	child_receive6402?0;
	

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

