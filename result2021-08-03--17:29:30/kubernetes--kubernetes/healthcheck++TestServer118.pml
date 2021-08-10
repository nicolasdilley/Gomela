// num_comm_params=15
// num_mand_comm_params=5
// num_opt_comm_params=10

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/proxy/healthcheck/healthcheck_test.go#L118
#define not_found_129  ?? // mand newServices line 76
#define not_found_133  -2 // opt newEndpoints line 177
#define not_found_139  -2 // opt newEndpoints line 177
#define not_found_146  ?? // mand newServices line 76
#define not_found_163  -2 // opt newEndpoints line 177
#define not_found_174  -2 // opt newEndpoints line 177
#define not_found_185  -2 // opt newEndpoints line 177
#define not_found_193  -2 // opt newEndpoints line 177
#define not_found_204  -2 // opt newEndpoints line 177
#define not_found_212  ?? // mand newServices line 76
#define not_found_222  ?? // mand newServices line 76
#define not_found_248  -2 // opt newEndpoints line 177
#define not_found_271  ?? // mand newServices line 76
#define not_found_295  -2 // opt newEndpoints line 177
#define not_found_319  -2 // opt newEndpoints line 177
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestServer1180 = [1] of {int};
	run TestServer118(child_TestServer1180);
	run receiver(child_TestServer1180)
stop_process:skip
}

