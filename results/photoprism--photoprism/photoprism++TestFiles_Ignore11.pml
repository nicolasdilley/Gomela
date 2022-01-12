// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/photoprism/files_test.go#L11
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFiles_Ignore110 = [1] of {int};
	run TestFiles_Ignore11(child_TestFiles_Ignore110);
	run receiver(child_TestFiles_Ignore110)
stop_process:skip
}

proctype TestFiles_Ignore11(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Ignore7618 = [1] of {int};
	chan child_Ignore7617 = [1] of {int};
	chan child_Ignore7616 = [1] of {int};
	chan child_Ignore7615 = [1] of {int};
	chan child_Ignore7614 = [1] of {int};
	chan child_Ignore7613 = [1] of {int};
	chan child_Ignore7612 = [1] of {int};
	chan child_Ignore7611 = [1] of {int};
	chan child_Ignore7610 = [1] of {int};
	chan child_Ignore769 = [1] of {int};
	chan child_Ignore768 = [1] of {int};
	chan child_Ignore767 = [1] of {int};
	chan child_Ignore766 = [1] of {int};
	chan child_Ignore765 = [1] of {int};
	chan child_Ignore764 = [1] of {int};
	chan child_Ignore763 = [1] of {int};
	chan child_Ignore762 = [1] of {int};
	chan child_Ignore761 = [1] of {int};
	chan child_Init290 = [1] of {int};
	Mutexdef files_mutex;
	run mutexMonitor(files_mutex);
	run Init29(files_mutex,child_Init290);
	child_Init290?0;
	run Ignore76(files_mutex,child_Ignore761);
	child_Ignore761?0;
	run Ignore76(files_mutex,child_Ignore762);
	child_Ignore762?0;
	run Ignore76(files_mutex,child_Ignore763);
	child_Ignore763?0;
	run Ignore76(files_mutex,child_Ignore764);
	child_Ignore764?0;
	run Ignore76(files_mutex,child_Ignore765);
	child_Ignore765?0;
	run Ignore76(files_mutex,child_Ignore766);
	child_Ignore766?0;
	run Ignore76(files_mutex,child_Ignore767);
	child_Ignore767?0;
	run Ignore76(files_mutex,child_Ignore768);
	child_Ignore768?0;
	run Ignore76(files_mutex,child_Ignore769);
	child_Ignore769?0;
	run Ignore76(files_mutex,child_Ignore7610);
	child_Ignore7610?0;
	run Ignore76(files_mutex,child_Ignore7611);
	child_Ignore7611?0;
	run Ignore76(files_mutex,child_Ignore7612);
	child_Ignore7612?0;
	run Ignore76(files_mutex,child_Ignore7613);
	child_Ignore7613?0;
	run Ignore76(files_mutex,child_Ignore7614);
	child_Ignore7614?0;
	run Ignore76(files_mutex,child_Ignore7615);
	child_Ignore7615?0;
	run Ignore76(files_mutex,child_Ignore7616);
	child_Ignore7616?0;
	run Ignore76(files_mutex,child_Ignore7617);
	child_Ignore7617?0;
	run Ignore76(files_mutex,child_Ignore7618);
	child_Ignore7618?0;
	stop_process: skip;
	child!0
}
proctype Init29(Mutexdef m_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	m_mutex.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true -> 
		goto defer1
	fi;
		defer1: skip;
	m_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Ignore76(Mutexdef m_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	m_mutex.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true -> 
		goto defer1
	fi;
		defer1: skip;
	m_mutex.Unlock!false;
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

