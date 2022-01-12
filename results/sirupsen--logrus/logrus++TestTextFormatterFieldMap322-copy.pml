// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/sirupsen/logrus/blob//text_formatter_test.go#L322
#define def_var_keys  -2 // opt keys line 232
#define def_var_stringVal  -2 // opt text line 298
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
	int var_keys = def_var_keys;
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
	int var_fixedKeys = -2; // opt var_fixedKeys
	int var_data = -2; // opt var_data
	int var_entry_Data = -2; // opt var_entry_Data
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
		run printColored232(f_terminalInitOnce_m,entry_Logger_mu_lock,var_keys,child_printColored2324);
		child_printColored2324?0
	:: true -> 
		

		if
		:: var_fixedKeys-1 != -3 -> 
						for(i : 0.. var_fixedKeys-1) {
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
proctype printColored232(Mutexdef f_terminalInitOnce_m;Mutexdef entry_Logger_mu_lock;int var_keys;chan child) {
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
	:: var_keys-1 != -3 -> 
				for(i : 0.. var_keys-1) {
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
	int var_stringVal = def_var_stringVal;
	run needsQuoting298(f_terminalInitOnce_m,var_stringVal,child_needsQuoting2985);
	child_needsQuoting2985?0;
	stop_process: skip;
	child!0
}
proctype needsQuoting298(Mutexdef f_terminalInitOnce_m;int var_text;chan child) {
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

proctype receiver(chan c) {
c?0
}

