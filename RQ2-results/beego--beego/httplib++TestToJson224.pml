
// https://github.com/beego/beego/blob/master/client/httplib/httplib_test.go#L224
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestToJson2240 = [1] of {int};
	run TestToJson224(child_TestToJson2240)
stop_process:skip
}

proctype TestToJson224(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ToJSON6271 = [1] of {int};
	chan child_Response6590 = [1] of {int};
	Mutexdef req_setting_TLSClientConfig_mutex;
	run mutexMonitor(req_setting_TLSClientConfig_mutex);
	run Response659(req_setting_TLSClientConfig_mutex,child_Response6590);
	child_Response6590?0;
	run ToJSON627(req_setting_TLSClientConfig_mutex,child_ToJSON6271);
	child_ToJSON6271?0;
	stop_process: skip;
	child!0
}
proctype Response659(Mutexdef b_setting_TLSClientConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getResponse4180 = [1] of {int};
	run getResponse418(b_setting_TLSClientConfig_mutex,child_getResponse4180);
	child_getResponse4180?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getResponse418(Mutexdef b_setting_TLSClientConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DoRequest4310 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run DoRequest431(b_setting_TLSClientConfig_mutex,child_DoRequest4310);
	child_DoRequest4310?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DoRequest431(Mutexdef b_setting_TLSClientConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DoRequestWithCtx4350 = [1] of {int};
	run DoRequestWithCtx435(b_setting_TLSClientConfig_mutex,child_DoRequestWithCtx4350);
	child_DoRequestWithCtx4350?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DoRequestWithCtx435(Mutexdef b_setting_TLSClientConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ToJSON627(Mutexdef b_setting_TLSClientConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Bytes5611 = [1] of {int};
	run Bytes561(b_setting_TLSClientConfig_mutex,child_Bytes5611);
	child_Bytes5611?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Bytes561(Mutexdef b_setting_TLSClientConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getResponse4181 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getResponse418(b_setting_TLSClientConfig_mutex,child_getResponse4181);
	child_getResponse4181?0;
	

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
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
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

