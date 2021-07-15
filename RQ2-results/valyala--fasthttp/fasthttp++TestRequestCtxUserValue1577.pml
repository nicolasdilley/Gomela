
// https://github.com/valyala/fasthttp/blob/master/server_test.go#L1577
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRequestCtxUserValue15770 = [1] of {int};
	run TestRequestCtxUserValue1577(child_TestRequestCtxUserValue15770)
stop_process:skip
}

proctype TestRequestCtxUserValue1577(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_VisitUserValues6886 = [1] of {int};
	chan child_UserValue6745 = [1] of {int};
	chan child_UserValue6744 = [1] of {int};
	chan child_SetUserValueBytes6693 = [1] of {int};
	chan child_SetUserValueBytes6692 = [1] of {int};
	chan child_SetUserValue6561 = [1] of {int};
	chan child_SetUserValue6560 = [1] of {int};
	Mutexdef ctx_s_mu;
	Mutexdef ctx_s_perIPConnCounter_lock;
	Mutexdef ctx_s_tlsConfig_mutex;
	run mutexMonitor(ctx_s_tlsConfig_mutex);
	run mutexMonitor(ctx_s_perIPConnCounter_lock);
	run mutexMonitor(ctx_s_mu);
	

	if
	:: 0 != -2 && 5-1 != -3 -> 
				for(i : 0.. 5-1) {
			for11: skip;
			run SetUserValue656(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_SetUserValue6561);
			child_SetUserValue6561?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run SetUserValue656(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_SetUserValue6560);
			child_SetUserValue6560?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: 0 != -2 && 10-1 != -3 -> 
				for(i : 0.. 10-1) {
			for21: skip;
			run SetUserValueBytes669(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_SetUserValueBytes6693);
			child_SetUserValueBytes6693?0;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run SetUserValueBytes669(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_SetUserValueBytes6692);
			child_SetUserValueBytes6692?0;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	

	if
	:: 0 != -2 && 10-1 != -3 -> 
				for(i : 0.. 10-1) {
			for31: skip;
			run UserValue674(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_UserValue6745);
			child_UserValue6745?0;
			for31_end: skip
		};
		for31_exit: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			run UserValue674(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_UserValue6744);
			child_UserValue6744?0;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	run VisitUserValues688(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_VisitUserValues6886);
	child_VisitUserValues6886?0;
	stop_process: skip;
	child!0
}
proctype SetUserValue656(Mutexdef ctx_s_tlsConfig_mutex;Mutexdef ctx_s_perIPConnCounter_lock;Mutexdef ctx_s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype SetUserValueBytes669(Mutexdef ctx_s_tlsConfig_mutex;Mutexdef ctx_s_perIPConnCounter_lock;Mutexdef ctx_s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype UserValue674(Mutexdef ctx_s_tlsConfig_mutex;Mutexdef ctx_s_perIPConnCounter_lock;Mutexdef ctx_s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype VisitUserValues688(Mutexdef ctx_s_tlsConfig_mutex;Mutexdef ctx_s_perIPConnCounter_lock;Mutexdef ctx_s_mu;chan child) {
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

