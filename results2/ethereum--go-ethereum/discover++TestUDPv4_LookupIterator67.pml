// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/p2p/discover/v4_lookup_test.go#L67
#define not_found_77  -2 // opt not_found_77
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
	Wgdef test_udp_wg;
	Mutexdef test_table_mutex;
	Mutexdef test_pipe_mu;
	int seen = -2; // opt seen
	run mutexMonitor(test_pipe_mu);
	run mutexMonitor(test_table_mutex);
	run wgMonitor(test_udp_wg);
	run fillTable111(test_table_mutex,not_found_77,child_fillTable1111);
	child_fillTable1111?0;
	run serveTestnet137(test_udp_wg,test_pipe_mu,test_table_mutex,child_serveTestnet1372);
	run receiver(child_serveTestnet1372);
	run RandomNodes272(test_udp_wg,child_RandomNodes2723);
	child_RandomNodes2723?0;
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
proctype fillTable111(Mutexdef tab_mutex;int nodes;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_addSeenNode4631 = [1] of {int};
	chan child_addSeenNode4632 = [1] of {int};
	

	if
	:: nodes-1 != -3 -> 
				for(i : 0.. nodes-1) {
			for20: skip;
			run addSeenNode463(tab_mutex,child_addSeenNode4631);
			child_addSeenNode4631?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for23: skip;
			run addSeenNode463(tab_mutex,child_addSeenNode4632);
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
proctype addSeenNode463(Mutexdef tab_mutex;chan child) {
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
	run bucket446(tab_mutex,child_bucket4461);
	child_bucket4461?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		run addReplacement570(tab_mutex,child_addReplacement5702);
		child_addReplacement5702?0;
		goto defer1
	:: true;
	fi;
	run addIP543(tab_mutex,child_addIP5433);
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
proctype bucket446(Mutexdef tab_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_bucketAtDistance4511 = [1] of {int};
	run bucketAtDistance451(tab_mutex,child_bucketAtDistance4511);
	child_bucketAtDistance4511?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype bucketAtDistance451(Mutexdef tab_mutex;chan child) {
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
proctype addReplacement570(Mutexdef tab_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_removeIP5623 = [1] of {int};
	chan child_addIP5432 = [1] of {int};
	int b_replacements = -2; // opt b_replacements
	run addIP543(tab_mutex,child_addIP5432);
	child_addIP5432?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run removeIP562(tab_mutex,child_removeIP5623);
		child_removeIP5623?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype addIP543(Mutexdef tab_mutex;chan child) {
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
proctype removeIP562(Mutexdef tab_mutex;chan child) {
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
proctype serveTestnet137(Wgdef test_udp_wg;Mutexdef test_pipe_mu;Mutexdef test_table_mutex;chan child) {
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
			run waitPacketOut110(test_udp_wg,test_pipe_mu,test_table_mutex,child_waitPacketOut1103);
			child_waitPacketOut1103?0;
			for33_end: skip
		};
		for33_exit: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			run waitPacketOut110(test_udp_wg,test_pipe_mu,test_table_mutex,child_waitPacketOut1102);
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
proctype waitPacketOut110(Wgdef test_udp_wg;Mutexdef test_pipe_mu;Mutexdef test_table_mutex;chan child) {
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
proctype RandomNodes272(Wgdef t_wg;chan child) {
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

