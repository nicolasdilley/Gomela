
// https://github.com/beego/beego/blob/master/server/web/controller_test.go#L201
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBindNoContentType2010 = [1] of {int};
	run TestBindNoContentType201(child_TestBindNoContentType2010)
stop_process:skip
}

proctype TestBindNoContentType201(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Bind2460 = [1] of {int};
	Mutexdef ctrlr_Ctx_Input_dataLock;
	Mutexdef ctx_Input_dataLock;
	Mutexdef input_dataLock;
	run mutexMonitor(input_dataLock);
	run mutexMonitor(ctx_Input_dataLock);
	run mutexMonitor(ctrlr_Ctx_Input_dataLock);
	run Bind246(ctrlr_Ctx_Input_dataLock,child_Bind2460);
	child_Bind2460?0;
	stop_process: skip;
	child!0
}
proctype Bind246(Mutexdef c_Ctx_Input_dataLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_BindJson2781 = [1] of {int};
	chan child_BindXML2862 = [1] of {int};
	chan child_BindForm2743 = [1] of {int};
	chan child_BindProtobuf2824 = [1] of {int};
	chan child_BindYAML2705 = [1] of {int};
	chan child_BindJson2780 = [1] of {int};
	

	if
	:: true -> 
		run BindJson278(c_Ctx_Input_dataLock,child_BindJson2780);
		child_BindJson2780?0;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run BindJson278(c_Ctx_Input_dataLock,child_BindJson2781);
		child_BindJson2781?0;
		goto stop_process
	:: true -> 
		run BindXML286(c_Ctx_Input_dataLock,child_BindXML2862);
		child_BindXML2862?0;
		goto stop_process
	:: true -> 
		run BindForm274(c_Ctx_Input_dataLock,child_BindForm2743);
		child_BindForm2743?0;
		goto stop_process
	:: true -> 
		run BindProtobuf282(c_Ctx_Input_dataLock,child_BindProtobuf2824);
		child_BindProtobuf2824?0;
		goto stop_process
	:: true -> 
		run BindYAML270(c_Ctx_Input_dataLock,child_BindYAML2705);
		child_BindYAML2705?0;
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	stop_process: skip;
	child!0
}
proctype BindJson278(Mutexdef c_Ctx_Input_dataLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype BindXML286(Mutexdef c_Ctx_Input_dataLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype BindForm274(Mutexdef c_Ctx_Input_dataLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ParseForm4863 = [1] of {int};
	run ParseForm486(c_Ctx_Input_dataLock,child_ParseForm4863);
	child_ParseForm4863?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ParseForm486(Mutexdef c_Ctx_Input_dataLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Input4753 = [1] of {int};
	run Input475(c_Ctx_Input_dataLock,child_Input4753);
	child_Input4753?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Input475(Mutexdef c_Ctx_Input_dataLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype BindProtobuf282(Mutexdef c_Ctx_Input_dataLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype BindYAML270(Mutexdef c_Ctx_Input_dataLock;chan child) {
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

