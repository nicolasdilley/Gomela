// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/valyala/fasthttp/blob/19fcd408632d6dae8425ae95c6c62a25c823ff81/server_test.go#L1577
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRequestCtxUserValue15770 = [1] of {int};
	run TestRequestCtxUserValue1577(child_TestRequestCtxUserValue15770);
	run receiver(child_TestRequestCtxUserValue15770)
stop_process:skip
}

proctype TestRequestCtxUserValue1577(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_VisitUserValues6896 = [1] of {int};
	chan child_UserValue6755 = [1] of {int};
	chan child_UserValue6754 = [1] of {int};
	chan child_SetUserValueBytes6703 = [1] of {int};
	chan child_SetUserValueBytes6702 = [1] of {int};
	chan child_SetUserValue6571 = [1] of {int};
	chan child_SetUserValue6570 = [1] of {int};
	Mutexdef ctx_s_mu;
	run mutexMonitor(ctx_s_mu);
	

	if
	:: 0 != -2 && 5-1 != -3 -> 
				for(i : 0.. 5-1) {
			for11: skip;
			run SetUserValue657(ctx_s_mu,child_SetUserValue6571);
			child_SetUserValue6571?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run SetUserValue657(ctx_s_mu,child_SetUserValue6570);
			child_SetUserValue6570?0;
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
			run SetUserValueBytes670(ctx_s_mu,child_SetUserValueBytes6703);
			child_SetUserValueBytes6703?0;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run SetUserValueBytes670(ctx_s_mu,child_SetUserValueBytes6702);
			child_SetUserValueBytes6702?0;
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
			run UserValue675(ctx_s_mu,child_UserValue6755);
			child_UserValue6755?0;
			for31_end: skip
		};
		for31_exit: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			run UserValue675(ctx_s_mu,child_UserValue6754);
			child_UserValue6754?0;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	run VisitUserValues689(ctx_s_mu,child_VisitUserValues6896);
	child_VisitUserValues6896?0;
	stop_process: skip;
	child!0
}
proctype SetUserValue657(Mutexdef ctx_s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype SetUserValueBytes670(Mutexdef ctx_s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype UserValue675(Mutexdef ctx_s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype VisitUserValues689(Mutexdef ctx_s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_ctx_userValuesctx_userValues = -2; // opt var_ctx_userValuesctx_userValues
	int var_nn = -2; // opt var_nn
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

