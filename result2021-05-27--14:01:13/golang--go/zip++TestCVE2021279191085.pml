// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/archive/zip/reader_test.go#L1085
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCVE20212791910850 = [1] of {int};
	run TestCVE2021279191085(child_TestCVE20212791910850);
	run receiver(child_TestCVE20212791910850)
stop_process:skip
}

proctype TestCVE2021279191085(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Open7010 = [1] of {int};
	Mutexdef r_fileListOnce_m;
	run mutexMonitor(r_fileListOnce_m);
	run Open701(r_fileListOnce_m,child_Open7010);
	child_Open7010?0;
	stop_process: skip;
	child!0
}
proctype Open701(Mutexdef r_fileListOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_openLookup7351 = [1] of {int};
	chan child_initFileList6730 = [1] of {int};
	run initFileList673(r_fileListOnce_m,child_initFileList6730);
	child_initFileList6730?0;
	run openLookup735(r_fileListOnce_m,child_openLookup7351);
	child_openLookup7351?0;
	

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
proctype initFileList673(Mutexdef r_fileListOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int dirs = -2; // opt dirs
	int r_File = -2; // opt r_File
	stop_process: skip;
	child!0
}
proctype openLookup735(Mutexdef r_fileListOnce_m;chan child) {
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

