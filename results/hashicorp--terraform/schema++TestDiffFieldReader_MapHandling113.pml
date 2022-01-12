// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/hashicorp/terraform/blob//internal/legacy/helper/schema/field_reader_diff_test.go#L113
#define not_found_75  -2 // opt schema line 237
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDiffFieldReader_MapHandling1130 = [1] of {int};
	run TestDiffFieldReader_MapHandling113(child_TestDiffFieldReader_MapHandling1130);
	run receiver(child_TestDiffFieldReader_MapHandling1130)
stop_process:skip
}

proctype TestDiffFieldReader_MapHandling113(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ReadField420 = [1] of {int};
	Mutexdef r_Diff_mu;
	run mutexMonitor(r_Diff_mu);
	run ReadField42(r_Diff_mu,child_ReadField420);
	child_ReadField420?0;
	stop_process: skip;
	child!0
}
proctype ReadField42(Mutexdef r_Diff_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_readPrimitive1440 = [1] of {int};
	chan child_readListField1811 = [1] of {int};
	chan child_readMap872 = [1] of {int};
	chan child_readSet1773 = [1] of {int};
	chan child_readObjectField2344 = [1] of {int};
	

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
		run readPrimitive144(r_Diff_mu,child_readPrimitive1440);
		child_readPrimitive1440?0
	:: true -> 
		run readListField181(r_Diff_mu,child_readListField1811);
		child_readListField1811?0
	:: true -> 
		run readMap87(r_Diff_mu,child_readMap872);
		child_readMap872?0
	:: true -> 
		run readSet177(r_Diff_mu,child_readSet1773);
		child_readSet1773?0
	:: true -> 
		run readObjectField234(r_Diff_mu,not_found_75,child_readObjectField2344);
		child_readObjectField2344?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype readPrimitive144(Mutexdef r_Diff_mu;chan child) {
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
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
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
proctype readListField181(Mutexdef r_Diff_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_result = -2; // opt var_result
	

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
proctype readMap87(Mutexdef r_Diff_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_r_Diff_Attributes = -2; // opt var_r_Diff_Attributes
	

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
proctype readSet177(Mutexdef r_Diff_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Len907 = [1] of {int};
	chan child_Add744 = [1] of {int};
	chan child_ReadField423 = [1] of {int};
	chan child_Add746 = [1] of {int};
	chan child_ReadField425 = [1] of {int};
	Mutexdef set_once_m;
	int var_r_Diff_Attributes = -2; // opt var_r_Diff_Attributes
	run mutexMonitor(set_once_m);
	

	if
	:: var_r_Diff_Attributes-1 != -3 -> 
				for(i : 0.. var_r_Diff_Attributes-1) {
			for30: skip;
			

			if
			:: true -> 
				goto for30_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for30_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for30_end
			:: true;
			fi;
			run ReadField42(r_Diff_mu,child_ReadField423);
			child_ReadField423?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			run Add74(set_once_m,child_Add744);
			child_Add744?0;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for33: skip;
			

			if
			:: true -> 
				goto for33_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for33_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for33_end
			:: true;
			fi;
			run ReadField42(r_Diff_mu,child_ReadField425);
			child_ReadField425?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			run Add74(set_once_m,child_Add746);
			child_Add746?0;
			for33_end: skip
		:: true -> 
			break
		od;
		for33_exit: skip
	fi;
	run Len90(set_once_m,child_Len907);
	child_Len907?0;
	

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
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Add74(Mutexdef s_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_add1954 = [1] of {int};
	run add195(s_once_m,child_add1954);
	child_add1954?0;
	stop_process: skip;
	child!0
}
proctype add195(Mutexdef s_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_hash2204 = [1] of {int};
	run hash220(s_once_m,child_hash2204);
	child_hash2204?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype hash220(Mutexdef s_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Len90(Mutexdef s_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype readObjectField234(Mutexdef r_Diff_mu;int var_schema;chan child) {
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

proctype receiver(chan c) {
c?0
}

