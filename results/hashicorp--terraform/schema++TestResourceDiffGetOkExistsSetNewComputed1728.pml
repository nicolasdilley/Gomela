
// https://github.com/hashicorp/terraform/blob/master/internal/legacy/helper/schema/resource_diff_test.go#L1728
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestResourceDiffGetOkExistsSetNewComputed17280 = [1] of {int};
	run TestResourceDiffGetOkExistsSetNewComputed1728(child_TestResourceDiffGetOkExistsSetNewComputed17280)
stop_process:skip
}

proctype TestResourceDiffGetOkExistsSetNewComputed1728(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetOkExists4091 = [1] of {int};
	chan child_SetNewComputed3010 = [1] of {int};
	Mutexdef d_newWriter_once_m;
	Mutexdef d_newWriter_lock;
	Mutexdef d_diff_mu;
	Mutexdef d_state_mu;
	run mutexMonitor(d_state_mu);
	run mutexMonitor(d_diff_mu);
	run mutexMonitor(d_newWriter_lock);
	run mutexMonitor(d_newWriter_once_m);
	run SetNewComputed301(d_state_mu,d_diff_mu,d_newWriter_lock,d_newWriter_once_m,child_SetNewComputed3010);
	child_SetNewComputed3010?0;
	run GetOkExists409(d_state_mu,d_diff_mu,d_newWriter_lock,d_newWriter_once_m,child_GetOkExists4091);
	child_GetOkExists4091?0;
	stop_process: skip;
	child!0
}
proctype SetNewComputed301(Mutexdef d_state_mu;Mutexdef d_diff_mu;Mutexdef d_newWriter_lock;Mutexdef d_newWriter_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_setDiff3101 = [1] of {int};
	chan child_checkKey5380 = [1] of {int};
	run checkKey538(d_state_mu,d_diff_mu,d_newWriter_lock,d_newWriter_once_m,child_checkKey5380);
	child_checkKey5380?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run setDiff310(d_state_mu,d_diff_mu,d_newWriter_lock,d_newWriter_once_m,child_setDiff3101);
	child_setDiff3101?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype checkKey538(Mutexdef d_state_mu;Mutexdef d_diff_mu;Mutexdef d_newWriter_lock;Mutexdef d_newWriter_once_m;chan child) {
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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype setDiff310(Mutexdef d_state_mu;Mutexdef d_diff_mu;Mutexdef d_newWriter_lock;Mutexdef d_newWriter_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WriteField392 = [1] of {int};
	chan child_clear2411 = [1] of {int};
	run clear241(d_state_mu,d_diff_mu,d_newWriter_lock,d_newWriter_once_m,child_clear2411);
	child_clear2411?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run WriteField39(d_newWriter_lock,d_newWriter_once_m,child_WriteField392);
	child_WriteField392?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype clear241(Mutexdef d_state_mu;Mutexdef d_diff_mu;Mutexdef d_newWriter_lock;Mutexdef d_newWriter_once_m;chan child) {
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
proctype WriteField39(Mutexdef w_lock;Mutexdef w_once_m;chan child) {
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
	w_lock.Lock!false;
	goto stop_process;
	stop_process: skip;
		w_lock.Unlock!false;
	child!0
}
proctype GetOkExists409(Mutexdef d_state_mu;Mutexdef d_diff_mu;Mutexdef d_newWriter_lock;Mutexdef d_newWriter_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get4841 = [1] of {int};
	run get484(d_state_mu,d_diff_mu,d_newWriter_lock,d_newWriter_once_m,child_get4841);
	child_get4841?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype get484(Mutexdef d_state_mu;Mutexdef d_diff_mu;Mutexdef d_newWriter_lock;Mutexdef d_newWriter_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_finalizeResult5041 = [1] of {int};
	run finalizeResult504(d_state_mu,d_diff_mu,d_newWriter_lock,d_newWriter_once_m,child_finalizeResult5041);
	child_finalizeResult5041?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype finalizeResult504(Mutexdef d_state_mu;Mutexdef d_diff_mu;Mutexdef d_newWriter_lock;Mutexdef d_newWriter_once_m;chan child) {
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

