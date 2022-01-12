// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/tchart/component_int_test.go#L18
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestComponentColorForSeries180 = [1] of {int};
	run TestComponentColorForSeries18(child_TestComponentColorForSeries180);
	run receiver(child_TestComponentColorForSeries180)
stop_process:skip
}

proctype TestComponentColorForSeries18(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetSeriesColorNames981 = [1] of {int};
	chan child_colorForSeries1170 = [1] of {int};
	Mutexdef c_mx;
	run mutexMonitor(c_mx);
	run colorForSeries117(c_mx,child_colorForSeries1170);
	child_colorForSeries1170?0;
	run GetSeriesColorNames98(c_mx,child_GetSeriesColorNames981);
	child_GetSeriesColorNames981?0;
	stop_process: skip;
	child!0
}
proctype colorForSeries117(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mx.RLock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	c_mx.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype GetSeriesColorNames98(Mutexdef c_mx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_tcell_ColorNames = -2; // opt var_tcell_ColorNames
	int var_c_seriesColors = -2; // opt var_c_seriesColors
	c_mx.RLock!false;
	goto defer1;
		defer1: skip;
	c_mx.RUnlock!false;
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

