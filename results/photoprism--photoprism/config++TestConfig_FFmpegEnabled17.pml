// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/ffmpeg_test.go#L17
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_FFmpegEnabled170 = [1] of {int};
	run TestConfig_FFmpegEnabled17(child_TestConfig_FFmpegEnabled170);
	run receiver(child_TestConfig_FFmpegEnabled170)
stop_process:skip
}

proctype TestConfig_FFmpegEnabled17(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_FFmpegEnabled91 = [1] of {int};
	chan child_FFmpegEnabled90 = [1] of {int};
	Mutexdef c_db_values_mu;
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run mutexMonitor(c_db_values_mu);
	run FFmpegEnabled9(c_db_values_mu,c_once_m,child_FFmpegEnabled90);
	child_FFmpegEnabled90?0;
	run FFmpegEnabled9(c_db_values_mu,c_once_m,child_FFmpegEnabled91);
	child_FFmpegEnabled91?0;
	stop_process: skip;
	child!0
}
proctype FFmpegEnabled9(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DisableFFmpeg690 = [1] of {int};
	run DisableFFmpeg69(c_db_values_mu,c_once_m,child_DisableFFmpeg690);
	child_DisableFFmpeg690?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DisableFFmpeg69(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_FFmpegBin40 = [1] of {int};
	run FFmpegBin4(c_db_values_mu,c_once_m,child_FFmpegBin40);
	child_FFmpegBin40?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype FFmpegBin4(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
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

