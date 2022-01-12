// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/httpjson/httpjson.go#L125
#define def_var_h_Servers144  ?? // mand h.Servers line 144
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
	chan child_Gather1250 = [1] of {int};
	run Gather125(child_Gather1250);
	run receiver(child_Gather1250)
stop_process:skip
}

proctype Gather125(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGather1461460 = [1] of {int};
	Mutexdef tr_nextProtoOnce_m;
	Mutexdef tr_TLSClientConfig_mutex;
	Mutexdef tr_connsPerHostMu;
	Mutexdef tr_altMu;
	Mutexdef tr_reqMu;
	Mutexdef tr_idleMu;
	Mutexdef tlsCfg_mutex;
	Wgdef wg;
	int var_h_Servers = def_var_h_Servers144; // mand var_h_Servers
	run wgMonitor(wg);
	

	if
	:: true -> 
		run mutexMonitor(tlsCfg_mutex);
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run mutexMonitor(tr_idleMu);
		run mutexMonitor(tr_reqMu);
		run mutexMonitor(tr_altMu);
		run mutexMonitor(tr_connsPerHostMu);
		run mutexMonitor(tr_TLSClientConfig_mutex);
		run mutexMonitor(tr_nextProtoOnce_m)
	:: true;
	fi;
		for(i : 0.. var_h_Servers-1) {
		for10: skip;
		wg.update!1;
		run AnonymousGather146146(wg,tlsCfg_mutex,tr_idleMu,tr_reqMu,tr_altMu,tr_connsPerHostMu,tr_TLSClientConfig_mutex,tr_nextProtoOnce_m,child_AnonymousGather1461460);
		run receiver(child_AnonymousGather1461460);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousGather146146(Wgdef wg;Mutexdef tlsCfg_mutex;Mutexdef tr_idleMu;Mutexdef tr_reqMu;Mutexdef tr_altMu;Mutexdef tr_connsPerHostMu;Mutexdef tr_TLSClientConfig_mutex;Mutexdef tr_nextProtoOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

