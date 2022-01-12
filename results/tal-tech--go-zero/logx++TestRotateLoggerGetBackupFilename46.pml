// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/logx/rotatelogger_test.go#L46
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRotateLoggerGetBackupFilename460 = [1] of {int};
	run TestRotateLoggerGetBackupFilename46(child_TestRotateLoggerGetBackupFilename460);
	run receiver(child_TestRotateLoggerGetBackupFilename460)
stop_process:skip
}

proctype TestRotateLoggerGetBackupFilename46(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getBackupFilename1731 = [1] of {int};
	chan child_getBackupFilename1730 = [1] of {int};
	Mutexdef logger_closeOnce_m;
	Wgdef logger_waitGroup;
	run wgMonitor(logger_waitGroup);
	run mutexMonitor(logger_closeOnce_m);
	run getBackupFilename173(logger_waitGroup,logger_closeOnce_m,child_getBackupFilename1730);
	child_getBackupFilename1730?0;
	run getBackupFilename173(logger_waitGroup,logger_closeOnce_m,child_getBackupFilename1731);
	child_getBackupFilename1731?0;
	stop_process: skip;
	child!0
}
proctype getBackupFilename173(Wgdef l_waitGroup;Mutexdef l_closeOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

