// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/elastic/beats/blob//filebeat/input/v2/input-cursor/store_test.go#L250
#define def_var_data  -2 // opt data line 250
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
	chan child_createSampleStore2500 = [1] of {int};
	run createSampleStore250(def_var_data,child_createSampleStore2500);
	run receiver(child_createSampleStore2500)
stop_process:skip
}

proctype createSampleStore250(int var_data;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef store_active_wg;
	Mutexdef store_active_mu;
	Wgdef store_shared_reg_wg;
	Mutexdef store_shared_reg_mu;
	Wgdef storeReg_wg;
	Mutexdef storeReg_mu;
	run mutexMonitor(storeReg_mu);
	run wgMonitor(storeReg_wg);
	run mutexMonitor(store_shared_reg_mu);
	run wgMonitor(store_shared_reg_wg);
	run mutexMonitor(store_active_mu);
	run wgMonitor(store_active_wg);
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

