// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/elastic/beats/blob//x-pack/elastic-agent/pkg/agent/operation/operator_test.go#L351
#define def_var_flow  -2 // opt operations line 247
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
	chan child_TestConfigurableStartStop3510 = [1] of {int};
	run TestConfigurableStartStop351(child_TestConfigurableStartStop3510);
	run receiver(child_TestConfigurableStartStop3510)
stop_process:skip
}

proctype TestConfigurableStartStop351(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_stop2290 = [1] of {int};
	chan child_stop2294 = [1] of {int};
	chan child_start2133 = [1] of {int};
	chan child_stop2292 = [1] of {int};
	chan child_start2131 = [1] of {int};
	Mutexdef operator_appsLock;
	Mutexdef operator_srv_apps_mu;
	Wgdef operator_srv_watchdogWG;
	Wgdef operator_srv_server_serveWG;
	Mutexdef operator_srv_server_channelzRemoveOnce_m;
	Mutexdef operator_srv_server_mu;
	Mutexdef operator_stateResolver_mu;
	run mutexMonitor(operator_stateResolver_mu);
	run mutexMonitor(operator_srv_server_mu);
	run mutexMonitor(operator_srv_server_channelzRemoveOnce_m);
	run wgMonitor(operator_srv_server_serveWG);
	run wgMonitor(operator_srv_watchdogWG);
	run mutexMonitor(operator_srv_apps_mu);
	run mutexMonitor(operator_appsLock);
	

	if
	:: 0 != -2 && 3-1 != -3 -> 
				for(i : 0.. 3-1) {
			for21: skip;
			run start213(operator_srv_server_serveWG,operator_srv_watchdogWG,operator_appsLock,operator_srv_apps_mu,operator_srv_server_channelzRemoveOnce_m,operator_srv_server_mu,operator_stateResolver_mu,child_start2133);
			child_start2133?0;
			run stop229(operator_srv_server_serveWG,operator_srv_watchdogWG,operator_appsLock,operator_srv_apps_mu,operator_srv_server_channelzRemoveOnce_m,operator_srv_server_mu,operator_stateResolver_mu,child_stop2294);
			child_stop2294?0;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run start213(operator_srv_server_serveWG,operator_srv_watchdogWG,operator_appsLock,operator_srv_apps_mu,operator_srv_server_channelzRemoveOnce_m,operator_srv_server_mu,operator_stateResolver_mu,child_start2131);
			child_start2131?0;
			run stop229(operator_srv_server_serveWG,operator_srv_watchdogWG,operator_appsLock,operator_srv_apps_mu,operator_srv_server_channelzRemoveOnce_m,operator_srv_server_mu,operator_stateResolver_mu,child_stop2292);
			child_stop2292?0;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
		defer1: skip;
	run stop229(operator_srv_server_serveWG,operator_srv_watchdogWG,operator_appsLock,operator_srv_apps_mu,operator_srv_server_channelzRemoveOnce_m,operator_srv_server_mu,operator_stateResolver_mu,child_stop2290);
	child_stop2290?0;
	stop_process: skip;
	child!0
}
proctype stop229(Wgdef o_srv_server_serveWG;Wgdef o_srv_watchdogWG;Mutexdef o_appsLock;Mutexdef o_srv_apps_mu;Mutexdef o_srv_server_channelzRemoveOnce_m;Mutexdef o_srv_server_mu;Mutexdef o_stateResolver_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runFlow2470 = [1] of {int};
	int var_flow = def_var_flow;
	run runFlow247(o_srv_server_serveWG,o_srv_watchdogWG,o_appsLock,o_srv_apps_mu,o_srv_server_channelzRemoveOnce_m,o_srv_server_mu,o_stateResolver_mu,var_flow,child_runFlow2470);
	child_runFlow2470?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype runFlow247(Wgdef o_srv_server_serveWG;Wgdef o_srv_watchdogWG;Mutexdef o_appsLock;Mutexdef o_srv_apps_mu;Mutexdef o_srv_server_channelzRemoveOnce_m;Mutexdef o_srv_server_mu;Mutexdef o_stateResolver_mu;int var_operations;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_deleteApp3571 = [1] of {int};
	chan child_getApp2870 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getApp287(o_srv_server_serveWG,o_srv_watchdogWG,o_appsLock,o_srv_apps_mu,o_srv_server_channelzRemoveOnce_m,o_srv_server_mu,o_stateResolver_mu,child_getApp2870);
	child_getApp2870?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run deleteApp357(o_srv_server_serveWG,o_srv_watchdogWG,o_appsLock,o_srv_apps_mu,o_srv_server_channelzRemoveOnce_m,o_srv_server_mu,o_stateResolver_mu,child_deleteApp3571);
		child_deleteApp3571?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getApp287(Wgdef o_srv_server_serveWG;Wgdef o_srv_watchdogWG;Mutexdef o_appsLock;Mutexdef o_srv_apps_mu;Mutexdef o_srv_server_channelzRemoveOnce_m;Mutexdef o_srv_server_mu;Mutexdef o_stateResolver_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	o_appsLock.Lock!false;
	

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
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	o_appsLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype deleteApp357(Wgdef o_srv_server_serveWG;Wgdef o_srv_watchdogWG;Mutexdef o_appsLock;Mutexdef o_srv_apps_mu;Mutexdef o_srv_server_channelzRemoveOnce_m;Mutexdef o_srv_server_mu;Mutexdef o_stateResolver_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	o_appsLock.Lock!false;
		defer1: skip;
	o_appsLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype start213(Wgdef o_srv_server_serveWG;Wgdef o_srv_watchdogWG;Mutexdef o_appsLock;Mutexdef o_srv_apps_mu;Mutexdef o_srv_server_channelzRemoveOnce_m;Mutexdef o_srv_server_mu;Mutexdef o_stateResolver_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runFlow2471 = [1] of {int};
	int var_flow = def_var_flow;
	run runFlow247(o_srv_server_serveWG,o_srv_watchdogWG,o_appsLock,o_srv_apps_mu,o_srv_server_channelzRemoveOnce_m,o_srv_server_mu,o_stateResolver_mu,var_flow,child_runFlow2471);
	child_runFlow2471?0;
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

