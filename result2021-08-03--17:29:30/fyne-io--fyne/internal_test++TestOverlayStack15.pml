// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/fyne-io/fyne/blob/9b5a176fe1dc80beae72a3074d0d5cd2b409637c/internal/overlay_stack_test.go#L15
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestOverlayStack150 = [1] of {int};
	run TestOverlayStack15(child_TestOverlayStack150);
	run receiver(child_TestOverlayStack150)
stop_process:skip
}

proctype TestOverlayStack15(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ListFocusManagers6050 = [1] of {int};
	chan child_TopFocusManager10149 = [1] of {int};
	chan child_Top9048 = [1] of {int};
	chan child_List5247 = [1] of {int};
	chan child_Remove7046 = [1] of {int};
	chan child_ListFocusManagers6045 = [1] of {int};
	chan child_TopFocusManager10144 = [1] of {int};
	chan child_Top9043 = [1] of {int};
	chan child_List5242 = [1] of {int};
	chan child_Remove7041 = [1] of {int};
	chan child_ListFocusManagers6040 = [1] of {int};
	chan child_TopFocusManager10139 = [1] of {int};
	chan child_Top9038 = [1] of {int};
	chan child_List5237 = [1] of {int};
	chan child_Remove7036 = [1] of {int};
	chan child_ListFocusManagers6035 = [1] of {int};
	chan child_TopFocusManager10134 = [1] of {int};
	chan child_Top9033 = [1] of {int};
	chan child_List5232 = [1] of {int};
	chan child_Add2531 = [1] of {int};
	chan child_ListFocusManagers6030 = [1] of {int};
	chan child_TopFocusManager10129 = [1] of {int};
	chan child_Add2528 = [1] of {int};
	chan child_ListFocusManagers6027 = [1] of {int};
	chan child_TopFocusManager10126 = [1] of {int};
	chan child_Add2525 = [1] of {int};
	chan child_ListFocusManagers6024 = [1] of {int};
	chan child_TopFocusManager10123 = [1] of {int};
	chan child_Add2522 = [1] of {int};
	chan child_ListFocusManagers6021 = [1] of {int};
	chan child_TopFocusManager10120 = [1] of {int};
	chan child_Add2519 = [1] of {int};
	chan child_ListFocusManagers6018 = [1] of {int};
	chan child_TopFocusManager10117 = [1] of {int};
	chan child_Top9016 = [1] of {int};
	chan child_List5215 = [1] of {int};
	chan child_Remove7014 = [1] of {int};
	chan child_ListFocusManagers6013 = [1] of {int};
	chan child_TopFocusManager10112 = [1] of {int};
	chan child_Top9011 = [1] of {int};
	chan child_List5210 = [1] of {int};
	chan child_Remove709 = [1] of {int};
	chan child_ListFocusManagers608 = [1] of {int};
	chan child_TopFocusManager1017 = [1] of {int};
	chan child_Top906 = [1] of {int};
	chan child_List525 = [1] of {int};
	chan child_Add254 = [1] of {int};
	chan child_ListFocusManagers603 = [1] of {int};
	chan child_TopFocusManager1012 = [1] of {int};
	chan child_Top901 = [1] of {int};
	chan child_List520 = [1] of {int};
	Mutexdef s_propertyLock;
	run mutexMonitor(s_propertyLock);
	run List52(s_propertyLock,child_List520);
	child_List520?0;
	run Top90(s_propertyLock,child_Top901);
	child_Top901?0;
	run TopFocusManager101(s_propertyLock,child_TopFocusManager1012);
	child_TopFocusManager1012?0;
	run ListFocusManagers60(s_propertyLock,child_ListFocusManagers603);
	child_ListFocusManagers603?0;
	run Add25(s_propertyLock,child_Add254);
	child_Add254?0;
	run List52(s_propertyLock,child_List525);
	child_List525?0;
	run Top90(s_propertyLock,child_Top906);
	child_Top906?0;
	run TopFocusManager101(s_propertyLock,child_TopFocusManager1017);
	child_TopFocusManager1017?0;
	run ListFocusManagers60(s_propertyLock,child_ListFocusManagers608);
	child_ListFocusManagers608?0;
	run Remove70(s_propertyLock,child_Remove709);
	child_Remove709?0;
	run List52(s_propertyLock,child_List5210);
	child_List5210?0;
	run Top90(s_propertyLock,child_Top9011);
	child_Top9011?0;
	run TopFocusManager101(s_propertyLock,child_TopFocusManager10112);
	child_TopFocusManager10112?0;
	run ListFocusManagers60(s_propertyLock,child_ListFocusManagers6013);
	child_ListFocusManagers6013?0;
	run Remove70(s_propertyLock,child_Remove7014);
	child_Remove7014?0;
	run List52(s_propertyLock,child_List5215);
	child_List5215?0;
	run Top90(s_propertyLock,child_Top9016);
	child_Top9016?0;
	run TopFocusManager101(s_propertyLock,child_TopFocusManager10117);
	child_TopFocusManager10117?0;
	run ListFocusManagers60(s_propertyLock,child_ListFocusManagers6018);
	child_ListFocusManagers6018?0;
	run Add25(s_propertyLock,child_Add2519);
	child_Add2519?0;
	run TopFocusManager101(s_propertyLock,child_TopFocusManager10120);
	child_TopFocusManager10120?0;
	run ListFocusManagers60(s_propertyLock,child_ListFocusManagers6021);
	child_ListFocusManagers6021?0;
	run Add25(s_propertyLock,child_Add2522);
	child_Add2522?0;
	run TopFocusManager101(s_propertyLock,child_TopFocusManager10123);
	child_TopFocusManager10123?0;
	run ListFocusManagers60(s_propertyLock,child_ListFocusManagers6024);
	child_ListFocusManagers6024?0;
	run Add25(s_propertyLock,child_Add2525);
	child_Add2525?0;
	run TopFocusManager101(s_propertyLock,child_TopFocusManager10126);
	child_TopFocusManager10126?0;
	run ListFocusManagers60(s_propertyLock,child_ListFocusManagers6027);
	child_ListFocusManagers6027?0;
	run Add25(s_propertyLock,child_Add2528);
	child_Add2528?0;
	run TopFocusManager101(s_propertyLock,child_TopFocusManager10129);
	child_TopFocusManager10129?0;
	run ListFocusManagers60(s_propertyLock,child_ListFocusManagers6030);
	child_ListFocusManagers6030?0;
	run Add25(s_propertyLock,child_Add2531);
	child_Add2531?0;
	run List52(s_propertyLock,child_List5232);
	child_List5232?0;
	run Top90(s_propertyLock,child_Top9033);
	child_Top9033?0;
	run TopFocusManager101(s_propertyLock,child_TopFocusManager10134);
	child_TopFocusManager10134?0;
	run ListFocusManagers60(s_propertyLock,child_ListFocusManagers6035);
	child_ListFocusManagers6035?0;
	run Remove70(s_propertyLock,child_Remove7036);
	child_Remove7036?0;
	run List52(s_propertyLock,child_List5237);
	child_List5237?0;
	run Top90(s_propertyLock,child_Top9038);
	child_Top9038?0;
	run TopFocusManager101(s_propertyLock,child_TopFocusManager10139);
	child_TopFocusManager10139?0;
	run ListFocusManagers60(s_propertyLock,child_ListFocusManagers6040);
	child_ListFocusManagers6040?0;
	run Remove70(s_propertyLock,child_Remove7041);
	child_Remove7041?0;
	run List52(s_propertyLock,child_List5242);
	child_List5242?0;
	run Top90(s_propertyLock,child_Top9043);
	child_Top9043?0;
	run TopFocusManager101(s_propertyLock,child_TopFocusManager10144);
	child_TopFocusManager10144?0;
	run ListFocusManagers60(s_propertyLock,child_ListFocusManagers6045);
	child_ListFocusManagers6045?0;
	run Remove70(s_propertyLock,child_Remove7046);
	child_Remove7046?0;
	run List52(s_propertyLock,child_List5247);
	child_List5247?0;
	run Top90(s_propertyLock,child_Top9048);
	child_Top9048?0;
	run TopFocusManager101(s_propertyLock,child_TopFocusManager10149);
	child_TopFocusManager10149?0;
	run ListFocusManagers60(s_propertyLock,child_ListFocusManagers6050);
	child_ListFocusManagers6050?0;
	stop_process: skip;
	child!0
}
proctype List52(Mutexdef s_propertyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_propertyLock.RLock!false;
	goto defer1;
		defer1: skip;
	s_propertyLock.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype Top90(Mutexdef s_propertyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_propertyLock.RLock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	s_propertyLock.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype TopFocusManager101(Mutexdef s_propertyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_topFocusManager1072 = [1] of {int};
	s_propertyLock.RLock!false;
	run topFocusManager107(s_propertyLock,child_topFocusManager1072);
	child_topFocusManager1072?0;
	goto defer1;
		defer1: skip;
	s_propertyLock.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype topFocusManager107(Mutexdef s_propertyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ListFocusManagers60(Mutexdef s_propertyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_propertyLock.RLock!false;
	goto defer1;
		defer1: skip;
	s_propertyLock.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype Add25(Mutexdef s_propertyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	s_propertyLock.Lock!false;
		defer1: skip;
	s_propertyLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Remove70(Mutexdef s_propertyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_s_overlays = -2; // opt var_s_overlays
	s_propertyLock.Lock!false;
		defer1: skip;
	s_propertyLock.Unlock!false;
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

