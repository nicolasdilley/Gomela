// num_comm_params=3
// num_mand_comm_params=0
// num_opt_comm_params=3

// git_link=https://github.com/sirupsen/logrus/blob/b50299cfaaa1bca85be76c8984070e846c7abfd2/text_formatter_test.go#L322
#define not_found_203  -2 // opt not_found_203
#define not_found_334  -2 // opt not_found_334
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTextFormatterFieldMap3220 = [1] of {int};
	run TestTextFormatterFieldMap322(child_TestTextFormatterFieldMap3220);
	run receiver(child_TestTextFormatterFieldMap3220)
stop_process:skip
}

proctype TestTextFormatterFieldMap322(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Format1330 = [1] of {int};
	Mutexdef formatter_terminalInitOnce_m;
	run mutexMonitor(formatter_terminalInitOnce_m);
	run Format133(formatter_terminalInitOnce_m,child_Format1330);
	child_Format1330?0;
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
	int fixedKeys = -2; // opt fixedKeys
	int data = -2; // opt data
	int entry_Data = -2; // opt entry_Data
	

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
		:: fixedKeys-1 != -3 -> 
						for(i : 0.. fixedKeys-1) {
				for40: skip;
				

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
				for40_end: skip
			};
			for40_exit: skip
		:: else -> 
			do
			:: true -> 
				for41: skip;
				

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
				for41_end: skip
			:: true -> 
				break
			od;
			for41_exit: skip
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
	:: keys-1 != -3 -> 
				for(i : 0.. keys-1) {
			for30: skip;
			run appendValue328(f_terminalInitOnce_m,child_appendValue3282);
			child_appendValue3282?0;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for33: skip;
			run appendValue328(f_terminalInitOnce_m,child_appendValue3283);
			child_appendValue3283?0;
			for33_end: skip
		:: true -> 
			break
		od;
		for33_exit: skip
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

