// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/ethereum/go-ethereum/blob//p2p/discover/v4_lookup_test.go#L67
#define def_var_bootnodes  -2 // opt nodes line 111
#define ub_for138_2  -2
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
	chan child_TestUDPv4_LookupIterator670 = [1] of {int};
	run TestUDPv4_LookupIterator67(child_TestUDPv4_LookupIterator670);
	run receiver(child_TestUDPv4_LookupIterator670)
stop_process:skip
}

proctype TestUDPv4_LookupIterator67(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_close820 = [1] of {int};
	chan child_RandomNodes2723 = [1] of {int};
	chan child_serveTestnet1372 = [1] of {int};
	chan child_fillTable1111 = [1] of {int};
	int var_bootnodes = def_var_bootnodes;
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
	int var_seen = -2; // opt var_seen
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
	run fillTable111(test_table_db_lvl_closeW,test_table_db_lvl_compCommitLk,test_table_db_lvl_memMu,test_table_db_lvl_snapsMu,test_table_db_runner_m,test_table_mutex,var_bootnodes,child_fillTable1111);
	child_fillTable1111?0;
	run serveTestnet137(test_db_lvl_closeW,test_db_lvl_s_closeW,test_table_db_lvl_closeW,test_udp_db_lvl_closeW,test_udp_wg,test_db_lvl_compCommitLk,test_db_lvl_compStats_lk,test_db_lvl_memMu,test_db_lvl_s_vmu,test_db_lvl_snapsMu,test_db_lvl_tr_lk,test_db_runner_m,test_pipe_mu,test_t_context_match_mu,test_t_context_mu,test_table_db_lvl_compCommitLk,test_table_db_lvl_memMu,test_table_db_lvl_snapsMu,test_table_db_runner_m,test_table_mutex,test_udp_closeOnce_m,test_udp_db_lvl_compCommitLk,test_udp_db_lvl_memMu,test_udp_db_lvl_snapsMu,test_udp_db_runner_m,test_udp_localNode_mu,test_udp_tab_mutex,child_serveTestnet1372);
	run receiver(child_serveTestnet1372);
	run RandomNodes272(test_udp_db_lvl_closeW,test_udp_wg,test_udp_closeOnce_m,test_udp_db_lvl_compCommitLk,test_udp_db_lvl_memMu,test_udp_db_lvl_snapsMu,test_udp_db_runner_m,test_udp_localNode_mu,test_udp_tab_mutex,child_RandomNodes2723);
	child_RandomNodes2723?0;
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
proctype fillTable111(Wgdef tab_db_lvl_closeW;Mutexdef tab_db_lvl_compCommitLk;Mutexdef tab_db_lvl_memMu;Mutexdef tab_db_lvl_snapsMu;Mutexdef tab_db_runner_m;Mutexdef tab_mutex;int var_nodes;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_addSeenNode4631 = [1] of {int};
	chan child_addSeenNode4632 = [1] of {int};
	

	if
	:: var_nodes-1 != -3 -> 
				for(i : 0.. var_nodes-1) {
			for20: skip;
			run addSeenNode463(tab_db_lvl_closeW,tab_db_lvl_compCommitLk,tab_db_lvl_memMu,tab_db_lvl_snapsMu,tab_db_runner_m,tab_mutex,child_addSeenNode4631);
			child_addSeenNode4631?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for23: skip;
			run addSeenNode463(tab_db_lvl_closeW,tab_db_lvl_compCommitLk,tab_db_lvl_memMu,tab_db_lvl_snapsMu,tab_db_runner_m,tab_mutex,child_addSeenNode4632);
			child_addSeenNode4632?0;
			for23_end: skip
		:: true -> 
			break
		od;
		for23_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype addSeenNode463(Wgdef tab_db_lvl_closeW;Mutexdef tab_db_lvl_compCommitLk;Mutexdef tab_db_lvl_memMu;Mutexdef tab_db_lvl_snapsMu;Mutexdef tab_db_runner_m;Mutexdef tab_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_addIP5433 = [1] of {int};
	chan child_addReplacement5702 = [1] of {int};
	chan child_bucket4461 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	tab_mutex.Lock!false;
	run bucket446(tab_db_lvl_closeW,tab_db_lvl_compCommitLk,tab_db_lvl_memMu,tab_db_lvl_snapsMu,tab_db_runner_m,tab_mutex,child_bucket4461);
	child_bucket4461?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		run addReplacement570(tab_db_lvl_closeW,tab_db_lvl_compCommitLk,tab_db_lvl_memMu,tab_db_lvl_snapsMu,tab_db_runner_m,tab_mutex,child_addReplacement5702);
		child_addReplacement5702?0;
		goto defer1
	:: true;
	fi;
	run addIP543(tab_db_lvl_closeW,tab_db_lvl_compCommitLk,tab_db_lvl_memMu,tab_db_lvl_snapsMu,tab_db_runner_m,tab_mutex,child_addIP5433);
	child_addIP5433?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
		defer1: skip;
	tab_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype bucket446(Wgdef tab_db_lvl_closeW;Mutexdef tab_db_lvl_compCommitLk;Mutexdef tab_db_lvl_memMu;Mutexdef tab_db_lvl_snapsMu;Mutexdef tab_db_runner_m;Mutexdef tab_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_bucketAtDistance4511 = [1] of {int};
	run bucketAtDistance451(tab_db_lvl_closeW,tab_db_lvl_compCommitLk,tab_db_lvl_memMu,tab_db_lvl_snapsMu,tab_db_runner_m,tab_mutex,child_bucketAtDistance4511);
	child_bucketAtDistance4511?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype bucketAtDistance451(Wgdef tab_db_lvl_closeW;Mutexdef tab_db_lvl_compCommitLk;Mutexdef tab_db_lvl_memMu;Mutexdef tab_db_lvl_snapsMu;Mutexdef tab_db_runner_m;Mutexdef tab_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype addReplacement570(Wgdef tab_db_lvl_closeW;Mutexdef tab_db_lvl_compCommitLk;Mutexdef tab_db_lvl_memMu;Mutexdef tab_db_lvl_snapsMu;Mutexdef tab_db_runner_m;Mutexdef tab_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_removeIP5623 = [1] of {int};
	chan child_addIP5432 = [1] of {int};
	int var_b_replacements = -2; // opt var_b_replacements
	run addIP543(tab_db_lvl_closeW,tab_db_lvl_compCommitLk,tab_db_lvl_memMu,tab_db_lvl_snapsMu,tab_db_runner_m,tab_mutex,child_addIP5432);
	child_addIP5432?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run removeIP562(tab_db_lvl_closeW,tab_db_lvl_compCommitLk,tab_db_lvl_memMu,tab_db_lvl_snapsMu,tab_db_runner_m,tab_mutex,child_removeIP5623);
		child_removeIP5623?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype addIP543(Wgdef tab_db_lvl_closeW;Mutexdef tab_db_lvl_compCommitLk;Mutexdef tab_db_lvl_memMu;Mutexdef tab_db_lvl_snapsMu;Mutexdef tab_db_runner_m;Mutexdef tab_mutex;chan child) {
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
proctype removeIP562(Wgdef tab_db_lvl_closeW;Mutexdef tab_db_lvl_compCommitLk;Mutexdef tab_db_lvl_memMu;Mutexdef tab_db_lvl_snapsMu;Mutexdef tab_db_runner_m;Mutexdef tab_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype serveTestnet137(Wgdef test_db_lvl_closeW;Wgdef test_db_lvl_s_closeW;Wgdef test_table_db_lvl_closeW;Wgdef test_udp_db_lvl_closeW;Wgdef test_udp_wg;Mutexdef test_db_lvl_compCommitLk;Mutexdef test_db_lvl_compStats_lk;Mutexdef test_db_lvl_memMu;Mutexdef test_db_lvl_s_vmu;Mutexdef test_db_lvl_snapsMu;Mutexdef test_db_lvl_tr_lk;Mutexdef test_db_runner_m;Mutexdef test_pipe_mu;Mutexdef test_t_context_match_mu;Mutexdef test_t_context_mu;Mutexdef test_table_db_lvl_compCommitLk;Mutexdef test_table_db_lvl_memMu;Mutexdef test_table_db_lvl_snapsMu;Mutexdef test_table_db_runner_m;Mutexdef test_table_mutex;Mutexdef test_udp_closeOnce_m;Mutexdef test_udp_db_lvl_compCommitLk;Mutexdef test_udp_db_lvl_memMu;Mutexdef test_udp_db_lvl_snapsMu;Mutexdef test_udp_db_runner_m;Mutexdef test_udp_localNode_mu;Mutexdef test_udp_tab_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_waitPacketOut1103 = [1] of {int};
	chan child_waitPacketOut1102 = [1] of {int};
	

	if
	:: 0 != -2 && ub_for138_2 != -2 -> 
				for(i : 0.. ub_for138_2) {
			for33: skip;
			run waitPacketOut110(test_db_lvl_closeW,test_db_lvl_s_closeW,test_table_db_lvl_closeW,test_udp_db_lvl_closeW,test_udp_wg,test_db_lvl_compCommitLk,test_db_lvl_compStats_lk,test_db_lvl_memMu,test_db_lvl_s_vmu,test_db_lvl_snapsMu,test_db_lvl_tr_lk,test_db_runner_m,test_pipe_mu,test_t_context_match_mu,test_t_context_mu,test_table_db_lvl_compCommitLk,test_table_db_lvl_memMu,test_table_db_lvl_snapsMu,test_table_db_runner_m,test_table_mutex,test_udp_closeOnce_m,test_udp_db_lvl_compCommitLk,test_udp_db_lvl_memMu,test_udp_db_lvl_snapsMu,test_udp_db_runner_m,test_udp_localNode_mu,test_udp_tab_mutex,child_waitPacketOut1103);
			child_waitPacketOut1103?0;
			for33_end: skip
		};
		for33_exit: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			run waitPacketOut110(test_db_lvl_closeW,test_db_lvl_s_closeW,test_table_db_lvl_closeW,test_udp_db_lvl_closeW,test_udp_wg,test_db_lvl_compCommitLk,test_db_lvl_compStats_lk,test_db_lvl_memMu,test_db_lvl_s_vmu,test_db_lvl_snapsMu,test_db_lvl_tr_lk,test_db_runner_m,test_pipe_mu,test_t_context_match_mu,test_t_context_mu,test_table_db_lvl_compCommitLk,test_table_db_lvl_memMu,test_table_db_lvl_snapsMu,test_table_db_runner_m,test_table_mutex,test_udp_closeOnce_m,test_udp_db_lvl_compCommitLk,test_udp_db_lvl_memMu,test_udp_db_lvl_snapsMu,test_udp_db_runner_m,test_udp_localNode_mu,test_udp_tab_mutex,child_waitPacketOut1102);
			child_waitPacketOut1102?0;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
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
proctype RandomNodes272(Wgdef t_db_lvl_closeW;Wgdef t_wg;Mutexdef t_closeOnce_m;Mutexdef t_db_lvl_compCommitLk;Mutexdef t_db_lvl_memMu;Mutexdef t_db_lvl_snapsMu;Mutexdef t_db_runner_m;Mutexdef t_localNode_mu;Mutexdef t_tab_mutex;chan child) {
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