proctype TestServer118(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_testHandler34133 = [1] of {int};
	chan child_testHandler34132 = [1] of {int};
	chan child_testHandler34131 = [1] of {int};
	chan child_SyncEndpoints17730 = [1] of {int};
	chan child_testHandler34129 = [1] of {int};
	chan child_testHandler34128 = [1] of {int};
	chan child_testHandler34127 = [1] of {int};
	chan child_SyncEndpoints17726 = [1] of {int};
	chan child_testHandler34125 = [1] of {int};
	chan child_testHandler34124 = [1] of {int};
	chan child_testHandler34123 = [1] of {int};
	chan child_SyncServices7622 = [1] of {int};
	chan child_testHandler34121 = [1] of {int};
	chan child_testHandler34120 = [1] of {int};
	chan child_testHandler34119 = [1] of {int};
	chan child_SyncEndpoints17718 = [1] of {int};
	chan child_testHandler34117 = [1] of {int};
	chan child_testHandler34116 = [1] of {int};
	chan child_testHandler34115 = [1] of {int};
	chan child_SyncServices7614 = [1] of {int};
	chan child_SyncServices7613 = [1] of {int};
	chan child_SyncEndpoints17712 = [1] of {int};
	chan child_testHandler34111 = [1] of {int};
	chan child_SyncEndpoints17710 = [1] of {int};
	chan child_SyncEndpoints1779 = [1] of {int};
	chan child_testHandler3418 = [1] of {int};
	chan child_SyncEndpoints1777 = [1] of {int};
	chan child_testHandler3416 = [1] of {int};
	chan child_SyncEndpoints1775 = [1] of {int};
	chan child_testHandler3414 = [1] of {int};
	chan child_SyncServices763 = [1] of {int};
	chan child_SyncEndpoints1772 = [1] of {int};
	chan child_SyncEndpoints1771 = [1] of {int};
	chan child_SyncServices760 = [1] of {int};
	Mutexdef hcs_lock;
	run mutexMonitor(hcs_lock);
	run SyncServices76(hcs_lock,not_found_129,child_SyncServices760);
	child_SyncServices760?0;
	run SyncEndpoints177(hcs_lock,not_found_133,child_SyncEndpoints1771);
	child_SyncEndpoints1771?0;
	run SyncEndpoints177(hcs_lock,not_found_139,child_SyncEndpoints1772);
	child_SyncEndpoints1772?0;
	run SyncServices76(hcs_lock,not_found_146,child_SyncServices763);
	child_SyncServices763?0;
	run testHandler341(hcs_lock,child_testHandler3414);
	child_testHandler3414?0;
	run SyncEndpoints177(hcs_lock,not_found_163,child_SyncEndpoints1775);
	child_SyncEndpoints1775?0;
	run testHandler341(hcs_lock,child_testHandler3416);
	child_testHandler3416?0;
	run SyncEndpoints177(hcs_lock,not_found_174,child_SyncEndpoints1777);
	child_SyncEndpoints1777?0;
	run testHandler341(hcs_lock,child_testHandler3418);
	child_testHandler3418?0;
	run SyncEndpoints177(hcs_lock,not_found_185,child_SyncEndpoints1779);
	child_SyncEndpoints1779?0;
	run SyncEndpoints177(hcs_lock,not_found_193,child_SyncEndpoints17710);
	child_SyncEndpoints17710?0;
	run testHandler341(hcs_lock,child_testHandler34111);
	child_testHandler34111?0;
	run SyncEndpoints177(hcs_lock,not_found_204,child_SyncEndpoints17712);
	child_SyncEndpoints17712?0;
	run SyncServices76(hcs_lock,not_found_212,child_SyncServices7613);
	child_SyncServices7613?0;
	run SyncServices76(hcs_lock,not_found_222,child_SyncServices7614);
	child_SyncServices7614?0;
	run testHandler341(hcs_lock,child_testHandler34115);
	child_testHandler34115?0;
	run testHandler341(hcs_lock,child_testHandler34116);
	child_testHandler34116?0;
	run testHandler341(hcs_lock,child_testHandler34117);
	child_testHandler34117?0;
	run SyncEndpoints177(hcs_lock,not_found_248,child_SyncEndpoints17718);
	child_SyncEndpoints17718?0;
	run testHandler341(hcs_lock,child_testHandler34119);
	child_testHandler34119?0;
	run testHandler341(hcs_lock,child_testHandler34120);
	child_testHandler34120?0;
	run testHandler341(hcs_lock,child_testHandler34121);
	child_testHandler34121?0;
	run SyncServices76(hcs_lock,not_found_271,child_SyncServices7622);
	child_SyncServices7622?0;
	run testHandler341(hcs_lock,child_testHandler34123);
	child_testHandler34123?0;
	run testHandler341(hcs_lock,child_testHandler34124);
	child_testHandler34124?0;
	run testHandler341(hcs_lock,child_testHandler34125);
	child_testHandler34125?0;
	run SyncEndpoints177(hcs_lock,not_found_295,child_SyncEndpoints17726);
	child_SyncEndpoints17726?0;
	run testHandler341(hcs_lock,child_testHandler34127);
	child_testHandler34127?0;
	run testHandler341(hcs_lock,child_testHandler34128);
	child_testHandler34128?0;
	run testHandler341(hcs_lock,child_testHandler34129);
	child_testHandler34129?0;
	run SyncEndpoints177(hcs_lock,not_found_319,child_SyncEndpoints17730);
	child_SyncEndpoints17730?0;
	run testHandler341(hcs_lock,child_testHandler34131);
	child_testHandler34131?0;
	run testHandler341(hcs_lock,child_testHandler34132);
	child_testHandler34132?0;
	run testHandler341(hcs_lock,child_testHandler34133);
	child_testHandler34133?0;
	stop_process: skip;
	child!0
}
proctype SyncServices76(Mutexdef hcs_lock;int var_newServices;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousSyncServices1211210 = [1] of {int};
	int var_hcs_services = -2; // opt var_hcs_services
	hcs_lock.Lock!false;
		for(i : 0.. var_newServices-1) {
		for20: skip;
		

		if
		:: true -> 
			goto for20_end
		:: true;
		fi;
		

		if
		:: true -> 
			goto for20_end
		:: true;
		fi;
		run AnonymousSyncServices121121(hcs_lock,child_AnonymousSyncServices1211210);
		run receiver(child_AnonymousSyncServices1211210);
		for20_end: skip
	};
	for20_exit: skip;
	goto defer1;
		defer1: skip;
	hcs_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype AnonymousSyncServices121121(Mutexdef hcs_lock;chan child) {
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
proctype SyncEndpoints177(Mutexdef hcs_lock;int var_newEndpoints;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_hcs_services = -2; // opt var_hcs_services
	hcs_lock.Lock!false;
	goto defer1;
		defer1: skip;
	hcs_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype testHandler341(Mutexdef hcs_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

