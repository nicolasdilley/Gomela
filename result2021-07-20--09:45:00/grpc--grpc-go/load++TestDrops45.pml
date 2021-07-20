// num_comm_params=2
// num_mand_comm_params=2
// num_opt_comm_params=0

// git_link=https://github.com/grpc/grpc-go/blob/ebd6aba6754d073a696e5727158cd0c917ce1019/xds/internal/client/load/store_test.go#L45
#define var_drops63  ?? // mand drops line 63
#define var_count64  ?? // mand count line 64
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
	chan child_TestDrops450 = [1] of {int};
	run TestDrops45(child_TestDrops450);
	run receiver(child_TestDrops450)
stop_process:skip
}

proctype TestDrops45(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_stats2744 = [1] of {int};
	chan child_AnonymousTestDrops66660 = [1] of {int};
	Wgdef wg;
	Mutexdef ls_mu;
	Mutexdef ls_localityRPCCount_mu;
	Mutexdef ls_drops_mu;
	int var_count = var_count64; // mand var_count
	int var_drops = var_drops63; // mand var_drops
	run mutexMonitor(ls_drops_mu);
	run mutexMonitor(ls_localityRPCCount_mu);
	run mutexMonitor(ls_mu);
	run wgMonitor(wg);
		for(i : 0.. var_drops-1) {
		for10: skip;
				for(i : 0.. var_count-1) {
			for11: skip;
			wg.update!1;
			run AnonymousTestDrops6666(wg,ls_drops_mu,ls_localityRPCCount_mu,ls_mu,child_AnonymousTestDrops66660);
			run receiver(child_AnonymousTestDrops66660);
			for11_end: skip
		};
		for11_exit: skip;
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	run stats274(ls_drops_mu,ls_localityRPCCount_mu,ls_mu,child_stats2744);
	child_stats2744?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestDrops6666(Wgdef wg;Mutexdef ls_drops_mu;Mutexdef ls_localityRPCCount_mu;Mutexdef ls_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CallDropped1520 = [1] of {int};
	run CallDropped152(ls_drops_mu,ls_localityRPCCount_mu,ls_mu,child_CallDropped1520);
	child_CallDropped1520?0;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype CallDropped152(Mutexdef ls_drops_mu;Mutexdef ls_localityRPCCount_mu;Mutexdef ls_mu;chan child) {
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
proctype stats274(Mutexdef ls_drops_mu;Mutexdef ls_localityRPCCount_mu;Mutexdef ls_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	ls_mu.Lock!false;
	ls_mu.Unlock!false;
	

	if
	:: true -> 
		goto stop_process
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

