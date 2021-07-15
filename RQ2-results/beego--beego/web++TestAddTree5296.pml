#define not_found_292  3

// https://github.com/beego/beego/blob/master/server/web/tree_test.go#L296
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAddTree52960 = [1] of {int};
	run TestAddTree5296(child_TestAddTree52960)
stop_process:skip
}

proctype TestAddTree5296(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Match2870 = [1] of {int};
	Mutexdef ctx_Input_dataLock;
	run mutexMonitor(ctx_Input_dataLock);
	run Match287(ctx_Input_dataLock,child_Match2870);
	child_Match2870?0;
	stop_process: skip;
	child!0
}
proctype Match287(Mutexdef ctx_Input_dataLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_match2950 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run match295(ctx_Input_dataLock,not_found_292,child_match2950);
	child_match2950?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype match295(Mutexdef ctx_Input_dataLock;int pattern;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_match39611 = [1] of {int};
	chan child_match39612 = [1] of {int};
	chan child_match29510 = [1] of {int};
	chan child_match2956 = [1] of {int};
	chan child_match2957 = [1] of {int};
	chan child_match2958 = [1] of {int};
	chan child_match2959 = [1] of {int};
	chan child_match2954 = [1] of {int};
	chan child_match2955 = [1] of {int};
	chan child_match3962 = [1] of {int};
	chan child_match3963 = [1] of {int};
	chan child_match3960 = [1] of {int};
	chan child_match3961 = [1] of {int};
	int t_leaves=-2;
	int t_wildcard_leaves=-2;
	int t_fixrouters=0;
	int allowSuffixExt=3;
	

	if
	:: true -> 
		

		if
		:: t_leaves-1 != -3 -> 
						for(i : 0.. t_leaves-1) {
				for20: skip;
				run match396(ctx_Input_dataLock,child_match3960);
				child_match3960?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				for20_end: skip
			};
			for20_exit: skip
		:: else -> 
			do
			:: true -> 
				for27: skip;
				run match396(ctx_Input_dataLock,child_match3961);
				child_match3961?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				for27_end: skip
			:: true -> 
				break
			od;
			for27_exit: skip
		fi;
		

		if
		:: true -> 
			

			if
			:: t_wildcard_leaves-1 != -3 -> 
								for(i : 0.. t_wildcard_leaves-1) {
					for30: skip;
					run match396(ctx_Input_dataLock,child_match3962);
					child_match3962?0;
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					for30_end: skip
				};
				for30_exit: skip
			:: else -> 
				do
				:: true -> 
					for31: skip;
					run match396(ctx_Input_dataLock,child_match3963);
					child_match3963?0;
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					for31_end: skip
				:: true -> 
					break
				od;
				for31_exit: skip
			fi
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: t_fixrouters-1 != -3 -> 
				for(i : 0.. t_fixrouters-1) {
			for50: skip;
			

			if
			:: true -> 
				run match295(ctx_Input_dataLock,pattern,child_match2954);
				child_match2954?0;
				

				if
				:: true -> 
					break
				:: true;
				fi
			:: true;
			fi;
			for50_end: skip
		};
		for50_exit: skip
	:: else -> 
		do
		:: true -> 
			for51: skip;
			

			if
			:: true -> 
				run match295(ctx_Input_dataLock,pattern,child_match2955);
				child_match2955?0;
				

				if
				:: true -> 
					break
				:: true;
				fi
			:: true;
			fi;
			for51_end: skip
		:: true -> 
			break
		od;
		for51_exit: skip
	fi;
	

	if
	:: true -> 
		

		if
		:: allowSuffixExt-1 != -3 -> 
						for(i : 0.. allowSuffixExt-1) {
				for60: skip;
				

				if
				:: true -> 
					

					if
					:: t_fixrouters-1 != -3 -> 
												for(i : 0.. t_fixrouters-1) {
							for61: skip;
							

							if
							:: true -> 
								run match295(ctx_Input_dataLock,pattern,child_match2956);
								child_match2956?0
							:: true;
							fi;
							for61_end: skip
						};
						for61_exit: skip
					:: else -> 
						do
						:: true -> 
							for62: skip;
							

							if
							:: true -> 
								run match295(ctx_Input_dataLock,pattern,child_match2957);
								child_match2957?0
							:: true;
							fi;
							for62_end: skip
						:: true -> 
							break
						od;
						for62_exit: skip
					fi
				:: true;
				fi;
				for60_end: skip
			};
			for60_exit: skip
		:: else -> 
			do
			:: true -> 
				for63: skip;
				

				if
				:: true -> 
					

					if
					:: t_fixrouters-1 != -3 -> 
												for(i : 0.. t_fixrouters-1) {
							for64: skip;
							

							if
							:: true -> 
								run match295(ctx_Input_dataLock,pattern,child_match2958);
								child_match2958?0
							:: true;
							fi;
							for64_end: skip
						};
						for64_exit: skip
					:: else -> 
						do
						:: true -> 
							for65: skip;
							

							if
							:: true -> 
								run match295(ctx_Input_dataLock,pattern,child_match2959);
								child_match2959?0
							:: true;
							fi;
							for65_end: skip
						:: true -> 
							break
						od;
						for65_exit: skip
					fi
				:: true;
				fi;
				for63_end: skip
			:: true -> 
				break
			od;
			for63_exit: skip
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		run match295(ctx_Input_dataLock,pattern,child_match29510);
		child_match29510?0
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: t_leaves-1 != -3 -> 
						for(i : 0.. t_leaves-1) {
				for80: skip;
				run match396(ctx_Input_dataLock,child_match39611);
				child_match39611?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				for80_end: skip
			};
			for80_exit: skip
		:: else -> 
			do
			:: true -> 
				for81: skip;
				run match396(ctx_Input_dataLock,child_match39612);
				child_match39612?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				for81_end: skip
			:: true -> 
				break
			od;
			for81_exit: skip
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype match396(Mutexdef ctx_Input_dataLock;chan child) {
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
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
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


