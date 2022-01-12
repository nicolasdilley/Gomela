// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/event/hooks_test.go#L24
#define def_var_h_funcs46  ?? // mand h.funcs line 46
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
	chan child_TestHooks240 = [1] of {int};
	run TestHooks24(child_TestHooks240);
	run receiver(child_TestHooks240)
stop_process:skip
}

proctype TestHooks24(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Fire402 = [1] of {int};
	chan child_Add311 = [1] of {int};
	chan child_Add310 = [1] of {int};
	Mutexdef hooks_mu;
	run mutexMonitor(hooks_mu);
	run Add31(hooks_mu,child_Add310);
	child_Add310?0;
	run Add31(hooks_mu,child_Add311);
	child_Add311?0;
	run Fire40(hooks_mu,child_Fire402);
	child_Fire402?0;
	stop_process: skip;
	child!0
}
proctype Add31(Mutexdef h_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	h_mu.Lock!false;
		defer1: skip;
	h_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Fire40(Mutexdef h_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousFire48482 = [1] of {int};
	Wgdef wg;
	int var_h_funcs = def_var_h_funcs46; // mand var_h_funcs
	h_mu.Lock!false;
	run wgMonitor(wg);
		for(i : 0.. var_h_funcs-1) {
		for10: skip;
		wg.update!1;
		run AnonymousFire4848(wg,h_mu,child_AnonymousFire48482);
		run receiver(child_AnonymousFire48482);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
		defer1: skip;
	h_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype AnonymousFire4848(Wgdef wg;Mutexdef h_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
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

