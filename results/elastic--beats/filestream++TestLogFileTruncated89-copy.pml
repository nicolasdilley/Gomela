// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//filebeat/input/filestream/filestream_test.go#L89
#define ub_for104_2  -2
#define ub_for131_2  -2
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
	chan child_TestLogFileTruncated890 = [1] of {int};
	run TestLogFileTruncated89(child_TestLogFileTruncated890);
	run receiver(child_TestLogFileTruncated890)
stop_process:skip
}

proctype TestLogFileTruncated89(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_readUntilError1281 = [1] of {int};
	chan child_Read1010 = [1] of {int};
	Mutexdef reader_tg_initOnce_m;
	Wgdef reader_tg_wg_wg;
	Mutexdef reader_tg_wg_mu;
	Mutexdef reader_tg_mu;
	run mutexMonitor(reader_tg_mu);
	run mutexMonitor(reader_tg_wg_mu);
	run wgMonitor(reader_tg_wg_wg);
	run mutexMonitor(reader_tg_initOnce_m);
	run Read101(reader_tg_wg_wg,reader_tg_initOnce_m,reader_tg_mu,reader_tg_wg_mu,child_Read1010);
	child_Read1010?0;
	run readUntilError128(reader_tg_wg_wg,reader_tg_initOnce_m,reader_tg_mu,reader_tg_wg_mu,child_readUntilError1281);
	child_readUntilError1281?0;
	stop_process: skip;
	child!0
}
proctype Read101(Wgdef f_tg_wg_wg;Mutexdef f_tg_initOnce_m;Mutexdef f_tg_mu;Mutexdef f_tg_wg_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_errorChecks2241 = [1] of {int};
	chan child_errorChecks2240 = [1] of {int};
	

	if
	:: 0 != -2 && ub_for104_2 != -2 -> 
				for(i : 0.. ub_for104_2) {
			for11: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			run errorChecks224(f_tg_wg_wg,f_tg_initOnce_m,f_tg_mu,f_tg_wg_mu,child_errorChecks2241);
			child_errorChecks2241?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			run errorChecks224(f_tg_wg_wg,f_tg_initOnce_m,f_tg_mu,f_tg_wg_mu,child_errorChecks2240);
			child_errorChecks2240?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype errorChecks224(Wgdef f_tg_wg_wg;Mutexdef f_tg_initOnce_m;Mutexdef f_tg_mu;Mutexdef f_tg_wg_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_handleEOF2330 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run handleEOF233(f_tg_wg_wg,f_tg_initOnce_m,f_tg_mu,f_tg_wg_mu,child_handleEOF2330);
	child_handleEOF2330?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype handleEOF233(Wgdef f_tg_wg_wg;Mutexdef f_tg_initOnce_m;Mutexdef f_tg_mu;Mutexdef f_tg_wg_mu;chan child) {
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
proctype readUntilError128(Wgdef reader_tg_wg_wg;Mutexdef reader_tg_initOnce_m;Mutexdef reader_tg_mu;Mutexdef reader_tg_wg_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Read1013 = [1] of {int};
	chan child_Read1012 = [1] of {int};
	chan child_Read1011 = [1] of {int};
	run Read101(reader_tg_wg_wg,reader_tg_initOnce_m,reader_tg_mu,reader_tg_wg_mu,child_Read1011);
	child_Read1011?0;
	

	if
	:: 0 != -2 && ub_for131_2 != -2 -> 
				for(i : 0.. ub_for131_2) {
			for21: skip;
			run Read101(reader_tg_wg_wg,reader_tg_initOnce_m,reader_tg_mu,reader_tg_wg_mu,child_Read1013);
			child_Read1013?0;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run Read101(reader_tg_wg_wg,reader_tg_initOnce_m,reader_tg_mu,reader_tg_wg_mu,child_Read1012);
			child_Read1012?0;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
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

