#define not_found_203  -2
#define not_found_334  -2

// https://github.com/sirupsen/logrus/blob/master/text_formatter_test.go#L322
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTextFormatterFieldMap3220 = [1] of {int};
	run TestTextFormatterFieldMap322(child_TestTextFormatterFieldMap3220)
stop_process:skip
}

proctype TestTextFormatterFieldMap322(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Format1330 = [1] of {int};
	Mutexdef entry_Logger_mu_lock;
	Mutexdef formatter_terminalInitOnce_m;
	run mutexMonitor(formatter_terminalInitOnce_m);
	run mutexMonitor(entry_Logger_mu_lock);
	run Format133(formatter_terminalInitOnce_m,entry_Logger_mu_lock,child_Format1330);
	child_Format1330?0;
	stop_process: skip;
	child!0
}
proctype Format133(Mutexdef f_terminalInitOnce_m;Mutexdef entry_Logger_mu_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_printColored2324 = [1] of {int};
	chan child_appendKeyValue3197 = [1] of {int};
	chan child_HasCaller2156 = [1] of {int};
	chan child_HasCaller2155 = [1] of {int};
	chan child_appendKeyValue31910 = [1] of {int};
	chan child_HasCaller2159 = [1] of {int};
	chan child_HasCaller2158 = [1] of {int};
	chan child_isColored1173 = [1] of {int};
	chan child_isColored1172 = [1] of {int};
	chan child_HasCaller2151 = [1] of {int};
	chan child_HasCaller2150 = [1] of {int};
	int fixedKeys = -2;
	run HasCaller215(entry_Logger_mu_lock,child_HasCaller2150);
	child_HasCaller2150?0;
	run HasCaller215(entry_Logger_mu_lock,child_HasCaller2151);
	child_HasCaller2151?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run isColored117(f_terminalInitOnce_m,child_isColored1172);
			child_isColored1172?0
		fi
	fi;
	run isColored117(f_terminalInitOnce_m,child_isColored1173);
	child_isColored1173?0;
	

	if
	:: true -> 
		run printColored232(f_terminalInitOnce_m,entry_Logger_mu_lock,not_found_203,child_printColored2324);
		child_printColored2324?0
	:: true -> 
		

		if
		:: fixedKeys-1 != -3 -> 
						for(i : 0.. fixedKeys-1) {
				for40: skip;
				run HasCaller215(entry_Logger_mu_lock,child_HasCaller2155);
				child_HasCaller2155?0;
				run HasCaller215(entry_Logger_mu_lock,child_HasCaller2156);
				child_HasCaller2156?0;
				

				if
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				fi;
				run appendKeyValue319(f_terminalInitOnce_m,child_appendKeyValue3197);
				child_appendKeyValue3197?0;
				for40_end: skip
			};
			for40_exit: skip
		:: else -> 
			do
			:: true -> 
				for41: skip;
				run HasCaller215(entry_Logger_mu_lock,child_HasCaller2158);
				child_HasCaller2158?0;
				run HasCaller215(entry_Logger_mu_lock,child_HasCaller2159);
				child_HasCaller2159?0;
				

				if
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				fi;
				run appendKeyValue319(f_terminalInitOnce_m,child_appendKeyValue31910);
				child_appendKeyValue31910?0;
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
proctype HasCaller215(Mutexdef entry_Logger_mu_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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
proctype printColored232(Mutexdef f_terminalInitOnce_m;Mutexdef entry_Logger_mu_lock;int keys;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_appendValue3285 = [1] of {int};
	chan child_appendValue3286 = [1] of {int};
	chan child_HasCaller2154 = [1] of {int};
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
	run HasCaller215(entry_Logger_mu_lock,child_HasCaller2154);
	child_HasCaller2154?0;
	

	if
	:: true;
	:: true;
	:: true;
	fi;
	

	if
	:: keys-1 != -3 -> 
				for(i : 0.. keys-1) {
			for30: skip;
			run appendValue328(f_terminalInitOnce_m,child_appendValue3285);
			child_appendValue3285?0;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for33: skip;
			run appendValue328(f_terminalInitOnce_m,child_appendValue3286);
			child_appendValue3286?0;
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
	chan child_needsQuoting2985 = [1] of {int};
	run needsQuoting298(f_terminalInitOnce_m,not_found_334,child_needsQuoting2985);
	child_needsQuoting2985?0;
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
	chan child_appendValue3287 = [1] of {int};
	run appendValue328(f_terminalInitOnce_m,child_appendValue3287);
	child_appendValue3287?0;
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

