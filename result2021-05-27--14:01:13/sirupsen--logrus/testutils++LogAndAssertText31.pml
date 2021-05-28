// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/sirupsen/logrus/blob/b50299cfaaa1bca85be76c8984070e846c7abfd2/internal/testutils/testutils.go#L31
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_LogAndAssertText310 = [1] of {int};
	run LogAndAssertText31(child_LogAndAssertText310);
	run receiver(child_LogAndAssertText310)
stop_process:skip
}

proctype LogAndAssertText31(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef logger_mu_lock;
	int strings_Split_strings_TrimRight_buffer_String___"\n"__" "_ = -2; // opt strings_Split_strings_TrimRight_buffer_String___"\n"__" "_
	run mutexMonitor(logger_mu_lock);
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

