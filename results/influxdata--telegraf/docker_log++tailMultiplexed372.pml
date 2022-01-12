// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/docker_log/docker_log.go#L372
#define def_var_tags  -2 // opt baseTags line 333
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
	chan child_tailMultiplexed3720 = [1] of {int};
	run tailMultiplexed372(child_tailMultiplexed3720);
	run receiver(child_tailMultiplexed3720)
stop_process:skip
}

proctype tailMultiplexed372(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymoustailMultiplexed3923811 = [1] of {int};
	chan child_AnonymoustailMultiplexed3833810 = [1] of {int};
	Wgdef wg;
	Mutexdef errWriter_p_once_m;
	Mutexdef errWriter_p_wrMu;
	Mutexdef errReader_p_once_m;
	Mutexdef errReader_p_wrMu;
	Mutexdef outWriter_p_once_m;
	Mutexdef outWriter_p_wrMu;
	Mutexdef outReader_p_once_m;
	Mutexdef outReader_p_wrMu;
	run mutexMonitor(outReader_p_wrMu);
	run mutexMonitor(outReader_p_once_m);
	run mutexMonitor(outWriter_p_wrMu);
	run mutexMonitor(outWriter_p_once_m);
	run mutexMonitor(errReader_p_wrMu);
	run mutexMonitor(errReader_p_once_m);
	run mutexMonitor(errWriter_p_wrMu);
	run mutexMonitor(errWriter_p_once_m);
	run wgMonitor(wg);
	wg.update!1;
	run AnonymoustailMultiplexed383381(wg,outReader_p_wrMu,outReader_p_once_m,outWriter_p_wrMu,outWriter_p_once_m,errReader_p_wrMu,errReader_p_once_m,errWriter_p_wrMu,errWriter_p_once_m,child_AnonymoustailMultiplexed3833810);
	run receiver(child_AnonymoustailMultiplexed3833810);
	wg.update!1;
	run AnonymoustailMultiplexed392381(wg,outReader_p_wrMu,outReader_p_once_m,outWriter_p_wrMu,outWriter_p_once_m,errReader_p_wrMu,errReader_p_once_m,errWriter_p_wrMu,errWriter_p_once_m,child_AnonymoustailMultiplexed3923811);
	run receiver(child_AnonymoustailMultiplexed3923811);
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymoustailMultiplexed383381(Wgdef wg;Mutexdef outReader_p_wrMu;Mutexdef outReader_p_once_m;Mutexdef outWriter_p_wrMu;Mutexdef outWriter_p_once_m;Mutexdef errReader_p_wrMu;Mutexdef errReader_p_once_m;Mutexdef errWriter_p_wrMu;Mutexdef errWriter_p_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_tailStream3310 = [1] of {int};
	int var_tags = def_var_tags;
	run tailStream331(outReader_p_once_m,outReader_p_wrMu,var_tags,child_tailStream3310);
	child_tailStream3310?0;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype tailStream331(Mutexdef reader_p_once_m;Mutexdef reader_p_wrMu;int var_baseTags;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype AnonymoustailMultiplexed392381(Wgdef wg;Mutexdef outReader_p_wrMu;Mutexdef outReader_p_once_m;Mutexdef outWriter_p_wrMu;Mutexdef outWriter_p_once_m;Mutexdef errReader_p_wrMu;Mutexdef errReader_p_once_m;Mutexdef errWriter_p_wrMu;Mutexdef errWriter_p_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_tailStream3311 = [1] of {int};
	int var_tags = def_var_tags;
	run tailStream331(errReader_p_once_m,errReader_p_wrMu,var_tags,child_tailStream3311);
	child_tailStream3311?0;
		defer1: skip;
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

