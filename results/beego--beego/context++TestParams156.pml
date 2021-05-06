
// https://github.com/beego/beego/blob/master/server/web/context/input_test.go#L156
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestParams1560 = [1] of {int};
	run TestParams156(child_TestParams1560)
stop_process:skip
}

proctype TestParams156(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Param28312 = [1] of {int};
	chan child_Param28311 = [1] of {int};
	chan child_ParamsLen27810 = [1] of {int};
	chan child_Params2989 = [1] of {int};
	chan child_SetParam3098 = [1] of {int};
	chan child_SetParam3097 = [1] of {int};
	chan child_Params2986 = [1] of {int};
	chan child_Param2835 = [1] of {int};
	chan child_Param2834 = [1] of {int};
	chan child_ParamsLen2783 = [1] of {int};
	chan child_SetParam3092 = [1] of {int};
	chan child_SetParam3091 = [1] of {int};
	chan child_SetParam3090 = [1] of {int};
	Mutexdef inp_dataLock;
	run mutexMonitor(inp_dataLock);
	run SetParam309(inp_dataLock,child_SetParam3090);
	child_SetParam3090?0;
	run SetParam309(inp_dataLock,child_SetParam3091);
	child_SetParam3091?0;
	run SetParam309(inp_dataLock,child_SetParam3092);
	child_SetParam3092?0;
	run ParamsLen278(inp_dataLock,child_ParamsLen2783);
	child_ParamsLen2783?0;
	run Param283(inp_dataLock,child_Param2834);
	child_Param2834?0;
	run Param283(inp_dataLock,child_Param2835);
	child_Param2835?0;
	run Params298(inp_dataLock,child_Params2986);
	child_Params2986?0;
	run SetParam309(inp_dataLock,child_SetParam3097);
	child_SetParam3097?0;
	run SetParam309(inp_dataLock,child_SetParam3098);
	child_SetParam3098?0;
	run Params298(inp_dataLock,child_Params2989);
	child_Params2989?0;
	run ParamsLen278(inp_dataLock,child_ParamsLen27810);
	child_ParamsLen27810?0;
	run Param283(inp_dataLock,child_Param28311);
	child_Param28311?0;
	run Param283(inp_dataLock,child_Param28312);
	child_Param28312?0;
	stop_process: skip;
	child!0
}
proctype SetParam309(Mutexdef input_dataLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype ParamsLen278(Mutexdef input_dataLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Param283(Mutexdef input_dataLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Params298(Mutexdef input_dataLock;chan child) {
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

