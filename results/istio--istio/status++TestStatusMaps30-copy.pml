// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/istio/istio/blob//pilot/pkg/status/reporter_test.go#L30
#define not_found_44  -2 // opt types line 349
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStatusMaps300 = [1] of {int};
	run TestStatusMaps30(child_TestStatusMaps300);
	run receiver(child_TestStatusMaps300)
stop_process:skip
}

proctype TestStatusMaps30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RegisterDisconnect3495 = [1] of {int};
	chan child_processEvent3164 = [1] of {int};
	chan child_processEvent3163 = [1] of {int};
	chan child_processEvent3162 = [1] of {int};
	chan child_processEvent3161 = [1] of {int};
	chan child_processEvent3160 = [1] of {int};
	Mutexdef r_controller_mu;
	Mutexdef r_mu;
	run mutexMonitor(r_mu);
	run mutexMonitor(r_controller_mu);
	run processEvent316(r_controller_mu,r_mu,child_processEvent3160);
	child_processEvent3160?0;
	run processEvent316(r_controller_mu,r_mu,child_processEvent3161);
	child_processEvent3161?0;
	run processEvent316(r_controller_mu,r_mu,child_processEvent3162);
	child_processEvent3162?0;
	run processEvent316(r_controller_mu,r_mu,child_processEvent3163);
	child_processEvent3163?0;
	run processEvent316(r_controller_mu,r_mu,child_processEvent3164);
	child_processEvent3164?0;
	run RegisterDisconnect349(r_controller_mu,r_mu,not_found_44,child_RegisterDisconnect3495);
	child_RegisterDisconnect3495?0;
	stop_process: skip;
	child!0
}
proctype processEvent316(Mutexdef r_controller_mu;Mutexdef r_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_deleteKeyFromReverseMap3370 = [1] of {int};
	r_mu.Lock!false;
	run deleteKeyFromReverseMap337(r_controller_mu,r_mu,child_deleteKeyFromReverseMap3370);
	child_deleteKeyFromReverseMap3370?0;
		defer1: skip;
	r_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype deleteKeyFromReverseMap337(Mutexdef r_controller_mu;Mutexdef r_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype RegisterDisconnect349(Mutexdef r_controller_mu;Mutexdef r_mu;int var_types;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_deleteKeyFromReverseMap3375 = [1] of {int};
	chan child_deleteKeyFromReverseMap3376 = [1] of {int};
	r_mu.Lock!false;
	

	if
	:: var_types-1 != -3 -> 
				for(i : 0.. var_types-1) {
			for10: skip;
			run deleteKeyFromReverseMap337(r_controller_mu,r_mu,child_deleteKeyFromReverseMap3375);
			child_deleteKeyFromReverseMap3375?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run deleteKeyFromReverseMap337(r_controller_mu,r_mu,child_deleteKeyFromReverseMap3376);
			child_deleteKeyFromReverseMap3376?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
		defer1: skip;
	r_mu.Unlock!false;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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

