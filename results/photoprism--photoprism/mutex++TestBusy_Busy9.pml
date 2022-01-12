// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/mutex/busy_test.go#L9
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBusy_Busy90 = [1] of {int};
	run TestBusy_Busy9(child_TestBusy_Busy90);
	run receiver(child_TestBusy_Busy90)
stop_process:skip
}

proctype TestBusy_Busy9(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Busy1410 = [1] of {int};
	chan child_Canceled569 = [1] of {int};
	chan child_Stop398 = [1] of {int};
	chan child_Busy147 = [1] of {int};
	chan child_Canceled566 = [1] of {int};
	chan child_Cancel475 = [1] of {int};
	chan child_Canceled564 = [1] of {int};
	chan child_Busy143 = [1] of {int};
	chan child_Start212 = [1] of {int};
	chan child_Canceled561 = [1] of {int};
	chan child_Busy140 = [1] of {int};
	Mutexdef b_mutex;
	run mutexMonitor(b_mutex);
	run Busy14(b_mutex,child_Busy140);
	child_Busy140?0;
	run Canceled56(b_mutex,child_Canceled561);
	child_Canceled561?0;
	run Start21(b_mutex,child_Start212);
	child_Start212?0;
	run Busy14(b_mutex,child_Busy143);
	child_Busy143?0;
	run Canceled56(b_mutex,child_Canceled564);
	child_Canceled564?0;
	run Cancel47(b_mutex,child_Cancel475);
	child_Cancel475?0;
	run Canceled56(b_mutex,child_Canceled566);
	child_Canceled566?0;
	run Busy14(b_mutex,child_Busy147);
	child_Busy147?0;
	run Stop39(b_mutex,child_Stop398);
	child_Stop398?0;
	run Canceled56(b_mutex,child_Canceled569);
	child_Canceled569?0;
	run Busy14(b_mutex,child_Busy1410);
	child_Busy1410?0;
	stop_process: skip;
	child!0
}
proctype Busy14(Mutexdef b_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	b_mutex.Lock!false;
	goto defer1;
		defer1: skip;
	b_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Canceled56(Mutexdef b_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	b_mutex.Lock!false;
	goto defer1;
		defer1: skip;
	b_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Start21(Mutexdef b_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	b_mutex.Lock!false;
	

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
	goto defer1;
		defer1: skip;
	b_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Cancel47(Mutexdef b_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	b_mutex.Lock!false;
		defer1: skip;
	b_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Stop39(Mutexdef b_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	b_mutex.Lock!false;
		defer1: skip;
	b_mutex.Unlock!false;
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

