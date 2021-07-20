// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/sirupsen/logrus/blob/b50299cfaaa1bca85be76c8984070e846c7abfd2/text_formatter_test.go#L119
#define not_found_203  -2 // opt keys line 232
#define not_found_334  -2 // opt text line 298
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEscaping_Interface1190 = [1] of {int};
	run TestEscaping_Interface119(child_TestEscaping_Interface1190);
	run receiver(child_TestEscaping_Interface1190)
stop_process:skip
}

proctype TestEscaping_Interface119(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Format1330 = [1] of {int};
	chan child_Format1331 = [1] of {int};
	Mutexdef tf_terminalInitOnce_m;
	int var_testCasestestCases = -2; // opt var_testCasestestCases
	run mutexMonitor(tf_terminalInitOnce_m);
	

	if
	:: var_testCases-1 != -3 -> 
				for(i : 0.. var_testCases-1) {
			for10: skip;
			run Format133(tf_terminalInitOnce_m,child_Format1330);
			child_Format1330?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for111: skip;
			run Format133(tf_terminalInitOnce_m,child_Format1331);
			child_Format1331?0;
			for111_end: skip
		:: true -> 
			break
		od;
		for111_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype Format133(Mutexdef f_terminalInitOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_printColored2322 = [1] of {int};
	chan child_appendKeyValue3193 = [1] of {int};
	chan child_appendKeyValue3194 = [1] of {int};
	chan child_isColored1171 = [1] of {int};
	chan child_isColored1170 = [1] of {int};
	int var_fixedKeysfixedKeys = -2; // opt var_fixedKeysfixedKeys
	int var_datadata = -2; // opt var_datadata
	int var_entry_Dataentry_Data = -2; // opt var_entry_Dataentry_Data
	

	if
	:: true -> 
		

		if
		:: true -> 
			run isColored117(f_terminalInitOnce_m,child_isColored1170);
			child_isColored1170?0
		fi
	fi;
	run isColored117(f_terminalInitOnce_m,child_isColored1171);
	child_isColored1171?0;
	

	if
	:: true -> 
		run printColored232(f_terminalInitOnce_m,not_found_203,child_printColored2322);
		child_printColored2322?0
	:: true -> 
		

		if
		:: var_fixedKeys-1 != -3 -> 
						for(i : 0.. var_fixedKeys-1) {
				for19: skip;
				

				if
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				fi;
				run appendKeyValue319(f_terminalInitOnce_m,child_appendKeyValue3193);
				child_appendKeyValue3193?0;
				for19_end: skip
			};
			for19_exit: skip
		:: else -> 
			do
			:: true -> 
				for110: skip;
				

				if
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				fi;
				run appendKeyValue319(f_terminalInitOnce_m,child_appendKeyValue3194);
				child_appendKeyValue3194?0;
				for110_end: skip
			:: true -> 
				break
			od;
			for110_exit: skip
		fi
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype isColored117(Mutexdef f_terminalInitOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true;
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype printColored232(Mutexdef f_terminalInitOnce_m;int keys;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_appendValue3282 = [1] of {int};
	chan child_appendValue3283 = [1] of {int};
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
	

	if
	:: true;
	:: true;
	:: true;
	fi;
	

	if
	:: var_keys-1 != -3 -> 
				for(i : 0.. var_keys-1) {
			for15: skip;
			run appendValue328(f_terminalInitOnce_m,child_appendValue3282);
			child_appendValue3282?0;
			for15_end: skip
		};
		for15_exit: skip
	:: else -> 
		do
		:: true -> 
			for18: skip;
			run appendValue328(f_terminalInitOnce_m,child_appendValue3283);
			child_appendValue3283?0;
			for18_end: skip
		:: true -> 
			break
		od;
		for18_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype appendValue328(Mutexdef f_terminalInitOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_needsQuoting2982 = [1] of {int};
	run needsQuoting298(f_terminalInitOnce_m,not_found_334,child_needsQuoting2982);
	child_needsQuoting2982?0;
	stop_process: skip;
	child!0
}
proctype needsQuoting298(Mutexdef f_terminalInitOnce_m;int text;chan child) {
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype appendKeyValue319(Mutexdef f_terminalInitOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_appendValue3283 = [1] of {int};
	run appendValue328(f_terminalInitOnce_m,child_appendValue3283);
	child_appendValue3283?0;
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

