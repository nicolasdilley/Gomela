#define TestParallel_numRoutines  3
#define ub_for189_4  3

// https://github.com/grpc/grpc-go/blob/master/balancer/rls/internal/adaptive/adaptive_test.go#L172
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
	chan child_TestParallel1720 = [1] of {int};
	run TestParallel172(child_TestParallel1720)
stop_process:skip
}

proctype TestParallel172(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_stats282 = [1] of {int};
	chan child_AnonymousTestParallel1831830 = [1] of {int};
	Wgdef wg;
	Mutexdef th_mu;
	int numRoutines = TestParallel_numRoutines;
	run mutexMonitor(th_mu);
	run wgMonitor(wg);
		for(i : 0.. numRoutines-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestParallel183183(wg,th_mu,child_AnonymousTestParallel1831830);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	run stats28(th_mu,child_stats282);
	child_stats282?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestParallel183183(Wgdef wg;Mutexdef th_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RegisterBackendResponse1222 = [1] of {int};
	chan child_RegisterBackendResponse1223 = [1] of {int};
	chan child_RegisterBackendResponse1220 = [1] of {int};
	chan child_RegisterBackendResponse1221 = [1] of {int};
	

	if
	:: 0 != -2 && ub_for189_4 != -2 -> 
				for(i : 0.. ub_for189_4) {
			for12: skip;
			do
			:: true -> 
				goto stop_process
			:: true -> 
				

				if
				:: true -> 
					run RegisterBackendResponse122(th_mu,child_RegisterBackendResponse1222);
					child_RegisterBackendResponse1222?0
				:: true -> 
					run RegisterBackendResponse122(th_mu,child_RegisterBackendResponse1223);
					child_RegisterBackendResponse1223?0
				fi;
				break
			od;
			for12_end: skip
		};
		for12_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			do
			:: true -> 
				goto stop_process
			:: true -> 
				

				if
				:: true -> 
					run RegisterBackendResponse122(th_mu,child_RegisterBackendResponse1220);
					child_RegisterBackendResponse1220?0
				:: true -> 
					run RegisterBackendResponse122(th_mu,child_RegisterBackendResponse1221);
					child_RegisterBackendResponse1221?0
				fi;
				break
			od;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
		wg.update!-1;
	child!0
}
proctype RegisterBackendResponse122(Mutexdef t_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	t_mu.Lock!false;
	t_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype stats28(Mutexdef th_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	th_mu.Lock!false;
	th_mu.Unlock!false;
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


